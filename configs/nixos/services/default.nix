{ config, inputs, ... }:
{
  imports = [
    ./minecraft.nix
    ./nginx.nix
  ];

  # audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # printing and flatpak
  services.printing.enable = true;
  services.flatpak.enable = true;

  # openssh
  services.openssh.enable = true;

  # virtualisation
  virtualisation.docker.enable = true;
}
