{ pkgs, inputs, ... }:
with pkgs; [
    # dev apps
    alacritty
    github-desktop
    vscodium

    # regular apps
    legcord
    prismlauncher
    # zen-browser
    inputs.zen-browser.packages."${pkgs.system}".twilight
    zoom-us

    # languages
    bun
    rustup
    zig

    # cli tools
    bat
    curl
    docker
    docker-compose
    fastfetch
    fnm
    git
    nginx
    nodePackages.pnpm
    mongodb
    mongosh
    nushell
    ripgrep
    valkey
    vim

    # deps
    starship
]
