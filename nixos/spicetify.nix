{ pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];

  programs.spicetify =  {
    enable = true;
    theme = spicePkgs.themes.lucid; # fix browse icon
    colorScheme = "custom";

    customColorScheme = {
      text = "f1f1f1";
      subtext = "c1c1c1";
      main = "1a0e26";
      sidebar = "241c2c";
      accent = "f9b1e6";
      player = "241c2c";
      card = "241c2c";
      shadow = "241c2c";
      button = "ff369b";
      button-active = "ff369b";
    };
    
    enabledExtensions = with spicePkgs.extensions; [
      goToSong
      songStats
      copyToClipboard
      # betterSpotify
      # genre
    ];
    enabledCustomApps = with spicePkgs.apps; [
      # marketplace
      # newReleases
    ];
    enabledSnippets = with spicePkgs.snippets; [
      thickerBars
    ];
  };
}
