{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      hosts = [
        {
          name = "iris";
          users = [ "amedoeyes" ];
          modules = [ ];
        }
        {
          name = "wsl";
          users = [ "wsl" ];
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
              inherit (host) name;
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
