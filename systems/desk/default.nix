{ config, pkgs, inputs, outputs, lib, ... }:

{
  networking.hostName = "desk"; # Define your hostname.
  imports =
    [
      # Include the results of the hardware scan.
      inputs.home-manager.nixosModules.home-manager
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.nixos-cosmic.nixosModules.default
      ./hardware-configuration.nix
      ./disko.nix
      ../common
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fonts.fontconfig.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos";
  };

  # Bootloader
  boot = {
    loader = {
      systemd-boot =
        {
          enable = lib.mkForce false;
          # extraEntries = {
          #   "windows.conf" = ''
          #     title Windows
          #     efi /efi/memtest86/memtest.efi
          #     sort-key z_memtest
          #   '';
          # };
        };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    initrd.systemd.enable = true;
    #    plymouth.enable = true;
    #    kernelParams = [ 
    #      "initcall_blacklist=simpledrm_platform_driver_init" 
    #      "nvidia-drm.fbdev=1" 
    #       "nvidia.NVreg_OpenRmEnableUnsupportedGpus=1"
    #    ];
    #    plymouth.theme = "proxzima";
    #    plymouth.themePackages = [ pkgs.plymouth-proxzima-theme ];
  };
  systemd.sleep.extraConfig = "HibernateMode=shutdown";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";


  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "intl";
  };

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
  #  services.xserver.desktopManager.gnome .enable = true;
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.cosmic.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-cosmic
    ];
    xdgOpenUsePortal = true;
  };
  #  services.displayManager.cosmic-greeter.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.steam.enable = true;
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
    yubikey-personalization
    ripgrep
    pavucontrol
    rsync
    podman-compose
    # freerdp
    # freerdp3
    pulseaudio
    cifs-utils
    dig.dnsutils
    sbctl
    cosmic-screenshot
    cosmic-bg
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
