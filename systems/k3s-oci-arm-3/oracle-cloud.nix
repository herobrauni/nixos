{ config
, lib
, pkgs
, ...
}: {
  networking.hostName = "k3s-oci-arm-3"; # Define your hostname.
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJmpZL3J2RqRK7ynIgowaZBKzI+EiuCGmwB6l0AxLk1v"
  ];

  # Set your time zone.
  time.timeZone = "Europe/Paris";


  system.stateVersion = "24.05"; # Did you read the comment?
}
