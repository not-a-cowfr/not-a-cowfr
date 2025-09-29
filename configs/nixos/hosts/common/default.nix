{ inputs
, outputs
, lib
, config
, userConfig
, pkgs
, ...
}:
{
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  nix.registry = lib.mapAttrs (_: flake: { inherit flake; }) (
    lib.filterAttrs (_: lib.isType "flake") inputs
  );

  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.efi.canTouchEfiVariables = true;

    loader.timeout = 2;
    loader.systemd-boot.enable = false;

    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;

      theme = pkgs.stdenv.mkDerivation {
        pname = "distro-grub-themes";
        version = "3.1";
        src = pkgs.fetchFromGitHub {
          owner = "AdisonCavani";
          repo = "distro-grub-themes";
          rev = "v3.1";
          hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
        };
        installPhase = "cp -r customize/nixos $out";
      };
    };

    plymouth.enable = true;

    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
  };

  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 80 443 25565 ];
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    plymouth-quit-wait.enable = false;
  };

  programs.nix-ld.enable = true;

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

  hardware.openrazer.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.libinput.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.dbus.enable = true;

  environment.localBinInPath = true;

  services.printing.enable = false;

  services.devmon.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.flatpak.enable = true;

  users.users.${userConfig.name} = {
    description = userConfig.fullName;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "openrazer"
    ];
    isNormalUser = true;
  };

  # user avatar
  # system.activationScripts.script.text = ''
  #   mkdir -p /var/lib/AccountsService/{icons,users}
  #   cp ${userConfig.avatar} /var/lib/AccountsService/icons/${userConfig.name}

  #   touch /var/lib/AccountsService/users/${userConfig.name}

  #   if ! grep -q "^Icon=" /var/lib/AccountsService/users/${userConfig.name}; then
  #     if ! grep -q "^\[User\]" /var/lib/AccountsService/users/${userConfig.name}; then
  #       echo "[User]" >> /var/lib/AccountsService/users/${userConfig.name}
  #     fi
  #     echo "Icon=/var/lib/AccountsService/icons/${userConfig.name}" >> /var/lib/AccountsService/users/${userConfig.name}
  #   fi
  # '';

  # security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    gcc
    glib
    gnumake
    killall
    mesa
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;

  programs.xwayland.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.comic-shanns-mono
  ];

  services.locate.enable = true;

  services.openssh.enable = true;
}
