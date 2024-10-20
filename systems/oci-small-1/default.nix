# common/default.nix
{
  lib,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  networking.hostName = "oci-small-1"; # Define your hostname.
  nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    # ../common/oci.nix
    ../common/default.nix
    # ../common/sops.nix
  ];
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = false;
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFfL/A140RdlJ1LQQR/lwtPwf0MAn5haqDdXGKWsW8sa brauni@desk''];
}
