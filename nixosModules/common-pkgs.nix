{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fd # a faster "find" alternative
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    xcp # a faster "cp" alternative
    rename # bulk rename files easily
    dust # a way cooler "du" alternative
    dua # an interactive TUI disk usage analyzer
    mprocs # a manager for long-running processes
    urlencode
    sendme # easy p2p e2ee file sharing based on the iroh network
    dumbpipe # a unix pipe running over the iroh network

    # networking tools
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provides the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    wget
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses
    inetutils # stuff like telnet, etc.
    iw

    # misc
    file
    tree
    zstd
    gnupg
    vim
    wl-clipboard
    fastfetch
    watchexec

    # system monitoring
    htop
    lsof

    # system tools
    sysstat
    ethtool
    pciutils # lspci
    usbutils # lsusb

    nix-output-monitor

    # Nix language servers
    nil
    nixd
    alejandra # formatter
  ];

  # TODO: extract to module
  programs = {
    git.enable = true;
    zsh.enable = true;
  };

  # Not really a package, but fixes ZSH completion for system packages
  # See home-manager programs.zsh.enableCompletion
  environment.pathsToLink = ["/share/zsh"];
}
