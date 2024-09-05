# common/default.nix
{ lib
, inputs
, outputs
, pkgs
, ...
}: {
  networking.hostName = "k3s-oci-arm-2"; # Define your hostname.

  imports =
    [
      # Include the results of the hardware scan.
      inputs.home-manager.nixosModules.home-manager
      ./disko.nix
      ../common/oci.nix
      ../common/default.nix
      ../common/sops.nix
      ../common/k3s-agent.nix
    ];
}
