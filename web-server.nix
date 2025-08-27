# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  imports = [ 
      # home-manager as module
      <home-manager/nixos>
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  #networking.hosts = { "127.0.0.1" = [ "localhost" "nixos" "local" ]; };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_CH.UTF-8";

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.displayManager.defaultSession = "xfce";
  services.xserver.windowManager.i3.enable = true;
  
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ch";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "sg";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # webdevelopment
  # nginx is sandboxed and doesn't allow reading from /home
  systemd.services.nginx.serviceConfig = {
    ProtectSystem = lib.mkForce false;
    ProtectHome = lib.mkForce false;
  };

  services.nginx = {
    user = "demo"; # because all content is served locally in home for testing
    enable = true;
    recommendedGzipSettings = true;
    virtualHosts = {
      "localhost" = {
        root = "/home/demo/Websites";
        locations."/".extraConfig = "autoindex on;";
      };
      "local" = {
        default = true;
        root = "/home/demo/Websites";
        locations."/".extraConfig = "autoindex on;";
      };
      "nixos" = {
        # simple test for SPAs, that need to use / with normal history routing
        root = "/home/demo/Websites";
        locations."/".extraConfig = ''
          try_files $uri $uri/ /index.html;
          autoindex on;
        '';
      };
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # Install software
  programs = {
    # settings saved for some applications (gtk3 applications, firefox)
    dconf.enable = true;

    git.enable = true;
    git.lfs.enable = true;
    vim.enable = true;
    htop.enable = true;

    firefox.enable = true;
    chromium.enable = true;
    thunderbird.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # \$ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    btop
    file
    direnv
    file
    mkpasswd
    nano
    p7zip
    hyperfine
    tokei
    pciutils
    tcpdump
    nload
    fastfetch
    feh
    rofi

    thonny
    tigerjython
    p3x-onenote
    rakudo
    zef
    nodejs

# gdevelop
# fritzing
# https://veyon.io/de/ https://github.com/veyon/veyon/

    cmatrix
    obsidian
    jq
    cowsay
    fortune
    lolcat

    # Games
    oh-my-git
    wireworld
];


  # Define a user account.
  users.mutableUsers = false;
  nix.settings.trusted-users = [ "demo" ];
  users.users.demo = {
    isNormalUser = true;
    description = "user for CS clases";
    extraGroups = [ "networkmanager" "wheel" "video" "dialout" "vboxsf" ];
    # mkpasswd -m sha-512
    hashedPassword = "$6$rfbRiHox9teafYrN$m5ga/Vs74pAAobd9NLhCtFzCEOW5esIX19qnC7RO41H.XiF302/2AE8GUBZNOw60.sG.w2VBkuamKCBL.B8bg1";
    #packages = with pkgs; [
    #  kdePackages.kate
    #  thunderbird
    #];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "demo";
  #services.displayManager.sessionCommands = ''
  #       ${pkgs.xorg.xrandr}/bin/xrandr -s '1920x1080'
  #     '';

  home-manager.users.demo = { pkgs, ... }: {

    services.clipmenu.enable = true;
    nixpkgs.config.allowUnfree = true;

    programs.rofi = {
      enable = true;
      font = "Droid Sans Mono 18";
      cycle = true;
      modes = [
        "combi"
        "window"
        "drun"
      #  "run"
        "recursivebrowser"
      #  "filebrowser"
      #  "windowcd"
        "keys"
      #  "ssh"
      ];
      theme = "solarized";
      extraConfig = {
        combi-modes = "window,drun,keys,recursivebrowser";
        show-icons = true;
        dpi = 0;
        levenshtein-sort = true;
        fuzzy = true;
        sidebar-mode = true;
      };
    };

   programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
    programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
        yzhang.markdown-all-in-one
        ms-python.python
        donjayamanne.githistory
        mhutchie.git-graph
        davidanson.vscode-markdownlint
        bbenoist.nix
        ms-toolsai.jupyter
        github.copilot
        #bscan.perlnavigator
      ];

    home.file.".xprofile".text = ''
    #xrandr --output eDP-1 --mode 1920x1080 --dpi 120
    #xrandr --output HDMI-1 --mode 1920x1080 --dpi 120
    '';
    
    home.file.".Xresources".text = ''
    Xft.antialias: true
    Xft.dpi: 120
    '';

    #home.packages = [ pkgs.vscodium ];
  
    # This value determines the Home Manager release that your configuration is 
    # compatible with. This helps avoid breakage when a new Home Manager release 
    # introduces backwards incompatible changes. 
    #
    # You should not change this value, even if you update Home Manager. If you do 
    # want to update the value, then make sure to first check the Home Manager 
    # release notes. 
    home.stateVersion = "24.05"; # Please read the comment before changing. 

};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # default shell
  users.defaultUserShell = pkgs.zsh;
  programs = {
      zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestions.enable = true;
          syntaxHighlighting.enable = true;
          histSize = 10000;
          #histFile = "$HOME/.zsh_history";
          setOptions = [
            "HIST_IGNORE_ALL_DUPS"
          ];
          ohMyZsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [
              "git"
              "history"
              "sudo"
              "direnv"
            ];
          };
      };
  };

  #https://mynixos.com/options/networking.firewall
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 80 443 3306 ];
  #  allowedUDPPortRanges = [
  #    { from = 4000; to = 4007; }
  #    { from = 8000; to = 8010; }
  #  ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
