{ config, pkgs, inputs, ... }:

{

  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.username = "travis";
  home.homeDirectory = "/home/travis";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    vim
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  home.persistence."/persist/home" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".ssh"
      ".nixops"
      ".local/share/keyrings"
      ".local/share/direnv"
    ];
    # files = [
    #   ".screenrc"
    # ];
    allowOther = true;
  };


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}