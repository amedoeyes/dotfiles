{
  profile =
    { inputs, ... }:
    {
      modules = [ inputs.nixos-wsl.nixosModules.default ];
      users = {
        wsl = import ../users/wsl.nix;
      };
      monitors = [ ];
    };

  system =
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
            "pipe-operators"
          ];
        };
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      };

      programs = {
        fish.enable = true;
      };

      documentation = {
        man.generateCaches = true;
        dev.enable = true;
      };
    };
}
