{ pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];

  programs.spicetify =  {
    enable = true;
    theme = spicePkgs.themes.sleek;
    colorScheme = "rosepine";

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
