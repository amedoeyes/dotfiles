{ pkgs, config, ... }:
{
  home = {
    pointerCursor = with config.theme; {
      enable = true;
      dotIcons.enable = false;
      name = "eyes-${palette}";
      size = 16;
      package = pkgs.simp1e-cursors.overrideAttrs (_: {
        preBuild =
          let
            colorscheme =
              with colors;
              pkgs.writeText "simp1e-cursors-colorscheme.txt" ''
                name:eyes-${palette}
                shadow:000000
                shadow_opacity:0.0
                cursor_border:${c10.hex}
                default_cursor_bg:${c00.hex}
                hand_bg:${c00.hex}
                question_mark_fg:${c10.hex}
                question_mark_bg:${c00.hex}
                plus_fg:${c10.hex}
                plus_bg:${c00.hex}
                link_fg:${c10.hex}
                link_bg:${c00.hex}
                move_fg:${c10.hex}
                move_bg:${c00.hex}
                context_menu_fg:${c10.hex}
                context_menu_bg:${c00.hex}
                forbidden_fg:${c10.hex}
                forbidden_bg:${c00.hex}
                magnifier_fg:${c10.hex}
                magnifier_bg:${c00.hex}
                skull_eye:${c10.hex}
                skull_bg:${c00.hex}
                spinner_fg1:${c10.hex}
                spinner_fg2:${c10.hex}
                spinner_bg:${c00.hex}
              '';
          in
          ''
            rm src/color_schemes/*.txt
            cp ${colorscheme} src/color_schemes/colorscheme.txt
          '';
      });
    };
  };
}
