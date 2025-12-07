{
  modulesPath,
  config,
  pkgs,
  inputs,
  ...
}: let
  hostname = "nixos";
  user = "tibtiq";
  password = "somepass";
  ssh_keys = builtins.fetchurl {
    url = "https://github.com/tibtiq.keys";
    sha256 = "01b5i1bvbpvlr8qzcqpb155qaiiij2xnwkwifrwbf3vki62i9npi";
  };
in {
  imports = [
    # Include the default lxc/lxd configuration.
    "${modulesPath}/virtualisation/lxc-container.nix"
  ];

  boot.isContainer = true;
  networking.hostName = hostname;

  environment.systemPackages = with pkgs; [
    vim   # text editor
    git   # source version control
    tmux  # tui for git
  ];

  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      password = password;
      openssh.authorizedKeys.keyFiles = [
        ssh_keys
      ];
      extraGroups = ["wheel"];
    };
  };

  # Enable passwordless sudo.
  security.sudo.extraRules = [
    {
      users = [user];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  # Supress systemd units that don't work because of LXC.
  # https://blog.xirion.net/posts/nixos-proxmox-lxc/#configurationnix-tweak
  systemd.suppressedSystemUnits = [
    "dev-mqueue.mount"
    "sys-kernel-debug.mount"
    "sys-fs-fuse-connections.mount"
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "24.05";
}
