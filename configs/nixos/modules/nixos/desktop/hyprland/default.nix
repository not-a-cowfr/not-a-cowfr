{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    grimblast
    wl-clipboard

    wofi
    waybar
    hyprpaper
  ];
}
