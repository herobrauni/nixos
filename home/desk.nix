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
#    ./apps/firefox.nix
#    ./apps/alacritty.nix
#    ./apps/zsh.nix
#    ./apps/font.nix
#    ./apps/kube.nix
    ./apps/nix-index.nix
  ];
  home.packages = with pkgs; [
    # shipwright
    # _2ship2harkinian
    ferdium
    vlc
    rbw
    # freerdp
    freerdp3
    remmina
    notes
    wineWowPackages.stable
    lutris
  ];

  programs.starship.settings = {
    battery = {
      display = [
        {
          style = "bold red";
          threshold = 10;
        }
        {
          style = "bold yellow";
          threshold = 30;
        }
        {
          style = "bold green";
          threshold = 100;
        }
      ];
    };
  };

  dconf.settings."org/gnome/desktop/wm/preferences".button-layout = "minimize,maximize,close";

  services.nextcloud-client.enable = true;

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
