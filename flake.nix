{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
          system = "x86_64-linux";
          users = [
            "amedoeyes"
            "gamer"
          ];
        }
      ];
    in
    {
      nixosConfigurations = nixpkgs.lib.foldl' (
        acc: host:
        acc
        // {
          ${host.name} = nixpkgs.lib.nixosSystem {
            inherit (host) system;
            specialArgs = {
              inherit inputs;
              inherit (host) name;
              users = nixpkgs.lib.foldl' (
                acc: user: acc // { ${user} = import ./users/${user}.nix; }
              ) { } host.users;
            };
            modules = [
              ./hosts
              ./home
            ];
          };
        }
      ) { } hosts;
    };
}
