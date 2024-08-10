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
    ./apps/foot.nix
    # ./apps/alacritty.nix
  ];

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
