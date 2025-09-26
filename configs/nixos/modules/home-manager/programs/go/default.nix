{ ... }:
{
  programs.go = {
    enable = true;

    env = {
      GOBIN = "go/bin";
      GOPATH = "go";
    };
  };

  home.sessionPath = [
    "$HOME/go/bin"
  ];
}
