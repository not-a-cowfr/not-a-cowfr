{ ... }:
{
  location = "bottom";
  widgets = [
    {
      kicker = {
        icon = "/etc/nixos/assets/nixos-pan.png";
      };
    }
    "org.kde.plasma.marginsseparator"
    {
      name = "org.dhruv8sh.kara";
      config = {
        general = {
          type = 0;

          animationDuration = 90;
          spacing = 3;
          wrapOn = false;
        };

        type1 = {
          t1activeWidth = 40;
          t1activeHeight = 22;

          t1height = 24;
          t1width = 8;
        };
      };
    }
    "org.kde.plasma.panelspacer"
    {
      iconTasks = {
        launchers = [
          "applications:systemsettings.desktop"
          "applications:org.kde.dolphin.desktop"

          "org.kde.plasma.marginsseparator"

          "applications:com.mitchellh.ghostty.desktop"
          "applications:github-desktop.desktop"
          "applications:codium.desktop"

          "org.kde.plasma.marginsseparator"

          "applications:legcord.desktop"
          "applications:spotify.desktop"
          "preferred://browser"

          "org.kde.plasma.marginsseparator"

          "applications:org.prismlauncher.PrismLauncher.desktop"
          "applications:steam.desktop"
        ];
      };
    }
    "org.kde.plasma.panelspacer"
    {
      name = "plasmusic-toolbar";
      config = {
        general = {
          useCustomFont = true;
          customFont = "ComicShannsMono Nerd Font,10,-1,5,700,0,0,0,0,0,0,0,0,0,0,1";

          titlePosition = 2;
          skipBackwardControlInPanel = false;
          skipForwardControlInPanel = false;
          playPauseControlInPanel = false;

          panelIconSizeRatio = 1;
          useAlbumCoverAsPanelIcon = true;
          maxSongWidthInPanel = 300;

          desktopWidgetBg = 0;
          fullAlbumCoverAsBackground = true;
        };
      };
    }
    "org.kde.plasma.marginsseparator"
    {
      systemTray.items = {
        shown = [
          "org.kde.plasma.volume"
          "org.kde.plasma.battery"
          "org.kde.plasma.bluetooth"
          "org.kde.plasma.networkmanagement"
        ];

        hidden = [
          "polychromatic-tray-applet"
          "spotify-client"
          "org.kde.kscreen"
          "org.kde.kdeconnect"
          "org.kde.plasma.clipboard"
          "org.kde.plasma.cameraindicator"
          "org.kde.plasma.devicenotifier"
          "org.kde.plasma.keyboardlayout"
          "org.kde.plasma.keyboardindicator"
          "org.kde.plasma.manage-inputmethod"
          "org.kde.plasma.mediacontroller"
          "org.kde.plasma.weather"
          "org.kde.plasma.brightness"
        ];
      };
    }
    {
      digitalClock = {
        time.format = "24h";
        date.format = "isoDate";
      };
    }
  ];
  hiding = "normalpanel";
}
