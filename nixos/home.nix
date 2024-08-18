{ config, pkgs, lib, ... }:

{

    imports = [ ./spicetify.nix ];
    home.username = "mythicsoul";
    home.homeDirectory = "/home/mythicsoul";

    home.packages = with pkgs; [
      cowsay
      oh-my-zsh
    ];

    programs.git = {
      enable = true;
      userName = "Mythicsoul";
      userEmail = "mythicsoul.dev@proton.me";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    programs.kitty = {
      enable = true;
      font.name = "Inconsolata Nerd Font";
      font.size = 12;
      settings = {
        open_url_with = "firefox";
        url_style = "straight";
        copy_on_select = true;
        background_opacity = "0.7";
        cursor = "#FFFACD";
        cursor_shape = "beam";
        foreground = "#c9c6a5";
      };
    };
     
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = false;
      shellAliases = {
        ls ="ls -a";
        ll ="ls -l";
      };
      history = {
        size = 10000;
        ignoreAllDups = true;
        path ="$HOME/.zsh_history";
      };
      oh-my-zsh = {
        enable = true;
        custom = "$HOME/.config/zsh_custom";
        theme = "alanpeabody_custom";
        plugins = [ "colored-man-pages" ];
      }; 
    };
    
    programs.helix = {
      enable = true;
      defaultEditor = true;
      themes = {
        fleet_dark_transparent = {
          inherits = "fleet_dark";
          "ui.background" = {};
        };
      };
      settings = {
        theme = "fleet_dark_transparent";
        editor = {
          line-number = "relative";
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          file-picker = {
            hidden = false;
          };
        };
        keys.insert.j = {
          j = "normal_mode";
        };
      };
      languages = {
        languge-server.clangd = {
          command = "clangd";
          args = ["--compile-commands-dir=build"];
        };
        language-server.cmake-language-server = {
          command = "cmake"; 
        };
        language = [
        {
          name = "nix";
          auto-format = false;
          language-servers = [ "nil" ];
          comment-token = "#";
        }
        {
          name = "cpp";
          language-servers = [ "clangd"];
        }
        ];
      };
    };

    home.stateVersion = "24.05";
    programs.home-manager.enable = true;

}
