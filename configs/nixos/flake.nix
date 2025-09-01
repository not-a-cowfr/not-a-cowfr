{
  description = "my flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { nixpkgs, zen-browser, ... } @ inputs: 
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          {
            environment.systemPackages = with nixpkgs.pkgs; [
              zen-browser
            ];
          }
        ];
      };
    };
}
