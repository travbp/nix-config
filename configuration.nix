{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      # ./modules/adguard.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-prod"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # disable power management to hopefully prevent sleeping
  powerManagement.enable = false;

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

  # Disable the GNOME3/GDM auto-suspend feature that cannot be disabled in GUI!
  # If no user is logged in, the machine will power down after 20 minutes.
  
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

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
  
  systemd.services.tailscaled.after=["NetworkManager-wait-online.service"];

  # create a oneshot job to authenticate to Tailscale
  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";
  
    # make sure tailscale is running before trying to connect to tailscale
    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    # set this service as a oneshot job
    serviceConfig.Type = "oneshot";

    # have the job run this shell script
    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2
  
      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      # otherwise authenticate with tailscale
      ${tailscale}/bin/tailscale up --ssh --auth-key=
    '';
  };

  networking.firewall = {
    # enable the firewall
    enable = true;
  
    # always allow traffic from your Tailscale network
    trustedInterfaces = [ "tailscale0" ];
  
    # allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];

  };

  system.stateVersion = "24.05"; # Did you read the comment?

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };


  #adguard
  networking = {
    firewall.interfaces.tailscale0 = {
      allowedTCPPorts = [
        3000 
        853
      ];
      allowedUDPPorts = [
        53
        853
      ];
    };
  };

  services = {
    adguardhome = {
      enable = true;
    };
  };

}
