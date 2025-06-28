{
  inputs,
  lib,
  users,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = lib.mapAttrs (username: user: {
      imports = [
        ./cursor.nix
        ./modules
        ./programs
        ./services
        ./window_managers
        ./xdg.nix
        user.home
      ];

      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "25.05";
      };
    }) users;
  };
}
