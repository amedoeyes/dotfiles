{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mprisctl = {
      url = "github:amedoeyes/mprisctl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      hosts = [
        {
          name = "iris";
          users = [ "amedoeyes" ];
          monitors = [
            {
              name = "eDP-1";
              resolution = {
                width = 1600;
                height = 900;
              };
              position = {
                x = 0;
                y = 0;
              };
            }
            {
              name = "DP-2";
              resolution = {
                width = 1366;
                height = 768;
              };
              position = {
                x = 1600;
                y = 0;
              };
            }
          ];
          modules = [ ];
        }
        {
          name = "wsl";
          users = [ "wsl" ];
          monitors = [ ];
          modules = [ inputs.nixos-wsl.nixosModules.default ];
        }
      ];
    in
    {
      nixosConfigurations = nixpkgs.lib.foldl' (
        acc: host:
        acc
        // {
          ${host.name} = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              inherit (host) name monitors;
              users = nixpkgs.lib.foldl' (
                acc: user: acc // { ${user} = import ./users/${user}.nix; }
              ) { } host.users;
            };
            modules = host.modules ++ [
              ./hosts
              ./home
            ];
          };
        }
      ) { } hosts;
    };
}
