{ lib, config, ... }:
let
  cfg = config.services.mako;
in
{
  config.services.mako = lib.mkIf cfg.enable {
    settings = {
      font = "${config.theme.font.name} ${toString config.theme.font.size}";
      background-color = config.theme.colors.hex00;
      text-color = config.theme.colors.hex10;
      border-size = 1;
      border-color = config.theme.colors.hex04;
      progress-color = config.theme.colors.hex01;
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
