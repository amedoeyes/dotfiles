{ pkgs, ... }:
{

  wsl = {
    enable = true;
    defaultUser = "wsl";
  };

  nix = {
    settings = {
      use-xdg-base-directories = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment = {
    shellAliases = pkgs.lib.mkForce { };
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = false;
      enableLsColors = false;
      promptInit = "";
    };
  };

  documentation.man.generateCaches = true;

  system.stateVersion = "25.05";
}
