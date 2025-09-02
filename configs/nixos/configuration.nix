{ config, pkgs, inputs, ... }:

{
  # imports
  imports = [
    ./hardware-configuration.nix
  ];

  # nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

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
  hardware.openrazer.enable = true;

  # desktop environment
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # printing and flatpak
  services.printing.enable = true;
  services.flatpak.enable = true;

  # openssh
  services.openssh.enable = true;

  # virtualisation
  virtualisation.docker.enable = true;

  # users
  users.users.andrew = {
    isNormalUser = true;
    description = "Andrew Gielow";
    extraGroups = [ "networkmanager" "wheel" "openrazer" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # system packages
  environment.systemPackages = with pkgs; import ./packages.nix { inherit pkgs inputs; };

  # programs
  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.git.config = {
    enable = true;
    userName = "not a cow";
    userEmail = "104255555+not-a-cowfr@users.noreply.github.com";
    config = {
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  # system
  system.stateVersion = "25.05";
}
