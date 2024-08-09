{ config, pkgs, inputs, outputs, lib, ... }:

{
  networking.hostName = "envy"; # Define your hostname.
  imports =
    [
      # Include the results of the hardware scan.
      inputs.home-manager.nixosModules.home-manager
      ./hardware-configuration.nix
      ./disko.nix
      ../common
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/nixconfig";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.consoleLogLevel = 0;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome .enable = true;

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    fastfetch
    btop
    micro
    git
    curl
    wget
    fmt
    nixpkgs-fmt
    yubikey-personalization
    ripgrep
    pavucontrol
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
