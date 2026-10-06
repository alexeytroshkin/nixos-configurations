{ lib, config, ... }:
let
  nixosDevices = [
    "/dev/disk/by-uuid/db4ff489-583a-46ef-8de8-700cdde7ee4d"
    "/dev/disk/by-uuid/DD0E-90AB"
  ];
in
{
  # Samsung SSD 970 EVO Plus: the entire disk and all its partitions belong
  # to Windows. Serial matching survives changes in nvme device numbering.
  services.udev.extraRules = ''
    SUBSYSTEM=="block", ATTRS{serial}=="S4EVNM0T800393E", ENV{UDISKS_IGNORE}="1", ENV{UDISKS_AUTO}="0"
  '';

  assertions = [
    {
      assertion = lib.all (fs: builtins.elem fs.device nixosDevices) (
        builtins.attrValues config.fileSystems
      );
      message = "hydra may only declare filesystems on its NixOS NVMe; the Windows disk must stay untouched.";
    }
    {
      assertion = config.swapDevices == [ ];
      message = "hydra has no disk swap; do not allocate swap on the Windows disk.";
    }
    {
      assertion = !config.boot.loader.grub.enable && !config.boot.loader.efi.canTouchEfiVariables;
      message = "hydra must preserve existing firmware entries and use systemd-boot on the NixOS EFI partition.";
    }
    {
      assertion = config.boot.loader.systemd-boot.windows == { };
      message = "Choose Windows through the existing boot menu; do not configure its disk from NixOS.";
    }
  ];
}
