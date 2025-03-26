{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.ssh = {
      enable = lib.mkEnableOption "SSH configuration" // {default = true;};
    };
  };

  config = {
    programs.ssh = lib.mkIf config.ggorg.ssh.enable {
      enable = true;

      forwardAgent = true;

      matchBlocks = let
        forwardGPG = {remote-uid ? 1000}: {
          bind.address = "/run/user/1000/gnupg/S.gpg-agent.extra";
          host.address = "/run/user/${builtins.toString remote-uid}/gnupg/S.gpg-agent";
        };
        simpleHost = hostname: {
          inherit hostname;
          user = "ggorg";
          remoteForwards = [(forwardGPG {})];
        };
      in {
        "*".setEnv.TERM = "xterm-256color"; # Not everything has xterm-kitty terminfo installed

        pi = simpleHost "server-pi.local";
        x395 = simpleHost "ggorg-x395.local";
        elitebook = simpleHost "ggorg-elitebook.local";
      };
    };
  };
}
