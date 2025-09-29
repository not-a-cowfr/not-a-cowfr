{ outputs
, userConfig
, pkgs
, nhModules
, ...
}:
{
  imports = [
    "${nhModules}/programs/bat"
    "${nhModules}/programs/fastfetch"
    "${nhModules}/programs/fzf"
    "${nhModules}/programs/gpg"
    "${nhModules}/services/flatpak"
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  systemd.user.startServices = "sd-switch";

  home = {
    username = "${userConfig.name}";
    homeDirectory = "/home/${userConfig.name}";
  };

  home.packages = with pkgs; [
    dig
    fd
    jq
    ripgrep
    curl
    # fastfetch
    nixpkgs-fmt
    tree

    openrazer-daemon
    openssl
    pkg-config
    libgbm
  ];
}
