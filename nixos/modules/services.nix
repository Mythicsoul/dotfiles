{ pkgs, ... }:
{

  systemd.user.services = {
    waybar = {
      enable = true;
      # path = with pkgs; [
      #   bash
      #   coreutils
      #   rofi
      #   pamixer
      #   rofi-power-menu
      #   playerctl
      #   dbus
      #   getopt
      # ];
      serviceConfig = {
        Type = "exec";
        Slice = "app-graphical.slice";
        ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"wlroots:sway:Wayfire:labwc:Hyprland\" \"\"";
        # Environment = "PATH=${pkgs.coreutils}/bin:${pkgs.bash}/bin:${pkgs.rofi}/bin:${pkgs.playerctl}/bin:${pkgs.pamixer}/bin:${pkgs.rofi-power-menu}/bin:${pkgs.dbus}/bin:$PATH";
        Environment = "PATH=/run/current-system/sw/bin:$PATH";
      };
    };
  };

  systemd.services.set-mnt-data-permissions = {
    # bad practice?
    description = "Set /mnt/data permissions";
    after = [ "mnt-data.mount" ];
    wantedBy = [ "local-fs.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/chown mythicsoul:users /mnt/data";
    };
  };
}
