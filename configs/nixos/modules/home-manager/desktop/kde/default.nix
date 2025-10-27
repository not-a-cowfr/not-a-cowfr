{
  config,
  inputs,
  lib,
  nhModules,
  pkgs,
  ...
}:
let 
  # kara is in nixpkgs and builtin to plasma-manager but leaving this here for future reference
  # kara = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
  #   name = "kara";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "dhruv8sh";
  #     repo = "kara";
  #     rev = "7d2d30539a3d534af0a21ab4b485193eb792d3d5";
  #     sha256 = "sha256-gjoeKjcAr67A3moKeO7XxOiZLlXPsyW5/lCGsn8QQj4=";
  #   };
  #   installPhase = ''
  #     runHook preInstall
  #     mkdir -p $out/share/plasma/plasmoids/kara
  #     cp -r ./* $out/share/plasma/plasmoids/kara/
  #     runHook postInstall
  #   '';
  #   passthru.updateScript = pkgs.nix-update-script {};
  # });
in
{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ../wallpaper
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
      launch-settings = {
        name = "Launch System Settings";
        key = "Meta+I";
        command = "systemsettings";
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

          pointerSpeed = 0;
          accelerationProfile = "none";
          scrollSpeed = 0.2;
          naturalScroll = true;

          name = "GXTP5100:00 27C6:01E0 Touchpad";
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
          "org.kde.plasma.marginsseparator"
          {
            name = "org.dhruv8sh.kara";
            config = {
              general = {
                animationDuration = 50;
                # highlightType = 1;
                type = 3;
              };
            };
          }
          "org.kde.plasma.panelspacer"
          {
            iconTasks = {
              launchers = [
                "applications:systemsettings.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:com.mitchellh.ghostty.desktop"
                "applications:github-desktop.desktop"
                "applications:codium.desktop"
                "applications:legcord.desktop"
                "applications:spotify.desktop"
                "applications:org.prismlauncher.PrismLauncher.desktop"
                "applications:steam.desktop"
                "preferred://browser"
              ];
            };
          }
          "org.kde.plasma.panelspacer"
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.volume"
                "org.kde.plasma.battery"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.networkmanagement"
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
      sessionRestore.restoreOpenApplicationsOnLogin = "onLastLogout";
    };

    shortcuts = {
      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Window Close" = "Ctrl+Q";
        "Toggle Overview" = "Meta+Tab"; # todo: fix this creating a new shortcut instead of addinga keybind to the already existing `Toggle Overview` shortcut
      };

      plasmashell = {
        "show-on-mouse-pos" = "";
      };
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
        description = "Assign Ghostty to Desktop 1";
        match = {
          window-class = {
            value = "ghostty";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = "Desktop_1";
          desktopsrule = "2";
        };
      }
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
          desktops = "Desktop_1";
          desktopsrule = "2";
        };
      }
      {
        description = "Assign GitHub Desktop to Desktop 1";
        match = {
          window-class = {
            value = "GitHub Desktop";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = "Desktop_1";
          desktopsrule = "2";
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
          desktops = "Desktop_2";
          desktopsrule = "3";
        };
      }
      {
        description = "Assign zen to Desktop 3";
        match = {
          window-class = {
            value = "zen";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = "Desktop_3";
          desktopsrule = "2";
        };
      }
      {
        description = "Assign Zoom to Desktop 4";
        match = {
          window-class = {
            value = "zoom";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = "Desktop_4";
          desktopsrule = "2";
        };
      }
      {
        description = "Assign Legcord to Desktop 4";
        match = {
          window-class = {
            value = "legcord";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          desktops = "Desktop_4";
          desktopsrule = "2";
        };
      }
    ];

    workspace = {
      enableMiddleClickPaste = false;
      clickItemTo = "select";
      windowDecorations.library = "org.kde.breeze";
      windowDecorations.theme = "Breeze";
      cursor.theme = "breeze_cursors";
      theme = "Nordic";
      colorScheme = "BreezeDark";
      iconTheme = "Breeze Dark";
      wallpaper = "/etc/nixos/modules/home-manager/desktop/wallpaper/wallpaper.jpg";
      splashScreen.theme = "Illusion";
    };

    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      gwenviewrc.ThumbnailView.AutoplayVideos = true;
      kdeglobals = {
        General = {
          BrowserApplication = "zen-twilight.desktop";
        };
      };
      kglobalshortcutsrc = {
        plasmashell = {
          "show-on-mouse-pos" = lib.mkForce "Meta+V,Meta+V,Show Clipboard Items at Mouse Position";
        };
      };
      klaunchrc.FeedbackStyle.BusyCursor = false;
      klipperrc.General.MaxClipItems = 1000;
      kwinrc = {
        TabBox = {
          HighlightWindows = false;
        };
      };
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
