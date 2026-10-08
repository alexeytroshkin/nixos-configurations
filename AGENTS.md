# Repository instructions

## Hydra storage boundary

- Hydra is a dual-boot PC with NixOS and Windows on separate NVMe disks.
- The Windows disk is Samsung SSD 970 EVO Plus 500GB, serial
  `S4EVNM0T800393E`, WWN `eui.00253858219028c4`. Never modify, format,
  repartition, mount, or install a bootloader onto this disk or any partition.
- Device names such as `nvme0n1` can change; identify disks by serial/WWN.
- NixOS is on AGI512G44AI818, serial `AGIPEFWWK0402177`.
- The only configured disk filesystems for Hydra are root UUID
  `db4ff489-583a-46ef-8de8-700cdde7ee4d` and EFI UUID `DD0E-90AB` at `/boot`.
- Preserve Windows EFI files already present on the NixOS EFI partition.
  Preserve existing firmware boot entries; do not enable EFI variable writes.
- Do not use disk provisioning tools for Hydra. It already has installed NixOS.

## Configuration layout

- Host-specific NixOS settings live in `hosts/<hostname>/configuration.nix`;
  host-specific Home Manager settings live in `hosts/<hostname>/home.nix`.
- Reusable NixOS modules live in `modules/nixos`, Home Manager modules in
  `modules/home`. Shared application modules must not select host-specific vaults.
- Preserve Andromeda and Corvus behavior when moving modules. Compare their
  evaluated system derivations before and after structural changes.
- Keep `flake.lock` unchanged unless an input update is explicitly requested.
- Never store passwords or private keys in the repository.

## Niri ownership

- Permanent Niri settings belong to Nix; only DMS's dynamic `colors.kdl` is
  included normally. Other DMS fragments are for explicit UI experiments.
- Preserve host shortcuts and window behavior when migrating desktop settings.
- Monitor settings live in `hosts/<hostname>/monitor.nix`. Greeter outputs are
  rendered from evaluated Home Manager outputs; do not duplicate their values.
- Andromeda's internal panel is enabled when its external Samsung display is
  absent or disabled. Preserve this policy in the greeter and user session.
