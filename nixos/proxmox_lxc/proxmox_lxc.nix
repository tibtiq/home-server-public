{
  modulesPath,
  config,
  pkgs,
  inputs,
  ...
}: let
  hostname = "storage";
  user = "tibtiq";
  GITHUB_SSH_KEYS = builtins.fetchurl {
    url = "https://github.com/tibtiq.keys";
    sha256 = "1nha9g5s4zyfbwmza0n3kbsmnx38w0xzsrzyrq4bcywzf0hc42zx";
  };
in {
  imports = [
    # Include the default lxc/lxd configuration.
    "${modulesPath}/virtualisation/lxc-container.nix"
  ];
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
      openssh.authorizedKeys.keyFiles = [
        GITHUB_SSH_KEYS
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
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "24.05";
}
