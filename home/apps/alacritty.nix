{ config, lib, pkgs, ... }:
{
  imports = [ ./nixgl.nix ];
  programs.alacritty = {
    package = (config.nixGL.wrap pkgs.alacritty);
    enable = true;
  };
}
