{ ... }:
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

  programs = {
    zsh = {
      enable = true;
      enableGlobalCompInit = false;
    };
  };

  documentation = {
    man.generateCaches = true;
    dev.enable = true;
  };
}
