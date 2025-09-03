{ config, pkgs, inputs, ... }:

{
  # imports
  imports = [
    ./hardware-configuration.nix
    ./kde.nix
    ./services
    ./programs
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  # nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  # time and locale
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # hardware
  hardware = {
    openrazer.enable = true;

    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # user config
  users.users.andrew = {
    isNormalUser = true;
    description = "Andrew Gielow";
    extraGroups = [ "networkmanager" "wheel" "openrazer" ];
  };

  # system packages
  environment.systemPackages = with pkgs; import ./packages.nix { inherit pkgs inputs; };

  system.stateVersion = "25.05"; # no i did not read the comment
}
