{ lib, config, ... }:
let
  cfg = config.programs.zathura;
in
{
  config.programs.zathura =
    let
      hex10rgb =
        let
          normalizedHex = lib.removePrefix "#" config.theme.colors.hex10;
          hexToDec =
            h:
            let
              chars = lib.stringToCharacters (lib.toLower h);
              toVal =
                c:
                if c == "a" then
                  10
                else if c == "b" then
                  11
                else if c == "c" then
                  12
                else if c == "d" then
                  13
                else if c == "e" then
                  14
                else if c == "f" then
                  15
                else
                  lib.toInt c;
            in
            (toVal (builtins.elemAt chars 0)) * 16 + (toVal (builtins.elemAt chars 1));
        in
        {
          r = toString (hexToDec (lib.substring 0 2 normalizedHex));
          g = toString (hexToDec (lib.substring 2 2 normalizedHex));
          b = toString (hexToDec (lib.substring 4 2 normalizedHex));
        };
    in
    lib.mkIf cfg.enable {
      options = {
        selection-clipboard = "clipboard";
        selection-notification = false;

        window-title-basename = true;

        scroll-step = 50;
        font = "${config.theme.font.name} ${toString config.theme.font.size}";

        recolor = true;
        recolor-lightcolor = config.theme.colors.hex00;
        recolor-darkcolor = config.theme.colors.hex10;

        default-fg = config.theme.colors.hex10;
        default-bg = config.theme.colors.hex00;

        notification-fg = config.theme.colors.hex10;
        notification-bg = config.theme.colors.hex00;

        notification-error-fg = config.theme.colors.hex10;
        notification-error-bg = config.theme.colors.hex00;

        notification-warning-fg = config.theme.colors.hex10;
        notification-warning-bg = config.theme.colors.hex00;

        completion-fg = config.theme.colors.hex10;
        completion-bg = config.theme.colors.hex00;

        completion-group-fg = config.theme.colors.hex10;
        completion-group-bg = config.theme.colors.hex00;

        completion-highlight-fg = config.theme.colors.hex10;
        completion-highlight-bg = config.theme.colors.hex01;

        index-fg = config.theme.colors.hex10;
        index-bg = config.theme.colors.hex00;

        index-active-fg = config.theme.colors.hex10;
        index-active-bg = config.theme.colors.hex01;

        inputbar-fg = config.theme.colors.hex10;
        inputbar-bg = config.theme.colors.hex00;

        statusbar-fg = config.theme.colors.hex10;
        statusbar-bg = config.theme.colors.hex00;

        highlight-color = "rgba(${hex10rgb.r},${hex10rgb.g},${hex10rgb.b},0.1)";
        highlight-active-color = "rgba(${hex10rgb.r},${hex10rgb.g},${hex10rgb.b},0.3)";

        render-loading = true;
        render-loading-fg = config.theme.colors.hex10;
        render-loading-bg = config.theme.colors.hex00;
      };
    };
}
