{ config, pkgs, ... }:

{
  imports = [
    ../modules/proxmox_lxc.nix
  ];

  networking.hostName = "proxmox_lxc_fresh";
  system.stateVersion = "24.05";

  users.users.tibtiq = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  services.openssh.enable = true;
}
