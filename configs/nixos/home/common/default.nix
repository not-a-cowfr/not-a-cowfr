{
  outputs,
  userConfig,
  pkgs,
  nhModules,
  ...
}:
{
  imports = [
    "${nhModules}/programs/bat"
    "${nhModules}/programs/fastfetch"
    "${nhModules}/programs/fzf"
    "${nhModules}/programs/gpg"
    "${nhModules}/services/flatpak"
  ];

  nix.package = pkgs.nix;

  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

  systemd.user.startServices = "sd-switch";

  home = {
    username = "${userConfig.name}";
    homeDirectory = "/home/${userConfig.name}";
  };

  home.packages = with pkgs; [
    fd
    jq
    ripgrep
    curl
    nixpkgs-fmt
    tree
    zip
    unzip

    openrazer-daemon
    openssl
    pkg-config
    libgbm
  ];
}
