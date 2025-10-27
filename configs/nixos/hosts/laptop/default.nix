{
  inputs,
  pkgs,
  nixosModules,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../common
    "${nixosModules}/desktop/kde"
    "${nixosModules}/programs/steam"
  ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
      25565
    ];
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
