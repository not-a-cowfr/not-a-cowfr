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
  ];

  networking.hostName = hostname;

  system.stateVersion = "25.05";
}
