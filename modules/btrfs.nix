{
  fileSystems."/".options = [ "compress=zstd" "noatime" ];
  fileSystems."/nix".options = [ "compress=zstd" "noatime" ];

  services.fstrim.enable = true;

  boot.supportedFilesystems = [ "btrfs" ];
}
