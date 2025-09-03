{ config, inputs, ... }:
{
  programs.git.config = {
    enable = true;
    userName = "not a cow";
    userEmail = "104255555+not-a-cowfr@users.noreply.github.com";
    config = {
      init.defaultBranch = "main";
      credential.helper = "store"; # permanently store cerdentials
    };
  };
}
