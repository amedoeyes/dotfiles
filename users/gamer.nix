{
  config =
    { pkgs, ... }:
    {
      shell = pkgs.zsh;
      isNormalUser = true;
    };

  home =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [
        blobdrop
        nix-index
        select-geometry
        wf-recorder
        vesktop
        prismlauncher
      ];

      programs = {
        btop.enable = true;
        cava.enable = true;
        cmus.enable = true;
        fzf.enable = true;
        imv.enable = true;
        less.enable = true;
        qutebrowser.enable = true;
        ripgrep.enable = true;
        swaylock.enable = true;
        vifm.enable = true;
        waybar.enable = true;
        zsh.enable = true;

        mpv = {
          enable = true;
          config = {
            hwdec = "vaapi";
            gpu-api = "opengl";
          };
        };

        foot = {
          enable = true;
          default = true;
        };

        nixCats = {
          enable = true;
          default = true;
        };
      };

      services = {
        batsignal.enable = true;
        cliphist.enable = true;
        mako.enable = true;
        swayidle.enable = true;
      };

      wayland.windowManager.sway.enable = true;
    };
}
