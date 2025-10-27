{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      monitor = ",preferred,auto,1"; # auto-detect primary display

      input = {
        kb_layout = "us,us";
        repeat_delay = 250;
        repeat_rate = 40;
        touchpad = {
          natural_scroll = true;
          # middle_button_emulation = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 8;
        border_size = 2;
        layout = "dwindle";
        # "col.active_border" = "rgb(88c0d0)";
        # "col.inactive_border" = "rgb(3b4252)";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
        workspace_swipe_distance = 250;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 15;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = false;
      };

      bind = [
        "SUPER, D, exec, zen-browser"
        # "SUPER+SHIFT,S,exec,grim -g \"$(slurp)\" - | wl-copy" # screenshot region
        # "SUPER+CTRL,S,exec,grim - | wl-copy"                 # screenshot full
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, right, workspace, +1"
        "SUPER, left, workspace, -1"
        "SUPERSHIFT, S, exec, rofi -show drun -show-icons"
      ];

      # Workspace rules (like KWin window-rules)
      windowrulev2 = [
        "workspace 1,class:^(ghostty)$"
        "workspace 1,class:^(Alacritty)$"
        "workspace 1,class:^(GitHub Desktop)$"

        "workspace 2,class:^(VSCodium)$"
        "workspace 2,class:^(jetbrains-idea)$"

        "workspace 3,class:^(zen)$"
        "workspace 3,class:^(Spotify)$"

        "workspace 4,class:^(zoom)$"
        "workspace 4,class:^(legcord)$"
      ];

      # Autostart wallpaper daemon
      exec-once = [
        "hyprpaper"
        "waybar"
      ];

      misc = {
        # disable_autoreload = true;
        disable_hyprland_logo = true;
        # vrr = 2;
        focus_on_activate = true;
        animate_manual_resizes = false;
      };
    };
  };

  # Hyprpaper config for wallpaper
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${config.home.homeDirectory}/.wallpapers/wallpaper.jpg
    wallpaper = ,${config.home.homeDirectory}/.wallpapers/wallpaper.jpg
  '';

  # Waybar basic config
  xdg.configFile."waybar/config".text = builtins.toJSON {
    layer = "top";
    position = "bottom";
    modules-left = [
      "workspaces"
      "window"
    ];
    modules-center = [ "clock" ];
    modules-right = [
      "tray"
      "battery"
      "network"
      "pulseaudio"
    ];
    clock = {
      format = "{:%Y-%m-%d %H:%M}";
    };
  };
  xdg.configFile."waybar/style.css".text = ''
    * {
      font-family: "Comic Sans MS", sans-serif;
      font-size: 12pt;
      color: #eceff4;
    }
    #workspaces button.focused {
      background: #88c0d0;
    }
  '';
}
