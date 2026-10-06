{ config, lib, ... }:
let
  actions = config.lib.niri.actions;
  dms = target: method: actions.spawn "dms" "ipc" "call" target method;
in
{
  # Baseline shortcuts also work before DMS creates any custom bindings.
  programs.niri.settings.binds =
    with actions;
    {
      "Mod+T" = {
        action = spawn "ghostty";
        hotkey-overlay.title = "Open Terminal";
      };
      "Mod+Return".action = spawn "ghostty";
      "Mod+Space" = {
        action = dms "spotlight" "toggle";
        hotkey-overlay.title = "Application Launcher";
      };
      "Mod+Comma".action = dms "settings" "focusOrToggle";
      "Mod+N".action = dms "notifications" "toggle";
      "Mod+V".action = dms "clipboard" "toggle";
      "Mod+Alt+L".action = dms "lock" "lock";
      "Mod+X".action = dms "powermenu" "toggle";
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+D" = {
        action = toggle-overview;
        repeat = false;
      };
      "Mod+Tab" = {
        action = toggle-overview;
        repeat = false;
      };
      "Mod+Q" = {
        action = close-window;
        repeat = false;
      };
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Shift+T".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
      "Mod+W".action = toggle-column-tabbed-display;
      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+C".action = center-column;
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-up;
      "Mod+Down".action = focus-window-down;
      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+K".action = focus-window-up;
      "Mod+J".action = focus-window-down;
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-window-up;
      "Mod+Shift+Down".action = move-window-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Shift+Page_Up".action = move-column-to-workspace-up;
      "Mod+Shift+Page_Down".action = move-column-to-workspace-down;
      "Print".action.screenshot = { };
      "Ctrl+Print".action.screenshot-screen = { };
      "Alt+Print".action.screenshot-window = { };
      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action = spawn "wpctl" "set-volume" "--limit" "1.0" "@DEFAULT_AUDIO_SINK@" "5%+";
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
      };
    }
    // lib.listToAttrs (
      lib.concatMap (index: [
        {
          name = "Mod+${toString index}";
          value.action = actions.focus-workspace index;
        }
        {
          name = "Mod+Shift+${toString index}";
          value.action.move-column-to-workspace = index;
        }
      ]) (lib.range 1 9)
    );
}
