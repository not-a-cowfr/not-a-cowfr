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
    "${nhModules}/programs/code-editor"
  ];

  news.display = "silent";

  programs.home-manager.enable = true;

  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    # dev apps
    github-desktop
    gparted
    unetbootin
    jetbrains.idea-ultimate

    # regular apps
    legcord
    polychromatic
    prismlauncher
    razergenie
    steam-run
    spotify
    inputs.zen-browser.packages."${pkgs.system}".twilight
    zoom-us
    audacity

    # languages
    bun
    python3
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
    uv
    valkey
    vim
    dig

    # deps
    steamcmd

    # cybersec class stuff
    sherlock
    nmap
    wireshark-qt
    tcpdump
    stegseek
    exiftool
    foremost
  ];

  home.stateVersion = "25.11";
}
