{ config
, inputs
, lib
, nhModules
, pkgs
, ...
}:
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    "${nhModules}/misc/wallpaper"
  ];

  home.packages = with pkgs; [
    kdePackages.kcalc
    kdePackages.krohnkite
    kdotool
    tela-circle-icon-theme
  ];

  services.gpg-agent = {
    pinentry.package = lib.mkForce pkgs.kwalletcli;
    extraConfig = "pinentry-program ${pkgs.kwalletcli}/bin/pinentry-kwallet";
  };

  programs.plasma = {
    enable = true;

    fonts = {
      general = {
        family = "Comic Sans MS";
        pointSize = 10;
      };
      fixedWidth = {
        family = "ComicShannsMono Nerd Font Mono";
        pointSize = 10;
      };
      small = {
        family = "Comic Sans MS";
        pointSize = 8;
      };
      toolbar = {
        family = "Comic Sans MS";
        pointSize = 10;
      };
      menu = {
        family = "Comic Sans MS";
        pointSize = 10;
      };
      windowTitle = {
        family = "Comic Sans MS";
        pointSize = 10;
      };
    };

    hotkeys.commands = {
      launch-system-monitor = {
        name = "Launch System Monitor";
        key = "Ctrl+Shift+Esc";
        command = "plasma-systemmonitor";
      };
      screenshot-region = {
        name = "Capture a rectangular region of the screen";
        key = "Meta+Shift+S";
        command = "spectacle --region --nonotify";
      };
      screenshot-screen = {
        name = "Capture the entire desktop";
        key = "Meta+Ctrl+S";
        command = "spectacle --fullscreen --nonotify";
      };
    };

    input = {
      keyboard = {
        layouts = [
          {
            layout = "us";
          }
        ];
        repeatDelay = 250;
        repeatRate = 40;
      };
      # mice = [];
      touchpads = [
        {
          enable = true;
          disableWhileTyping = true;
          middleButtonEmulation = true;
          name = "GXTP5100:00 27C6:01E0 Touchpad";
          naturalScroll = true;
          pointerSpeed = 0;
          vendorId = "27C6";
          productId = "01E0";
        }
      ];
    };

    krunner.activateWhenTypingOnDesktop = false;

    kscreenlocker = {
      appearance.showMediaControls = false;
      appearance.wallpaper = "${config.wallpaper}";
      autoLock = false;
      timeout = 0;
    };

    kwin = {
      effects = {
        blur.enable = false;
        cube.enable = false;
        desktopSwitching.animation = "off";
        dimAdminMode.enable = false;
        dimInactive.enable = false;
        fallApart.enable = false;
        fps.enable = false;
        minimization.animation = "off";
        shakeCursor.enable = false;
        slideBack.enable = false;
        snapHelper.enable = false;
        translucency.enable = false;
        windowOpenClose.animation = "off";
        wobblyWindows.enable = false;
      };

      nightLight.enable = false;

      virtualDesktops = {
        number = 4;
        rows = 1;
      };
    };

    overrideConfig = true;

    panels = [
      {
        location = "bottom";
        widgets = [
          "org.kde.plasma.kickoff"
          {
            iconTasks = {
              launchers = [
                "applications:systemsettings.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:Alacritty.desktop"
                "applications:github-desktop.desktop"
                "applications:codium.desktop"
                "applications:legcord.desktop"
                "applications:spotify.desktop"
                "applications:org.prismlauncher.PrismLauncher.desktop"
                "applications:steam.desktop"
                "applications:zen-twilight.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray.items.shown = [
              "org.kde.plasma.volume"
              "org.kde.plasma.battery"
              "org.kde.plasma.bluetooth"
              "org.kde.plasma.networkmanagement"
            ];
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
      # {
      #   location = "top";
      #   height = 26;
      #   widgets = [ "org.kde.plasma.appmenu" ];
      # }
    ];

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = false;

        powerButtonAction = "showLogoutScreen";
        turnOffDisplay.idleTimeout = "never";

        whenLaptopLidClosed = "lockScreen";
      };
      battery = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = true;

        powerButtonAction = "showLogoutScreen";
        turnOffDisplay.idleTimeout = 600;

        whenLaptopLidClosed = "lockScreen";
      };
      lowBattery = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 900;
        };
        dimDisplay.enable = true;

        powerButtonAction = "hibernate";
        turnOffDisplay.idleTimeout = 300;

        whenLaptopLidClosed = "lockScreen";
        # whenLaptopLidClosed = "hibernate";
      };
    };

    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    shortcuts = {
      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Window Close" = "Ctrl+Q";
        "Toggle Overview" = "Meta+Tab";
      };

      plasmashell = {
        "show-on-mouse-pos" = "";
      };

      "services/org.kde.dolphin.desktop"."_launch" = "Meta+Shift+F";
    };

    spectacle = {
      shortcuts = {
        captureEntireDesktop = "";
        captureRectangularRegion = "";
        launch = "";
        recordRegion = "Meta+Shift+R";
        recordScreen = "Meta+Ctrl+R";
        recordWindow = "";
      };
    };

    window-rules = [
      {
        description = "Assign Alacritty to Desktop 1";
        match = {
          window-class = {
            value = "Alacritty";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktop = {
            value = 1;
            apply = "initially";
          };
        };
      }
      {
        description = "Assign VSCodium to Desktop 2";
        match = {
          window-class = {
            value = "vscodium";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktop = {
            value = 2;
            apply = "initially";
          };
        };
      }
      {
        description = "Assign Zoom to Desktop 3";
        match = {
          window-class = {
            value = "zoom";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktop = {
            value = 4;
            apply = "initially";
          };
        };
      }
    ];

    workspace = {
      enableMiddleClickPaste = false;
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor.theme = "breeze_cursors";
      theme = "Nordic";
      colorScheme = "BreezeDark";
      iconTheme = "Nordic-darker";
      wallpaper = "/etc/nixos/modules/home-manager/misc/wallpaper/wallpaper.jpg";
      # splashScreen = "Illusion";
    };

    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      gwenviewrc.ThumbnailView.AutoplayVideos = true;
      kdeglobals = {
        General = {
          BrowserApplication = "zen-twilight.desktop";
        };
      };
      klaunchrc.FeedbackStyle.BusyCursor = false;
      klipperrc.General.MaxClipItems = 1000;
      plasmanotifyrc = {
        DoNotDisturb = {
          WhenFullscreen = false;
          WhenScreenSharing = true;
          WhenScreensMirrored = false;
        };
        Notifications = {
          PopupPosition = "BottomRight";
          PopupTimeout = 7000;
        };
      };
      plasmarc.OSD.Enabled = false;
      spectaclerc = {
        Annotations = {
          annotationToolType = 8;
          rectangleStrokeColor = "255,0,0";
        };
        General = {
          launchAction = "DoNotTakeScreenshot";
          showCaptureInstructions = false;
          useReleaseToCapture = true;
        };
        ImageSave.imageCompressionQuality = 100;
      };
    };
    dataFile = {
      "dolphin/view_properties/global/.directory"."Dolphin"."ViewMode" = 1;
      "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" = true;
    };
  };
}
