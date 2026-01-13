{ pkgs, config, ... }:
{
  home = {
    pointerCursor = {
      enable = true;
      dotIcons.enable = false;
      name = "eyes-${config.theme.palette}";
      size = 16;
      package = pkgs.simp1e-cursors.overrideAttrs (oldAttrs: {
        preBuild = ''
          rm src/color_schemes/*.txt

          cat > src/color_schemes/eyes-dark.txt <<EOF
              name:eyes-dark

              shadow:000000
              shadow_opacity:0.0

              cursor_border:${config.theme.darkColors.c10.hex}

              default_cursor_bg:${config.theme.darkColors.c00.hex}
              hand_bg:${config.theme.darkColors.c00.hex}

              question_mark_fg:${config.theme.darkColors.c10.hex}
              question_mark_bg:${config.theme.darkColors.c00.hex}

              plus_fg:${config.theme.darkColors.c10.hex}
              plus_bg:${config.theme.darkColors.c00.hex}

              link_fg:${config.theme.darkColors.c10.hex}
              link_bg:${config.theme.darkColors.c00.hex}

              move_fg:${config.theme.darkColors.c10.hex}
              move_bg:${config.theme.darkColors.c00.hex}

              context_menu_fg:${config.theme.darkColors.c10.hex}
              context_menu_bg:${config.theme.darkColors.c00.hex}

              forbidden_fg:${config.theme.darkColors.c10.hex}
              forbidden_bg:${config.theme.darkColors.c00.hex}

              magnifier_fg:${config.theme.darkColors.c10.hex}
              magnifier_bg:${config.theme.darkColors.c00.hex}

              skull_eye:${config.theme.darkColors.c10.hex}
              skull_bg:${config.theme.darkColors.c00.hex}

              spinner_fg1:${config.theme.darkColors.c10.hex}
              spinner_fg2:${config.theme.darkColors.c10.hex}
              spinner_bg:${config.theme.darkColors.c00.hex}
          EOF

          cat > src/color_schemes/eyes-light.txt <<EOF
              name:eyes-light

              shadow:000000
              shadow_opacity:0.0

              cursor_border:${config.theme.lightColors.c10.hex}

              default_cursor_bg:${config.theme.lightColors.c00.hex}
              hand_bg:${config.theme.lightColors.c00.hex}

              question_mark_fg:${config.theme.lightColors.c10.hex}
              question_mark_bg:${config.theme.lightColors.c00.hex}

              plus_fg:${config.theme.lightColors.c10.hex}
              plus_bg:${config.theme.lightColors.c00.hex}

              link_fg:${config.theme.lightColors.c10.hex}
              link_bg:${config.theme.lightColors.c00.hex}

              move_fg:${config.theme.lightColors.c10.hex}
              move_bg:${config.theme.lightColors.c00.hex}

              context_menu_fg:${config.theme.lightColors.c10.hex}
              context_menu_bg:${config.theme.lightColors.c00.hex}

              forbidden_fg:${config.theme.lightColors.c10.hex}
              forbidden_bg:${config.theme.lightColors.c00.hex}

              magnifier_fg:${config.theme.lightColors.c10.hex}
              magnifier_bg:${config.theme.lightColors.c00.hex}

              skull_eye:${config.theme.lightColors.c10.hex}
              skull_bg:${config.theme.lightColors.c00.hex}

              spinner_fg1:${config.theme.lightColors.c10.hex}
              spinner_fg2:${config.theme.lightColors.c10.hex}
              spinner_bg:${config.theme.lightColors.c00.hex}
          EOF
        '';
      });
    };
  };
}
