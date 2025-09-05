{ inputs
, hostname
, nixosModules
, ...
}:
{
  imports = [
    ./hardware-configuration.nix
    "${nixosModules}/common"
    "${nixosModules}/desktop/kde"
    "${nixosModules}/programs/steam"
    "${nixosModules}/services/minecraft/fabric/1_20_1/create"
  ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  networking.hostName = hostname;

  system.stateVersion = "25.05";
}
