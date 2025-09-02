{ pkgs, inputs, ... }:
with pkgs; [
    # dev apps
    alacritty
    github-desktop
    # vinegar # roblox studio (commented out because only flatpak install works)
    vscodium

    # regular apps
    legcord
    polychromatic
    prismlauncher
    razergenie
    steam-run
    spotify
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
    rojo

    # deps
    starship
    steamcmd
    openrazer-daemon
]
