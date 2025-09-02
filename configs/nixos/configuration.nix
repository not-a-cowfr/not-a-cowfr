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

  # minecraft server
  # services.minecraft-servers = {
  #   enable = true;
  #   eula = true;
  #   openFirewall = true;

  #   # for seperate mods
  #   # servers.fabric = {
  #   #   enable = true;

  #   #   package = pkgs.fabricServers.fabric-1_21_8.override {
  #   #     loaderVersion = "0.17.2";
  #   #   };

  #   #   symlinks = {
  #   #     mods = pkgs.linkFarmFromDrvs "mods" (
  #   #       builtins.attrValues {
  #   #         Fabric-API = pkgs.fetchurl {
  #   #           url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/9YVrKY0Z/fabric-api-0.115.0%2B1.21.8.jar";
  #   #           sha512 = "e5f3c3431b96b281300dd118ee523379ff6a774c0e864eab8d159af32e5425c915f8664b1cd576f20275e8baf995e016c5971fea7478c8cb0433a83663f2aea8";
  #   #         };
  #   #         Backpacks = pkgs.fetchurl {
  #   #           url = "https://cdn.modrinth.com/data/MGcd6kTf/versions/Ci0F49X1/1.2.1-backpacks_mod-1.21.2-1.21.3.jar";
  #   #           sha512 = "6efcff5ded172d469ddf2bb16441b6c8de5337cc623b6cb579e975cf187af0b79291b91a37399a6e67da0758c0e0e2147281e7a19510f8f21fa6a9c14193a88b";
  #   #         };
  #   #       }
  #   #     );
  #   #   };
  #   # };

  #   # for modpack
  #   let
  #     modpack = pkgs.fetchPackwizModpack {
  #       url = "";
  #       packHash = "";
  #     };
  #     mcVersion = modpack.manifest.versions.minecraft;
  #     fabricVersion = modpack.manifest.versions.fabric;
  #     serverVersion = lib.replaceStrings [ "." ] [ "_" ] "fabric-${mcVersion}";
  #   in
  #   {
  #   cool-modpack = {
  #     enable = true;
  #     package = pkgs.fabricServers.${serverVersion}.override { loaderVersion = fabricVersion; };
  #     symlinks = {
  #       "mods" = "${modpack}/mods";
  #     };
  #     files = {
  #       "config" = "${modpack}/config";
  #       # "config/mod1.yml" = "${modpack}/config/mod1.yml";
  #       # "config/server-specific.conf".value = {
  #       #   example = "foo-bar";
  #       # };
  #     };
  #   };
  # };
  # };

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
