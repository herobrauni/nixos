# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
{
  # You can import other home-manager modules here
  imports = [
    ./apps/firefox.nix
    ./apps/alacritty.nix
    ./apps/zsh.nix
    ./apps/font.nix
  ];
  home.packages = with pkgs; [
    shipwright
    _2ship2harkinian
    ferdium
  ];

  dconf.settings."org/gnome/desktop/wm/preferences".button-layout = "minimize,maximize,close";

  programs = {
    git = {
      enable = true;
      userName = "brauni@envy";
      userEmail = "braunnicolaj@gmail.com";
    };
    vscode = {
      enable = true;
    };
  };
}
