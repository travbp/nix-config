{ pkgs, lib, ... }: {
  config = {
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
  };
}