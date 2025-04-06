{ config, pkgs, ... }:

{
  services = {
    tailscale.enable = true;
  };

  networking = {
    hostName = "nixos-prod";
    networkmanager = {
      enable = true;
    };
    firewall = {
      # enable the firewall
      enable = true;

      # always allow traffic from your Tailscale network
      trustedInterfaces = [ "tailscale0" ];

      # allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };
}
