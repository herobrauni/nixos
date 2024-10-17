{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  environment.systemPackages = with pkgs; [
    dialog
    # libnotify
    fastfetch
    btop
    micro
    git
    curl
    wget
    fmt
    nixpkgs-fmt
    ripgrep
    rsync
    dig.dnsutils
    age
    sops
    zsh
    fish
  ];

  users.mutableUsers = false;
  users.users.brauni = {
    isNormalUser = true;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "lxd"
      "network"
      "podman"
      "video"
      "wheel"
    ];

    initialHashedPassword = "$y$j9T$d7EVWIrLInhGgEObbWa0A1$jomM5R056rhtJOOBH5vxC6GRnPMdqCb23ZKNWvqv1L9";
    packages = [pkgs.home-manager];
  };
}
