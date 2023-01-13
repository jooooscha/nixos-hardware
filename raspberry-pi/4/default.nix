{ lib, pkgs, ...}:

{
  imports = [
    ./audio.nix
    ./cpu-revision.nix
    ./dwc2.nix
    ./i2c.nix
    ./modesetting.nix
    ./poe-hat.nix
    ./poe-plus-hat.nix
    ./tc358743.nix
    ./pwm0.nix
    ./pkgs-overlays.nix
  ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_rpi4;
    initrd.availableKernelModules = [
      "usbhid"
      "usb_storage"
      "vc4"
      "pcie_brcmstb"      # required for the pcie bus to work
      "reset-raspberrypi" # required for vl805 firmware to load
    ];

    loader = {
      grub.enable = lib.mkDefault false;
      generic-extlinux-compatible.enable = lib.mkDefault true;
    };
  };

  # hardware.deviceTree.filter = "*-rpi-*.dtb";

  # Required for the Wireless firmware
  hardware.enableRedistributableFirmware = true;
}
