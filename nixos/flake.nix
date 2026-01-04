{
  description = "A modest pepega flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    helix.url = "github:helix-editor/helix/master";
    hyprland.url = "github:hyprwm/Hyprland/v0.52.1";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    vasciipp.url = "github:mythicsoul/vasciipp";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      unstable,
      home-manager,
      spicetify-nix,
      hyprland,
      ...
    }:
    let
      pkgsUnstable = import unstable {
        system = "x86_64-linux";
      };
    in
    {
      nixosConfigurations = {
        nix-dome = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            inherit pkgsUnstable;
          };
          modules = [
            ./configuration.nix
            ./modules/hyprland.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mythicsoul = import ./home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit spicetify-nix; };
            }
          ];
        };
      };
    };
}
