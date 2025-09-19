{ nhModules, pkgs, inputs, ... }:
{
  imports = [
    "${nhModules}/common"
    "${nhModules}/desktop/kde"
    ../../../modules/home-manager/programs/git
    ../../../modules/home-manager/programs/go
    ../../../modules/home-manager/programs/starship
    ../../../modules/home-manager/programs/ghostty
  ];

  news.display = "silent";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # dev apps
    # alacritty
    github-desktop
    vscodium
    gparted
    unetbootin
    ghostty

    # regular apps
    legcord
    polychromatic
    prismlauncher
    razergenie
    steam-run
    spotify
    inputs.zen-browser.packages."${pkgs.system}".twilight
    zoom-us

    # languages
    bun
    rustup
    zig

    # cli tools
    # bat
    cargo-flamegraph
    dioxus-cli
    docker
    docker-compose
    fnm
    # git
    mongodb
    mongosh
    nginx
    nodePackages.pnpm
    nushell
    rcon-cli
    rojo
    valkey
    vim

    # deps
    # starship
    steamcmd
  ];

  home.stateVersion = "25.05";
}
