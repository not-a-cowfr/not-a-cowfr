{
  description = "my nix config";
  inputs = {
    # packages stuff
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=v0.6.0";

    # desktop environment/window manager configs
    plasma-manager = {
      url = "github:AlexNabokikh/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };


    # addons
    chaotic.url = "github:chaotic-cx/nyx";

    # apps
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    # equinix.url = "path:/home/andrew/Documents/GitHub/equinix";
    equinix.url = "github:not-a-cowfr/equinix";
  };

  outputs =
    { self
    , home-manager
    , nixpkgs
    , zen-browser
    , nix-minecraft
    , chaotic
    , ...
    }@inputs:
    let
      inherit (self) outputs;

      users = {
        andrew = {
          # avatar = ./files/avatar/face;
          fullName = "Andrew Gielow";
          # gitKey = "";
          name = "andrew";
        };
      };

      mkNixosConfiguration =
        hostname: username:
        nixpkgs.lib.nixosSystem {
          # system = "x86_64-linux";
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            nixosModules = ./modules/nixos;
          };
          modules = [
            ./hosts/${hostname}
            inputs.nix-minecraft.nixosModules.minecraft-servers
            chaotic.nixosModules.nyx-cache
            chaotic.nixosModules.nyx-overlay
            chaotic.nixosModules.nyx-registry
          ];
        };

      mkHomeConfiguration =
        system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit inputs outputs;
            userConfig = users.${username};
            nhModules = "${self}/modules/home-manager";
          };
          modules = [
            ./home/${username}
            inputs.chaotic.homeManagerModules.default
          ];
        };
    in
    {
      nixosConfigurations = {
        laptop = mkNixosConfiguration "laptop" "andrew";
      };

      homeConfigurations = {
        "andrew@laptop" = mkHomeConfiguration "x86_64-linux" "andrew" "laptop";
      };

      overlays = import ./overlays { inherit inputs; };
    };
}
