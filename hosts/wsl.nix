{ pkgs, ... }:
{

  wsl = {
    enable = true;
    defaultUser = "wsl";
  };

  nixpkgs.hostPlatform = "x86_64-linux";

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
      enableGlobalCompInit = false;
    };
  };

  documentation.man.generateCaches = true;
}
