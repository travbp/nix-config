{ config, pkgs, ... }:

{
  imports =
    [
      ./bootloader.nix
      ./network.nix
      ./persist.nix
      ./users.nix
      ./calibre-web-automated.nix
      ./calibre-web-automated-book-downloader.nix
    ];

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  nix.settings.experimental-features = ["nix-command" "flakes" ];

  system.stateVersion = "24.11";
}
