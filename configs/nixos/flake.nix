{
  description = "my flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = { nixpkgs, zen-browser, nix-minecraft, ... } @ inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          {
            environment.systemPackages = with nixpkgs.pkgs; [
              zen-browser
            ];
          }
          nix-minecraft.nixosModules.minecraft-servers
          {
            nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
          }
        ];
      };
    };
}
