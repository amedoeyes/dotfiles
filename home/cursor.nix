{
  pkgs,
  lib,
  config,
  ...
}:
{
  home = {
    pointerCursor = {
      enable = true;
      dotIcons.enable = false;
      name = "eyes-${config.theme.palette}";
      size = 16;
      package =
        let
          stripHash = lib.strings.removePrefix "#";
        in
        (pkgs.simp1e-cursors.overrideAttrs (oldAttrs: {
          preBuild = ''
            rm src/color_schemes/*.txt

            cat > src/color_schemes/eyes-dark.txt <<EOF
                name:eyes-dark

                shadow:000000
                shadow_opacity:0.0

                cursor_border:${stripHash config.theme.darkColors.hex10}

                default_cursor_bg:${stripHash config.theme.darkColors.hex00}
                hand_bg:${stripHash config.theme.darkColors.hex00}

                question_mark_fg:${stripHash config.theme.darkColors.hex10}
                question_mark_bg:${stripHash config.theme.darkColors.hex00}

                plus_fg:${stripHash config.theme.darkColors.hex10}
                plus_bg:${stripHash config.theme.darkColors.hex00}

                link_fg:${stripHash config.theme.darkColors.hex10}
                link_bg:${stripHash config.theme.darkColors.hex00}

                move_fg:${stripHash config.theme.darkColors.hex10}
                move_bg:${stripHash config.theme.darkColors.hex00}

                context_menu_fg:${stripHash config.theme.darkColors.hex10}
                context_menu_bg:${stripHash config.theme.darkColors.hex00}

                forbidden_fg:${stripHash config.theme.darkColors.hex10}
                forbidden_bg:${stripHash config.theme.darkColors.hex00}

                magnifier_fg:${stripHash config.theme.darkColors.hex10}
                magnifier_bg:${stripHash config.theme.darkColors.hex00}

                skull_eye:${stripHash config.theme.darkColors.hex10}
                skull_bg:${stripHash config.theme.darkColors.hex00}

                spinner_fg1:${stripHash config.theme.darkColors.hex10}
                spinner_fg2:${stripHash config.theme.darkColors.hex10}
                spinner_bg:${stripHash config.theme.darkColors.hex00}
            EOF

            cat > src/color_schemes/eyes-light.txt <<EOF
                name:eyes-light

                shadow:000000
                shadow_opacity:0.0

                cursor_border:${stripHash config.theme.lightColors.hex10}

                default_cursor_bg:${stripHash config.theme.lightColors.hex00}
                hand_bg:${stripHash config.theme.lightColors.hex00}

                question_mark_fg:${stripHash config.theme.lightColors.hex10}
                question_mark_bg:${stripHash config.theme.lightColors.hex00}

                plus_fg:${stripHash config.theme.lightColors.hex10}
                plus_bg:${stripHash config.theme.lightColors.hex00}

                link_fg:${stripHash config.theme.lightColors.hex10}
                link_bg:${stripHash config.theme.lightColors.hex00}

                move_fg:${stripHash config.theme.lightColors.hex10}
                move_bg:${stripHash config.theme.lightColors.hex00}

                context_menu_fg:${stripHash config.theme.lightColors.hex10}
                context_menu_bg:${stripHash config.theme.lightColors.hex00}

                forbidden_fg:${stripHash config.theme.lightColors.hex10}
                forbidden_bg:${stripHash config.theme.lightColors.hex00}

                magnifier_fg:${stripHash config.theme.lightColors.hex10}
                magnifier_bg:${stripHash config.theme.lightColors.hex00}

                skull_eye:${stripHash config.theme.lightColors.hex10}
                skull_bg:${stripHash config.theme.lightColors.hex00}

                spinner_fg1:${stripHash config.theme.lightColors.hex10}
                spinner_fg2:${stripHash config.theme.lightColors.hex10}
                spinner_bg:${stripHash config.theme.lightColors.hex00}
            EOF
          '';
        }));
    };
  };
}
