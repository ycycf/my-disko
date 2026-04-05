{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # ===== 内核模块 =====
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  boot.kernelModules = [ "kvm-intel" ];

  # ===== CPU 微码（推荐）=====
  hardware.cpu.intel.updateMicrocode = true;

  # ===== 不要定义 fileSystems！=====
  # fileSystems = ... ❌ 删除或不要写

  # swap（如果不用 swap 分区）
  swapDevices = [];
}
