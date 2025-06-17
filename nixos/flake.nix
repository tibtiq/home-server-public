{
  description = "My NixOS Configuration";

  inputs = {
    # Nixpkgs and flake-utils
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.proxmox_lxc_fresh = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./proxmox_lxc.nix
        ];
      };
    };
}