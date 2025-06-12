{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      users = {
        amedoeyes = {
          extraGroups = [ "wheel" ];
          home =
            { pkgs, ... }:
            {
              imports = [ ./home ];
              home.packages = with pkgs; [
                blobdrop
                btop
                cava
                cmus
                cmusfm
                ffmpeg
                git
                highlight
                imagemagick
                imv
                lazygit
                mpv
                mpvScripts.mpris
                mpvScripts.webtorrent-mpv-hook
                neomutt
                newsboat
                nix-index
                pass
                qutebrowser
                ripgrep
                urlscan
                vifm
                w3m
                weechat
                wf-recorder
                wget
                yt-dlp
                zathura
                zk
              ];
            };
        };
      };
    in
    {
      nixosConfigurations.iris = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          (
            { pkgs, ... }:
            {
              users = {
                defaultUserShell = pkgs.zsh;
                users = nixpkgs.lib.mapAttrs (name: user: {
                  isNormalUser = true;
                  inherit (user) extraGroups;
                }) users;
              };
            }
          )

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users = nixpkgs.lib.mapAttrs (name: user: {
              imports = [ user.home ];
              home = {
                username = name;
                homeDirectory = "/home/${name}";
              };
            }) users;
          }
        ];
      };
    };
}
