# common/default.nix
{ lib
, inputs
, outputs
, pkgs
, ...
}: {
  imports = [
    ../nixos/configuration.nix
    ./disk-config.nix
    ./hardware-configuration.nix
    ./oracle-cloud.nix
  ];
}
