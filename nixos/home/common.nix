{ config, lib, pkgs, ... }:

{
  home.username = "tibtiq";
  home.homeDirectory = "/home/tibtiq";

  # import all modules in configs directory
  imports = [
    ./configs
  ];

  # Let home-manager install and manage itself
  programs.home-manager.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  home = {
    enableDebugInfo = true;
  };

  programs = {
    direnv.enable = true;
    jq.enable = true;

    # Install man output for any Nix packages.
    man.enable = true;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
  ];

  programs.git = {
    enable = true;
    userName = "tibtiq";
    userEmail = "29826331+tibtiq@users.noreply.github.com";
  };
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # rebind pane splitting buttons
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # highlight active window
      setw -g window-status-current-style fg=brightgreen,bold
    '';
  };
  programs.bash = {
    enable = true;
    # todo figure out how to ls after cd
    initExtra = ''
      eval "$(zoxide init bash --cmd cd)"
    '';
    shellOptions = [
      "histappend" # append history, don't overwrite
    ];
    historySize = 10000;
    historyFileSize = 20000;
    # no duplicate entries
    historyControl = ["ignoredups" "erasedups"];
    shellAliases = {
      v = "nvim";
      rr = "sudo nixos-rebuild switch --flake ~/repos/home-server/nixos/lxc";
      repos = "cd ~/repos";
      cat = "bat";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      ls = "eza";
      ll = "eza -lah";
      l = "eza -lah";
      grep = "grep --color=always";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate --all";
      df = "df -h";
      du = "du -h";
    };
  };
}

