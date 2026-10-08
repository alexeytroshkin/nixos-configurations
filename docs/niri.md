# Niri configuration ownership

Permanent compositor settings are declared in Nix. DMS retains its panel,
launcher, wallpaper, dynamic palette and session state. Its only regular
compositor include is `dms/colors.kdl`.

## Sources

- `modules/home/desktop/niri.nix`: shared input, layout, cursor and rules.
- `hosts/andromeda/modules/niri.nix`: laptop layout and existing blur/opacity.
- `hosts/andromeda/modules/niri-keybinds.nix`: all 132 existing laptop shortcuts.
- `modules/home/desktop/niri-keybinds.nix`: Hydra's existing baseline shortcuts.
- `hosts/<host>/monitor.nix`: monitor identities, modes, scales and layout.
- `hosts/andromeda/modules/monitor-policy.nix`: enable the laptop panel when the
  external Samsung is absent or disabled; disable it while Samsung is active.

Home Manager generates `~/.config/niri/hm.kdl` and a `config.kdl` that includes
it and the DMS palette. Andromeda also includes an immutable, Nix-generated
`andromeda-effects.kdl`: the pinned niri-flake schema does not expose its
existing per-window noise/saturation options.

These generated files are symlinks into `/nix/store`. Change their Nix sources,
build/validate and apply the generation. Replacing a link with an ordinary file
does not update the source and can conflict with the next activation.
Existing writable DMS fragments and custom laptop files are retained locally
for comparison and rollback, but are no longer included.

The NixOS desktop module renders output nodes from the evaluated Home Manager
configuration into `/etc/greetd/niri_overrides.kdl`. The greeter includes these
alongside its own default configuration. Monitor values are defined once.
Andromeda runs the same panel policy at the login screen and in the user session.
The policy checks outputs every two seconds because the pinned Niri event stream
does not expose output hotplug events. It matches EDID identities, changes the
panel state only when necessary, and leaves modes/scales to Nix.

Hydra keeps Xiaomi DisplayPort at 3440x1440 @ 144 Hz, scale 1, with duplicate
HDMI disabled. Desktop changes do not alter its Windows storage or boot policy.

## UI experiments

The DMS UI does not update Nix sources. Cursor/layout/keybind changes write DMS
fragments ignored by the normal configuration. Display controls can still change
a running Niri instance directly over IPC, without updating Nix or the greeter.

Temporarily enable only the fragments needed for an experiment in the host home
configuration, for example:

```nix
programs.dank-material-shell.niri.includes.filesToInclude = [ "cursor" ];
```

This adds `cursor` to the shared `colors` include. The upstream module includes
DMS fragments after `hm.kdl`, allowing the selected settings to override Nix.
Build/apply, try the UI, inspect the generated fragment and transfer chosen values
into Nix. Remove the experimental include and apply again. DMS may retain the
choice in its own JSON: its UI state does not prove that Niri uses that value.
Restore the DMS choice as appropriate; do not import whole settings/session files.

The laptop panel policy remains active during display experiments. Stop its user
service temporarily if testing a different policy, then start it again:

```sh
systemctl --user stop andromeda-monitor-policy
systemctl --user start andromeda-monitor-policy
```

## Validation and deployment

Use `path:.` to include new files before committing, and preserve the lock:

```sh
nix build --offline --no-update-lock-file --no-link path:.#nixosConfigurations.andromeda.config.system.build.toplevel
nix build --offline --no-update-lock-file --no-link path:.#nixosConfigurations.hydra.config.system.build.toplevel
niri validate
```

Offline builds require cached dependencies. Niri reloads config changes without
restarting the graphical session. Greeter changes apply at its next start; do not
restart greetd during a logged-in session just to apply compositor settings.
Build and validate Hydra locally while it is off; deploy and verify after startup.
