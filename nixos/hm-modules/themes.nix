{ pkgs, ... }:

{

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 24;
  };

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "gtk2";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    }; # fixes ff 141 but breaks other gtk3 apps
  };

  gtk = {
    enable = true;
    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };

    # fix nautilus places, probably patched by now
    gtk4.extraCss = ''.sidebar-pane { background-color: @accent_fg_color; color: @fg_color;}'';
    # gtk4.extraCss = ''.sidebar-pane { background-color: @bg_color;'';
    # I guess that's how it was supposed to be, but I like my variant more

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {
        color = "violet"; # takes ages...
      };
    };

    font = {
      name = "NotoSans Nerd Font";
      size = 11;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    # meh
  };
}
