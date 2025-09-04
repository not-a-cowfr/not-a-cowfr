{ outputs
, userConfig
, pkgs
, ...
}:
{
  imports = [
    ../programs/alacritty
    ../programs/bat
    ../programs/fastfetch
    ../programs/fzf
    ../programs/git
    ../programs/go
    ../programs/gpg
    ../programs/starship
    ../services/flatpak
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
