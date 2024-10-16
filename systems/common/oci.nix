{ lib
, inputs
, outputs
, pkgs
, ...
}: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fonts.fontconfig.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos";
  };
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  environment.systemPackages = with pkgs; [
    dialog
    # libnotify
    fastfetch
    btop
    micro
    git
    curl
    wget
    fmt
    nixpkgs-fmt
    ripgrep
    rsync
    dig.dnsutils
    tailscale
  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.qemuGuest.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJmpZL3J2RqRK7ynIgowaZBKzI+EiuCGmwB6l0AxLk1v"
  ];
  users.users.brauni.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPFkI1tmXLQ5awKEqqoEUMbCalSqARtODdy8nQ18pKk"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETmaz2oKUkpoSSeGKQefhFb+PUCEwY9Onh9+q1+hXXt"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAICvklcYlHcJVJzEAmkevC9eZ/rjCN7d1jhDHMBbVSmkqAAAABHNzaDo="
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJUzimGYl+VtbaQVuGkVRwxRBMQEJDsmD5g+YeHx2s9bAAAABHNzaDo="
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAINz7Y1oRX+SURSXOoNv5se/hrpi6VvLHK0T3zqz+q5kqAAAABHNzaDo="
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMqCCBIJ2ntASqsNfAt0aKXf7usA1kmJCHKOKldQk9Tx"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJmpZL3J2RqRK7ynIgowaZBKzI+EiuCGmwB6l0AxLk1v"
  ];
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "virtio_scsi" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.tmp.useTmpfs = false;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s6.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkForce "aarch64-linux";

  system.autoUpgrade = {
    enable = true;
    flake = "github:herobrauni/nixos";
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "95min";
    allowReboot = true;
  };

  sops.defaultSopsFile = ../../secrets.yaml;
  # This will automatically import SSH keys as age keys
  sops.secrets.tskey-auth = { };

  services.tailscale = {
    enable = true;
    authKeyFile = "/run/secrets/tskey-auth";
    useRoutingFeatures = "both";
    extraSetFlags = [
      "--advertise-exit-node"
      "--ssh"
    ];
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
