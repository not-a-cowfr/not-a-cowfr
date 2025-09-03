{ config, inputs, pkgs, ... }:
{
  users.users.andrew = {
    packages = with pkgs; [ kdePackages.kate ];
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
}
