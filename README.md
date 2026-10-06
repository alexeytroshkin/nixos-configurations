# NixOS configurations

One locked flake defines Andromeda (laptop), Hydra (desktop), and Corvus
(Raspberry Pi). Home Manager runs as part of the NixOS configuration.

```text
hosts/<host>/configuration.nix       Host-specific system configuration
hosts/<host>/hardware-configuration.nix
hosts/<host>/home.nix                Host-specific Home Manager configuration
modules/nixos/                      Reusable NixOS modules
modules/home/                       Reusable Home Manager modules and helpers
modules/home/obsidian/vaults/        Explicitly selected vault configurations
```

Hosts import only the capabilities they need. Reusable application modules do
not select machine-specific data directories. For example, Andromeda imports
the Obsidian application and Expansion vault modules and sets the Spectrum
vault path in its `home.nix`. Hydra imports only the application for now.

The shared Niri modules contain our settings. Hosts also import upstream Niri,
dank-greeter, and DMS modules explicitly so their import order remains stable.

Build without activating:

```sh
nix build --no-update-lock-file --no-link path:.#nixosConfigurations.hydra.config.system.build.toplevel
```

Deploy through SSH, with an optional address distinct from the flake name:

```sh
just rebuild dry-activate hydra 192.168.8.129
just rebuild boot hydra 192.168.8.129
```

The recipe uses the locked nixpkgs input and a path flake, so newly created
files can be evaluated before committing them. It does not update inputs.

See [Hydra setup and storage constraints](docs/hydra.md) before deploying to
the desktop. `AGENTS.md` records the Windows disk boundary for future work.
