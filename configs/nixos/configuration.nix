{ config, pkgs, inputs, ... }:

{
  # imports
  imports = [
    ./hardware-configuration.nix
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

  # nginx
  services.nginx = {
    enable = true;
    virtualHosts."bot-backend.notacow.fr" = {
      addSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "awgielow@gmail.com";
  };
  systemd.services.nginx.serviceConfig.ReadWritePaths = [ "/var/log/nginx/" ];


  # minecraft server
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    # for seperate mods
    servers.fabric = {
      enable = true;
      autoStart = true;

      package = pkgs.fabricServers.fabric-1_20_1.override {
        loaderVersion = "0.17.2";
      };

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            Fabric-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/UapVHwiP/fabric-api-0.92.6%2B1.20.1.jar";
              sha512 = "2bd2ed0cee22305b7ff49597c103a57c8fbe5f64be54a906796d48b589862626c951ff4cbf5cb1ed764a4d6479d69c3077594e693b7a291240eeea2bb3132b0c";
            };
            Create = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Xbc0uyRg/versions/7Ub71nPb/create-fabric-0.5.1-j-build.1631%2Bmc1.20.1.jar";
              sha512 = "73ff936492c857ae411c10cae0194d64a56b98a1a7a9478ca13fe2a6e3ee155e327cf4590a3888aaa671561b4cf74de97f2f44224d7981b03a546e36236c3de2";
            };
          }
        );
      };

      serverProperties = {
        difficulty = 3;
        gamemode = "survival";
        motd = "hi :)";
        
        "gamerule.keepInventory" = "true";

        enable-rcon = true;
        "rcon.password" = "ionknow";
        "rcon.port" = 25566;
      };
    };

    # for modpack
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
  };

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
