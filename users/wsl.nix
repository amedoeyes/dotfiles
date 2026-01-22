{
  config =
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
}
