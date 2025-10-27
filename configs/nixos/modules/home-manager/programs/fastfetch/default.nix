{ ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "/etc/nixos/modules/home-manager/programs/fastfetch/nixos.png";
      };

      display = {
        separator = " ➜  ";
      };

      modules = [
        "break"
        "break"
        {
          type = "os";
          key = "OS        ";
          keyColor = "red";
        }
        {
          type = "kernel";
          key = "├ kernel  ";
          keyColor = "red";
        }
        {
          type = "packages";
          key = "├ packages";
          keyColor = "red";
        }
        {
          type = "shell";
          key = "└ shell   ";
          keyColor = "red";
        }
        "break"
        {
          type = "wm";
          key = "WM        ";
          keyColor = "green";
        }
        {
          type = "wmtheme";
          key = "├ theme   ";
          keyColor = "green";
        }
        {
          type = "icons";
          key = "├ icons   ";
          keyColor = "green";
        }
        {
          type = "cursor";
          key = "├ cursor  ";
          keyColor = "green";
        }
        {
          type = "terminal";
          key = "├ terminal";
          keyColor = "green";
        }
        {
          type = "terminalfont";
          key = "└ font    ";
          keyColor = "green";
        }
        "break"
        {
          type = "host";
          format = "{5} {1} Type {2}";
          key = "PC        ";
          keyColor = "yellow";
        }
        {
          type = "cpu";
          format = "{1} ({3} cores) @ {7}";
          key = "├ cpu     ";
          keyColor = "yellow";
        }
        {
          type = "gpu";
          format = "{1} {2} @ {12}";
          key = "├ gpu     ";
          keyColor = "yellow";
        }
        {
          type = "memory";
          key = "├ memory  ";
          keyColor = "yellow";
        }
        {
          type = "swap";
          key = "├ swap    ";
          keyColor = "yellow";
        }
        {
          type = "disk";
          key = "├ disk    ";
          keyColor = "yellow";
        }
        {
          type = "monitor";
          format = "{2}x{3} @ {11} Hz";
          key = "├ monitor ";
          keyColor = "yellow";
        }
        {
          type = "custom";
          format = "7 maybe 7.2";
          key = "└ weight  ";
          keyColor = "yellow";
        }
        "break"
      ];
    };
  };
}
