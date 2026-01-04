{ pkgs, ... }:

{
  imports = [
    ./hm-modules/spicetify.nix
    ./hm-modules/themes.nix
    ./hm-modules/yazi.nix
    ./hm-modules/helix.nix
  ];
  home.username = "mythicsoul";
  home.homeDirectory = "/home/mythicsoul";

  home.packages = with pkgs; [
    cowsay
  ];

  home.file.".local/share/applications/firefox-incognito.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Name=Firefox Incognito
    Exec=${pkgs.writeShellScriptBin "firefox-incognito" "exec ${pkgs.firefox}/bin/firefox --private-window \"$@\" "}/bin/firefox-incognito
    Icon=firefox
    Type=Application
    Categories=Network;WebBrowser;
  '';

  home.file.".local/share/applications/osu-wayland.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Name=osu! (wayland)
    Exec=${pkgs.writeShellScriptBin "osu!" "SDL_VIDEODRIVER=wayland exec ${pkgs.osu-lazer-bin}/bin/osu! \"$@\" "}/bin/osu!
    Icon=osu
    Type=Application
    Categories=Game;
  '';

  programs.git = {
    enable = true;
    settings.user = {
      name = "Mythicsoul";
      email = "mythicsoul.dev@proton.me";
    };
  };

  programs.kitty = {
    enable = true;
    font.name = "Inconsolata Nerd Font";
    font.size = 13;
    settings = {
      open_url_with = "firefox";
      url_style = "straight";
      copy_on_select = true;
      cursor_trail = "1";
      background_opacity = "0.75";
      cursor = "#FFFACD";
      cursor_shape = "beam";
      foreground = "#c9c6a5";
      # background = "#191724";
      enabled_layouts = "tall:bias=50;mirrored=true";
      active_border_color = "#fa8d07";
      inactive_border_color = "#47056e";
      window_border_width = "2px";
      dynamic_background_opacity = "1";
      # scrollback_lines = "10000";
    };
    keybindings = {
      "ctrl+shift+up" = "move_window up";
      "ctrl+shift+left" = "move_window left";
      "ctrl+shift+right" = "move_window right";
      "ctrl+shift+down" = "move_window down";

      "ctrl+shift+k" = "neighboring_window up";
      "ctrl+shift+h" = "neighboring_window left";
      "ctrl+shift+l" = "neighboring_window right";
      "ctrl+shift+j" = "neighboring_window down";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = false;
    shellAliases = {
      ls = "ls -a --color=auto";
      ll = "ls -l --color=auto";
      da = "du -h -a";
      shx = "cd /etc/nixos && sudo -E hx *.nix";
      hhx = "cd $HOME/.config/hypr/ && hx *.conf";
      ns = "nix-shell --command zsh";
    };
    history = {
      size = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
    };
    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.config/zsh_custom";
      theme = "alanpeabody_custom";
      plugins = [ "colored-man-pages" ];
    };

    # Allow Ctrl-z to toggle between suspend and resume
    initContent = ''
      function Resume {
        fg
        zle push-input
        BUFFER=""
        zle accept-line
      }
      zle -N Resume
      bindkey "^Z" Resume
    '';
    profileExtra = ''
      if uwsm check may-start && uwsm select; then
        exec uwsm start default
      fi
    '';
  };

  programs.lazygit = {
    enable = true;
  };

  # https://github.com/nix-community/home-manager/issues/632
  services.udiskie = {
    enable = true;
    automount = false;
    settings = {
      program_options = {
        file_manager = "${pkgs.nautilus}/bin/nautilus";
      };
    };
  };

  programs.fastfetch = {
    # peak productivity
    enable = true;
    settings = {
      logo = {
        type = "auto";
        source = "~/Pictures/random/wicked.png";
        width = 32;
        height = 16;
        padding = {
          right = 4;
          left = 4;
          top = 1;
        };
      };
      display = {
        separator = " > ";
        color = {
          keys = "#eb71ca";
          separator = "#6902b8";
          output = "#a6f5f2";
        };
      };
      modules = [
        "break"
        "break"
        {
          key = "{##6902b8}│ {#keys}󰅐 ";
          type = "uptime";
        }
        {
          key = "{##6902b8}│ {#keys}{icon} ";
          type = "os";
        }
        {
          key = "{##6902b8}│ {#keys} ";
          type = "kernel";
        }
        {
          key = "{##6902b8}│ {#keys}󰏖 ";
          type = "packages";
        }
        {
          key = "{##6902b8}│ {#keys} ";
          type = "shell";
        }
        {
          key = "{##6902b8}│ {#keys} ";
          type = "terminal";
        }
        {
          key = "{##6902b8}│ {#keys} ";
          type = "terminalfont";
        }
        {
          key = "{##6902b8}│ {#keys}󰍹 ";
          type = "display";
        }
        {
          key = "{##6902b8}│ {#keys} ";
          type = "wm";
        }
        {
          key = "{##6902b8}│ {#keys}󰉼 ";
          type = "theme";
        }
        {
          key = "{##6902b8}│ {#keys}󰆿 ";
          type = "cursor";
        }
        {
          key = "{##6902b8}│ {#keys} ";
          type = "icons";
        }
        {
          key = "{##6902b8}│ {#keys} ";
          type = "font";
        }
        {
          key = "{##6902b8}│ {#keys}󰍛 ";
          type = "cpu";
          showPeCoreCount = "true";
        }
        {
          key = "{##6902b8}│ {#keys} ";
          type = "memory";
        }
        {
          key = "{##6902b8}│ {#keys}󰾲 ";
          type = "gpu";
          driverSpecific = true;
          format = "{name} ({type}) {driver}";
        }
        "break"
      ];
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

}
