{
  description = "A modest pepega flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    
    helix.url = "github:helix-editor/helix/master";
    # hyprland = {
    #   type = "git";
    #   url = "https://github.com/hyprwm/Hyprland?ref=v0.41.2";
    #   submodules = true; 
    # };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";      
    };
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 };

  outputs = inputs@{ nixpkgs, home-manager, spicetify-nix, ... }: {
    nixosConfigurations = {        
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; 
        modules = [
            ./configuration.nix 
            # ./hyprland.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mythicsoul = import ./home.nix;
              home-manager.extraSpecialArgs = {inherit spicetify-nix;};
            }
        ];
      };
    };  
  };

}
