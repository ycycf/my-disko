{
  description = "My NixOS with disko + btrfs + snapper";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }:
  let
    system = "x86_64-linux";
  in {
    diskoConfigurations.default = import ./disko/default.nix;

    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/ycf-omno/configuration.nix

        disko.nixosModules.disko
        ./disko/default.nix

        ./modules/btrfs.nix
        ./modules/snapper.nix
      ];
    };
  };
}
