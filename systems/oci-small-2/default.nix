# common/default.nix
{
  lib,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  networking.hostName = "oci-small-2"; # Define your hostname.
  nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";

  imports = [
    # Include the results of the hardware scan.
    inputs.home-manager.nixosModules.home-manager
    ./disko.nix
    ../common/oci.nix
    ../common/default.nix
    ../common/sops.nix
  ];
}
