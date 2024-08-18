# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

# let 
#   nvdriver = pkgs.linuxPackages.nvidia_x11.overrideAttrs(oldAttrs: rec {
#     version ="555.58.02";
#     name = (builtins.parseDrvName oldAttrs.name).name + "-" + version;
#     src = pkgs.fetchurl {
#       url = "https://download.nvidia.com/XFree86/Linux-x86_64/${version}/NVIDIA-Linux-x86_64-${version}.run";
#       sha256 = "c5cb6de133d194e27aaf94b9e21e56e8f4faff7672d91e0048d14fbbc4d21ca3";
#     };
#     patches = [];
#   });
# in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_6;
  # Bootloader

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
  };
  
  hardware.opengl = {
	enable = true;
	driSupport = true;
	driSupport32Bit = true;
	extraPackages = with pkgs; [ libva ];
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
	  open = false;
	  nvidiaSettings = true;
	  package = config.boot.kernelPackages.nvidiaPackages.stable;
    # package = nvdriver;
  };


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    
    LC_ALL = "en_GB.UTF-8";

    # LC_ADDRESS = "de_DE.UTF-8";
    # LC_IDENTIFICATION = "de_DE.UTF-8";
    # LC_MEASUREMENT = "de_DE.UTF-8";
    # LC_MONETARY = "de_DE.UTF-8";
    # LC_NAME = "de_DE.UTF-8";
    # LC_NUMERIC = "de_DE.UTF-8";
    # LC_PAPER = "de_DE.UTF-8";
    # LC_TELEPHONE = "de_DE.UTF-8";
    # LC_TIME = "en_GB.UTF-8";
    # LC_MESSAGES = "en_GB.UTF-8";
  };
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.displayManager.startx.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
 users.defaultUserShell = pkgs.zsh;
  users.users.mythicsoul = {
    isNormalUser = true;
    description = "mythicsoul";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  firefox
    ];
  };

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
  [
    hyprland
    neofetch 
    kitty
    waybar
    rofi-wayland
    rofi-power-menu
    power-profiles-daemon
    hyprpaper
    dunst
    wl-clipboard
    cliphist
    grim
    slurp
    libnotify
    lm_sensors
    playerctl
    grub2
    chatterino2
    # mesa-demos
    spotify
    fsearch
    flatpak
    streamlink
    vlc
    os-prober
    git
    # gnomeExtensions.vitals
    # gnomeExtensions.appindicator
    # gnomeExtensions.nvidia-gpu-stats-tool
    # gnomeExtensions.dash-to-panel
    # steam
    firefox
    # gh
    syncthing
    syncthingtray
    qt6.qtwayland
    libsForQt5.qt5.qtwayland    
    gedit
    gnome.gnome-disk-utility
    gnome.nautilus
    gnome.gnome-system-monitor
    gnome.gnome-characters
    gnome.gnome-calendar
    gnome.gnome-calculator
    baobab
    pamixer
    nomacs
    keepassxc
    wev
    font-manager
    killall
    networkmanagerapplet
    jq
    gnome.adwaita-icon-theme
    catimg
    htop
    btop
    nvitop
    gimp
    lmms
    # neovim
    opentabletdriver
    # (vscode-with-extensions.override {
    #   vscode = vscodium;
    #   vscodeExtensions = with vscode-extensions; [
    #     ms-vscode.cpptools-extension-pack
    #     #twxs.cmake
    #     #vscode.cmake-tools
    #     #josetr.cmake-language-support-vscode
    #     bbenoist.nix
    #     arrterian.nix-env-selector
    #   ]; 
    # })
    # inputs.helix.packages."${pkgs.system}".helix
    nil
    clang-tools
    cmake
    gcc
    cmake-language-server
    gnumake
    xfce.thunar
];

  fonts.packages = with pkgs; [
    nerdfonts
  ];
  fonts.fontDir.enable = true;  


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  #  on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?


  programs.nano.nanorc = 
  ''
    set tabstospaces
    set tabsize 4
  '';

#  environment.etc."bashrc".text = 
#  ''
#    export PS1="\n\[\033[1;36m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] "
#    # set PATH so it includes user's private bin if it exists
#    if [ -d "$HOME/.local/bin" ] ; then
#        PATH="$HOME/.local/bin:$PATH"
#    fi
#  '';
#  environment.shellAliases = {
#    code = "nohup flatpak run com.visualstudio.code --enable-features=UseOzonePlatform --ozone-platform=wayland";
#  }; 

  programs.hyprland.enable = true;
  programs.firefox.enable = true;
  programs.waybar.enable = true;
  programs.xwayland.enable = true;
  programs.nm-applet.enable = true;
  # programs.steam.enable = true;
  programs.zsh.enable = true;
  # programs.steam.gamescopeSession.enable = false;
  # programs.gamemode.enable = true;

  hardware.opentabletdriver.enable = true;

  xdg.portal = {
	  enable = true;
	  extraPortals = [
	    pkgs.xdg-desktop-portal-gtk 
	  ];
	  config.Hyprland = {
	    default = [ "hyprland" "gtk" ];
	    "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
	  };
  };

  services.flatpak.enable = true;
  services.syncthing.enable = true;
  services.syncthing.relay.enable = true;
  services.power-profiles-daemon.enable = true;
}
