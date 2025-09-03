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
  gcc
  rustup
  zig

  # cli tools
  bat
  cargo-flamegraph
  curl
  dioxus-cli
  docker
  docker-compose
  fastfetch
  fnm
  git
  mongodb
  mongosh
  nginx
  nixpkgs-fmt
  nodePackages.pnpm
  nushell
  rcon-cli
  ripgrep
  rojo
  valkey
  vim

  # deps
  starship
  steamcmd
  openrazer-daemon
  openssl
  pkg-config
]
