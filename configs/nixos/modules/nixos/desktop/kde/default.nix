{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    baloo-widgets
    elisa
    ffmpegthumbs
    # kate
    khelpcenter
    konsole
    krdp
    plasma-browser-integration
    xwaylandvideobridge
    kwrite
  ];

  systemd.user.services = {
    "app-org.kde.discover.notifier@autostart".enable = false;
    "app-org.kde.kalendarac@autostart".enable = false;
  };
}
