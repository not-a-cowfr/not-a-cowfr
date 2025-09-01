{ pkgs, inputs, ... }:
with pkgs; [
    vim
    alacritty
    git
    nginx
    docker
    docker-compose
    fastfetch
    nushell
    nodePackages.pnpm
    bun
    fnm
    prismlauncher
    curl
    valkey
    rustup
    starship
    legcord
    mongodb
    mongosh
    github-desktop
    # zen-browser
    inputs.zen-browser.packages."${pkgs.system}".twilight
    vscodium
    zoom-us
    zig
    bat
    ripgrep
]