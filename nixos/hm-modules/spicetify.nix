{ pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];

  # https://gerg-l.github.io/spicetify-nix/

  programs.spicetify = {
    enable = true;
    spotifyLaunchFlags = "--enable-features=WaylandLinuxDrmSyncobj --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu-sandbox --enable-gpu-rasterization --enable-wayland-ime --use-wayland-explicit-grab --enable-zero-copy --ignore-gpu-blocklist --use-gl=desktop --enable-gpu-memory-buffer-compositor-resources --no-sandbox --enable-features=ExplicitSync";
    # --disable-gpu
    # --enable-developer-mode
    # --in-process-gpu (coredumps)
    # theme = spicePkgs.themes.lucid;
    # colorScheme = "rosepine";
    # windowManagerPatch
    #
    alwaysEnableDevTools = true;
    experimentalFeatures = true;

    # searchbar, home button, bell / friends, pfp, idk. C idk, R idk, right, + button
    theme = spicePkgs.themes.default // {
      additionalCss = ''
               .main-topBar-searchBar {
                 background-color: #0d0512 !important; 
               }
               .main-globalNav-navLink {
                 background-color: #0d0512 !important; 
               }
               .main-topBar-buddyFeed {
                 background-color: #0d0512 !important; 
               }
               .main-userWidget-box {
                 background-color: #0d0512 !important; 
               }

               .CvxzmyND_aGd2RR8ZoSr {
                 background-color: #1A0E20 !important;
               }
               .Rol5Gmuk1O2tMw7NMtxF {
                 background-color: #1A0E20 !important;
               }
               .main-nowPlayingView-section {
                 background-color: #1A0E20 !important;
               }
               .AIlmv6h8bR5NY5R0VceT {
                 background-color: #1A0E20 !important; 
               }

               .NowPlayingView {
                 border-radius: 8px !important;
               }

               [data-right-sidebar-hidden=false] .Root__right-sidebar, .npv-nowPlayingbar-container, .oXO9_yYs6JyOwkBn8E4a {
                 width: 670px !important;
               }

               [data-right-sidebar-hidden=true] .Root__right-sidebar, .npv-nowPlayingbar-container {
                 width: 0px !important;
               }
    
               .main-nowPlayingView-nowPlayingGrid:has(.canvasVideoContainerNPV video) {
                 .main-nowPlayingView-contextItemInfo {
                   margin-top: 30vh !important;
                 }
                 [aria-hidden=false] .HIaySI1OwWK1MLojie8y, .fetnShpUoCol51CFSqwn {
                   margin-top: 26vh !important;
                   margin-bottom: -31vh !important;
                 }
                 .canvasVideoContainerNPV {
                   margin-top: -5vh !important;
                 }
                 .Of__Db4QgB9osz_mFxhw:before, .Of__Db4QgB9osz_mFxhw:after {
                   background: transparent !important;
                 }
               }
      '';
    };

    colorScheme = "custom";
    customColorScheme = {
      text = "f1f1f1";
      subtext = "c1c1c1";

      # main = "1a0e26";
      # main = "1A0E20";
      main = "0d0512";

      sidebar = "27162E";
      card = "27162E";
      player = "27162E";
      shadow = "1A0E20";

      accent = "913178";
      button = "ff369b";
      button-active = "ff369b";
      button-disabled = "7a3869";

      sidebar-text = "f1f1f1";
      selected-row = "eb71ca";
      tab-active = "27162E";
      notification = "c1c1c1";
      notification-error = "c1c1c1";
      misc = "1A0E20";
    };

    enabledExtensions = [
      # # goToSong
      spicePkgs.extensions.songStats
      # copyToClipboard --> crashes UI
      # # betterSpotify
      # # betterGenres NO WORKYY!!
      spicePkgs.extensions.betterGenres
      spicePkgs.extensions.loopyLoop
    ];
    # enabledExtensions = builtins.attrValues {
    #   inherit (spicePkgs.extensions)
    #     songStats
    #     betterGenres
    #     loopyLoop
    #     ;
    # };

    # enabledCustomApps = with spicePkgs.apps; [
    #   # marketplace
    #   # newReleases
    # ];
    enabledSnippets = with spicePkgs.snippets; [
      thickerBars
    ];
    # enabledSnippets = [
    #   ''
    #     thickerBars
    #   ''
    # ];
  };
  # xdg.configFile."spotify/prefs".text = ''
  #   storage.size=8192
  # '';
}
