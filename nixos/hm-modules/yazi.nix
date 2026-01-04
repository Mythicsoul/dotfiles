{ pkgs, ... }:

let
  rose-pine-yazi = pkgs.fetchFromGitHub {
    owner = "Mintass";
    repo = "rose-pine.yazi";
    rev = "main";
    sha256 = "1skqcz9rd2jqks74d5n702dmrm96fpvikk2xrvs41l6aq8578ckq";
  };

in
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    theme = {
      flavor = {
        dark = "rose-pine";
        light = "rose-pine";
      };
    };
    flavors = {
      rose-pine = "${rose-pine-yazi}";
    };
    settings = { 
      mgr = {
        ratio = [2 3 3];
        sort_by = "mtime";
        sort_dir_first = true;
        sort_reverse = true;
        scrolloff = 0;
      };
      input = {
        cursor_blink = true;
      };
    };
  };
}
