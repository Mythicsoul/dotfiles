{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    # ./boot.nix
    ./modules/nvidia.nix
    ./modules/services.nix
  ];

  boot.kernelModules = [
    "hid-logitech-dj"
  ];
  # systemd.tpm2.enable = false; # uncomment if persists https://discourse.nixos.org/t/a-start-job-is-runnning-for-dev-tpmr0/56089
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot";
    };
    grub = {
      device = "nodev";
      enable = true;
      efiSupport = true;
      useOSProber = true;
      efiInstallAsRemovable = true;
    };
    timeout = 10;
  };

  fileSystems."/mnt/data" = {
    depends = [ "/" ];
    device = "/dev/disk/by-uuid/71bbc88e-a351-413a-9819-61f43faa03a4";
    fsType = "ext4";
    options = [
      "rw"
      "nosuid"
      "nodev"
      "nofail"
    ];
  };

  networking.hostName = "nix-dome";
  networking.firewall.allowedTCPPorts = [ 8384 ]; # syntching web UI
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  networking.networkmanager.plugins = [
    pkgs.networkmanager-openvpn
  ];
  # networking.nameservers = [
  #   "1.1.1.1"
  #   "8.8.8.8"
  #   "2606:4700:4700::1111"
  #   "2606:4700:4700::1001"
  # ];
  #
  services.resolved = {
    enable = true;
    domains = [ "~." ]; # Use global DNS for all queries
    extraConfig = ''
      DNS=1.1.1.1 1.0.0.1 8.8.8.8 2606:4700:4700::1111 2606:4700:4700::1001
      DNSSEC=allow-downgrade
      DNSOverTLS=opportunistic
    '';
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
    LC_MESSAGES = "en_GB.UTF-8";
  };

  # TTY user login
  services.xserver.displayManager.startx.enable = true;

  services.xserver = {
    xkb.layout = "de,gr,ru";
    xkb.variant = ",,phonetic";
  };

  console.keyMap = "de";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.mythicsoul = {
    isNormalUser = true;
    description = "mythicsoul";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Enable Flakes
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # fixes https://github.com/NixOS/nix/issues/11728
    download-buffer-size = 524288000;
  };

  nixpkgs.config.allowUnfree = true;

  # using firefox pkg from unstable to get a more recent version of widevine
  # nixpkgs.overlays = let
  #   nixos-unstable = import <nixos-unstable> {};
  # in [
  #     (final: prev: {
  #         inherit (nixos-unstable.pkgs) firefox;
  #     })
  # ];

  environment.systemPackages = with pkgs; [
    ## desktop ##
    hyprpaper
    rofi
    rofi-power-menu
    dunst
    wl-clipboard
    cliphist
    grim
    slurp
    power-profiles-daemon
    lm_sensors
    playerctl
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default # maybe put inside home-manager
    hyprsunset
    # hyprlock TODO
    # hypridle
    hyprpolkitagent
    clipse
    networkmanagerapplet

    ## programs ##
    chatterino2
    fsearch
    vlc
    syncthingtray
    gnome-text-editor
    gnome-disk-utility
    nautilus
    gnome-system-monitor
    gnome-characters
    gnome-calendar
    gnome-calculator
    baobab
    nomacs
    gimp3
    lmms
    xfce.thunar
    streamlink
    mpv
    easyeffects
    pwvucontrol
    keepassxc
    xournalpp
    gparted
    nvidia-system-monitor-qt
    discord
    inputs.vasciipp.packages.${pkgs.stdenv.hostPlatform.system}.default
    protonvpn-gui
    warehouse
    solaar
    libnotify

    ## utils ##
    wev
    jq
    catimg
    btop
    nvitop
    ffmpeg
    yt-dlp
    gifski
    killall
    tree
    pamixer
    ntfs3g
    p7zip
    unzip
    nix-prefetch-git
    ncdu
    mesa-demos
    gphoto2
    dig

    # grub2
    # os-prober

    ## dev ##
    nil
    clang-tools
    cmake
    pkg-config
    gcc
    cmake-language-server
    gnumake
    gdb
    nixfmt-rfc-style # nix formatter
    python3Packages.python-lsp-server
    bash-language-server
    # haskellPackages.haskell-language-server
    # haskell.compiler.native-bignum.ghc982
    # wineWowPackages.waylandFull
    

    ## gaming ##
    lutris
    mangohud
    goverlay
    osu-lazer-bin
    winetricks

  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.inconsolata
      nerd-fonts.jetbrains-mono

      # fixing cs2 pango errors
      nerd-fonts.caskaydia-cove # fallback
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      # extra?
      nerd-fonts.blex-mono
      nerd-fonts.geist-mono
      nerd-fonts."m+"
      nerd-fonts.d2coding

      nerd-fonts.noto
      nerd-fonts.symbols-only
    ];
    fontDir.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # programs.ssh.startAgent = true;
  security.polkit.enable = true;

  services.flatpak.enable = true;
  services.syncthing = {
    enable = true;
    relay.enable = true;
    configDir = "/home/mythicsoul/.config/syncthing";
    user = "mythicsoul";
    group = "users";
    systemService = true;
    openDefaultPorts = true;
  };
  services.power-profiles-daemon.enable = true;
  services.dbus.implementation = "broker"; # UWSM
  services.gvfs.enable = true;

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  hardware.logitech.wireless.enable = true;

  programs.nano.nanorc = ''
    set tabstospaces
    set tabsize 4
  '';
  programs.firefox.enable = true;
  programs.waybar.enable = true;
  programs.xwayland.enable = true;
  # programs.nm-applet.enable = true;
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraPackages = [
      pkgs.pango
      pkgs.gamescope
    ];
  };
  programs.zsh.enable = true;
  # programs.steam.gamescopeSession.enable = false;
  # programs.gamemode.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.Hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  #  on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
