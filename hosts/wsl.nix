{
  profile =
    { inputs, ... }:
    {
      modules = [ inputs.nixos-wsl.nixosModules.default ];
      users = {
        wsl = {
          user =
            { pkgs, ... }:
            {
              shell = pkgs.fish;
              isNormalUser = true;
              extraGroups = [ "wheel" ];
            };

          home =
            { pkgs, lib, ... }:
            {
              home.packages = with pkgs; [
                nix-index
                wl-clipboard
                xdg-utils
                spell
              ];

              xdg.portal.enable = lib.mkForce false;

              programs = {
                btop.enable = true;
                dircolors.enable = true;
                direnv.enable = true;
                fish.enable = true;
                fzf.enable = true;
                git = {
                  enable = true;
                  settings = {
                    user = {
                      email = "ahmed.aboeleyoun@trufla.com";
                      name = "Ahmed AbouEleyoun";
                    };
                  };
                };
                helix = {
                  enable = true;
                  default = true;
                };
                lazygit.enable = true;
                yazi.enable = true;
                zk.enable = true;
              };
            };
        };
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
