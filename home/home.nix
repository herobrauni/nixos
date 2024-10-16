# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    #    ./bazzite.nix
  ];

  nixpkgs = {
    # Configure your nixpkgs instance
    config.allowUnfree = true;
  };

  home = {
    username = "brauni";
    homeDirectory = "/home/brauni";
  };

  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    comma # Install and run programs by sticking a , before them
    # distrobox # Nice escape hatch, integrates docker images with my environment

    # bc # Calculator
    # bottom # System viewer
    # ncdu # TUI disk usage
    # eza # Better ls
    # ripgrep # Better grep
    # fd # Better find
    # httpie # Better curl
    # diffsitter # Better diff
    # jq # JSON pretty printer and manipulator
    # timer # To help with my ADHD paralysis

    nixd # Nix LSP
    alejandra # Nix formatter
    nixpkgs-fmt
    nixfmt-rfc-style
    nvd # Differ
    nix-diff # Differ, more detailed
    nix-output-monitor
    nh # Nice wrapper for NixOS and HM
    ltex-ls # Spell checking LSP
  ];
  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
