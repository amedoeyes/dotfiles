{
  config =
    { pkgs, ... }:
    {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

  home =
    { pkgs, lib, ... }:
    {
      home.packages = with pkgs; [
        nix-index
        wl-clipboard-rs
        xdg-utils
      ];

      xdg.portal.enable = lib.mkForce false;

      programs = {
        btop.enable = true;
        direnv.enable = true;
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
        lazygit.enable = true;
        nixCats = {
          enable = true;
          default = true;
          unwrap = true;
        };
        ripgrep.enable = true;
        vifm.enable = true;
        zsh.enable = true;
      };
    };
}
