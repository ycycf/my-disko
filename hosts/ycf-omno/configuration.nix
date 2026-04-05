{ config, pkgs, lib, ... }:

{
  imports = [
    # 硬件
    ./hardware-configuration.nix

    # 磁盘（disko）
    ../../disko/default.nix

    # 模块
    ../../modules/btrfs.nix
    ../../modules/snapper.nix
  ];

  # ===== 基本系统 =====
  system.stateVersion = "24.11";

  networking.hostName = "ycf";

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "zh_CN.UTF-8";

  # ===== 引导 =====
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ===== 用户 =====
  users.users.ycf = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "123456"; # 安装后记得改
  };

  # ===== 常用软件 =====
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    htop
  ];

  # ===== SSH（可选）=====
  services.openssh.enable = true;

  # ===== Nix 优化 =====
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
