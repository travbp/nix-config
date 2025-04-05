{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.11";

  networking.hostName = "nixos-prod"; # Define your hostname.
  # networking.domain = "travis-peter.com";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.travis = {
    isNormalUser = true;
    description = "travis";
    initialPassword = "password";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # vim
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    tailscale
    git
    adguardhome
  ];

  # List services that you want to enable:
  services = {
    tailscale.enable = true;
  };
  
  networking.firewall = {
    # enable the firewall
    enable = true;
  
    # always allow traffic from your Tailscale network
    trustedInterfaces = [ "tailscale0" ];
  
    # allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];

  };

  nix.settings.experimental-features = ["nix-command" "flakes" ];

}
