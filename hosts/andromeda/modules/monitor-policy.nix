{ lib, pkgs, ... }:
let
  monitor = import ../monitor.nix;
  policy = pkgs.writeShellApplication {
    name = "andromeda-monitor-policy";
    runtimeInputs = [
      pkgs.niri-unstable
      pkgs.jq
    ];
    text = ''
      # Niri's event stream does not expose output hotplug events in this version.
      # Only change the internal panel when necessary; leave mode and scale to Nix.
      while output_state="$(niri msg --json outputs 2>/dev/null)"; do
        internal_name="$(jq -r --arg id ${lib.escapeShellArg monitor.internal} '
          .[] | select(([.make, .model, (.serial // "Unknown")] | join(" ")) == $id) | .name
        ' <<< "$output_state")"
        if [[ -n "$internal_name" ]]; then
          external_active="$(jq --arg id ${lib.escapeShellArg monitor.external} '
            any(.[]; ([.make, .model, (.serial // "Unknown")] | join(" ")) == $id and .current_mode != null)
          ' <<< "$output_state")"
          internal_active="$(jq --arg name "$internal_name" '.[$name].current_mode != null' <<< "$output_state")"
          if [[ "$external_active" == true && "$internal_active" == true ]]; then
            niri msg output "$internal_name" off
          elif [[ "$external_active" == false && "$internal_active" == false ]]; then
            niri msg output "$internal_name" on
          fi
        fi
        sleep 2
      done
    '';
  };
in
{
  # Use the same policy at the login screen and in the authenticated session.
  environment.etc."greetd/niri_overrides.kdl".text = lib.mkAfter ''
    spawn-at-startup "${lib.getExe policy}"
  '';
  systemd.user.services.andromeda-monitor-policy = {
    description = "Use the laptop panel when the external monitor is unavailable";
    after = [ "niri.service" ];
    partOf = [ "niri.service" ];
    wantedBy = [ "niri.service" ];
    serviceConfig = {
      ExecStart = lib.getExe policy;
      Restart = "on-failure";
      RestartSec = 2;
    };
  };
}
