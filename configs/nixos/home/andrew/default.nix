{ nhModules, pkgs, inputs, ... }:
{
  imports = [
    ../common
    "${nhModules}/desktop/kde"
    "${nhModules}/programs/git"
    "${nhModules}/programs/go"
    "${nhModules}/programs/starship"
    "${nhModules}/programs/terminal"
    "${nhModules}/programs/discord"
  ];

  news.display = "silent";

  programs.home-manager.enable = true;

  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    # dev apps
    github-desktop
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
    nixfmt
    nushell
    rcon-cli
    rojo
    valkey
    vim

    # deps
    steamcmd

    # cybersec class stuff
    sherlock
    nmap
    wireshark-qt
    tcpdump
  ];

  home.stateVersion = "25.05";
}
