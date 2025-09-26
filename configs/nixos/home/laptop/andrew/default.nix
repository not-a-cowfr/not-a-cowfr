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

  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    # dev apps
    github-desktop
    vscodium
    gparted
    unetbootin

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
    cargo-flamegraph
    dioxus-cli
    docker
    docker-compose
    fnm
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
    steamcmd
  ];

  home.stateVersion = "25.05";
}
