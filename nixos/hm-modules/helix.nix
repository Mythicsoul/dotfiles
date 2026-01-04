{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    themes = {
      fleet_dark_transparent = {
        inherits = "fleet_dark";
        "ui.background" = { };
      };
    };
    settings = {
      theme = "fleet_dark_transparent";
      editor = {
        insert-final-newline = false;
        line-number = "relative";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
        # soft-wrap = true;
        # auto-pairs = true;
      };
      # keys.normal = {
      #   C-j = "next_symbol";
      #   C-k = "prev_symbol";
      # };
      keys.insert.j = {
        j = "normal_mode";
      };
      # keys.normal.space = {
      #   e = [
      #     ":sh rm -f /tmp/unique-file-h21a434"
      #     ":insert-output yazi '%{buffer_name}' --chooser-file=/tmp/unique-file-h21a434"
      #     ":insert-output echo \"x1b[?1049h\" > /dev/tty"
      #     ":open %sh{cat /tmp/unique-file-h21a434}"
      #     ":redraw"
      #     ":set mouse false"
      #     ":set mouse true"
      #   ];
      # };
      keys.normal = {
        C-g = [
          ":write-all"
          ":insert-output lazygit >/dev/tty"
          ":redraw"
          ":reload-all"
        ];
      };
    };
    languages = {
      language-server.clangd = {
        command = "clangd";
        # args = [ "--compile-commands-dir=build/golem/clangd" ];
      };
      language-server.cmake-language-server = {
        command = "cmake-language-server";
      };
      language-server.pylsp = {
        command = "pylsp";
      };
      language = [
        {
          name = "nix";
          auto-format = false;
          language-servers = [ "nil" ];
          comment-token = "#";
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "cpp";
          language-servers = [ "clangd" ];
          formatter = {
            name = "cpp";
            command = "clang-format";
            # args = [ "--style=llvm" ];
            args = [ "--style=file" ];
          };
        }
        {
          name = "python";
          language-servers = [ "pylsp" ];
      
        }
        # {
        #   name = "haskell";
        #   language-servers = [ "haskell-language-server-wrapper" ];
        # }
        # {
        #   name = "python";
        #   language-servers = [ "pylsp" ];
        # }
      ];
      # formatters = {
      #   name = "cpp";
      #   command = "clang-format";
      #   args = [ "--style=llvm" ];
      # };
    };
  };
}
