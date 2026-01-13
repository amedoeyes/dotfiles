{ lib, config, ... }:
let
  cfg = config.services.mako;
in
{
  config.services.mako = lib.mkIf cfg.enable {
    settings = {
      font = "${config.theme.font.name} ${toString config.theme.font.size}";
      background-color = "#${config.theme.colors.c00.hex}";
      text-color = "#${config.theme.colors.c10.hex}";
      border-size = 1;
      border-color = "#${config.theme.colors.c04.hex}";
      progress-color = "#${config.theme.colors.c01.hex}";
      padding = 10;
      height = 500;

      "app-name=mpris" = {
        format = "<b>%s</b>\\n%b";
        group-by = "app-name";
      };

      "app-name=control" = {
        width = 350;
        format = "<b>%s</b>\\n%b";
        group-by = "app-name";
        anchor = "top-center";
        text-alignment = "center";
      };

      "mode=do-not-disturb" = {
        invisible = 1;
      };
    };
  };
}
