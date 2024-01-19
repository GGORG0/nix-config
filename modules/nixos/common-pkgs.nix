{
  lib,
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    neofetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    # exa # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

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

    # misc
    file
    tree
    zstd
    gnupg
    vim
    wl-clipboard

    # nix related
    nix-output-monitor
    comma

    # system monitoring
    htop
    btop
    lsof

    # system tools
    sysstat
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  programs.git.enable = true;
}
