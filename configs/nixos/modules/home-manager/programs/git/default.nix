{ userConfig, ... }:
{
  programs.git = {
    enable = true;

    # signing = {
    #   key = userConfig.gitKey;
    #   signByDefault = true;
    # };

    settings = {
      user = {
        name = "not a cow";
        email = "104355555+not-a-cowfr@users.noreply.github.com";
      };

      pull.rebase = true;
      push.autoSetupRemote = true;

      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };
}
