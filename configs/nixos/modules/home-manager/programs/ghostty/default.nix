{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    settings = {
      	font-family = "ComicShannsMono Nerd Font Mono";
		font-size = 10;

		theme = "Afterglow";
		# background = 202222;
		# background-opacity = 0.8;
		# background-blur = true;

		cursor-style = "bar";
		cursor-style-blink = false;

		command = "nu";

		maximize = true;
    };
  };
}
