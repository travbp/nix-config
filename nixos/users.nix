{

  users = {
    mutableUsers = false;
    users = {
      root = {
      	# disable root login here, and also when installing nix by running nixos-install --no-root-passwd
        # https://discourse.nixos.org/t/how-to-disable-root-user-account-in-configuration-nix/13235/3
        hashedPassword = "!";  # disable root logins, nothing hashes to !
      };
      travis = {
      	isNormalUser = true;
      	description = "travis";
        hashedPasswordFile = "/persist/passwords/travis";  
	      extraGroups = [ "wheel" "networkmanager" ];
      };
    };
  };

}