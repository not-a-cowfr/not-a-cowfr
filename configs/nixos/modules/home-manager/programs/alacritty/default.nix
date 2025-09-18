{ ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        startup_mode = "Maximized";
      };

      font = {
        normal = {
          family = "ComicShannsMono Nerd Font Mono";
        };
      };

      cursor = {
        style = {
          shape = "Beam";
          blinking = "Off";
        };
      };

      terminal = {
        osc52 = "CopyPaste";
        shell = {
          program = "/home/andrew/.nix-profile/bin/nu";
        };
      };
    };
  };
}
