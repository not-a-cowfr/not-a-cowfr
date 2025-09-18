{ userConfig, ... }:
{
  programs.git = {
    enable = true;
    userName = "not a cow";
    userEmail = "104255555+not-a-cowfr@users.noreply.github.com";
    # signing = {
    #   key = userConfig.gitKey;
    #   signByDefault = true;
    # };
    extraConfig = {
      pull.rebase = "true";
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };
}
