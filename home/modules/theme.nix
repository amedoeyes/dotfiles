{ config, lib, ... }:
let
  cfg = config.theme;
in
{
  options.theme = {
    palette = lib.mkOption {
      type = lib.types.str;
      default = "dark";
    };

    colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
    };

    darkColors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        hex00 = "#000000";
        hex01 = "#101010";
        hex02 = "#202020";
        hex03 = "#303030";
        hex04 = "#404040";
        hex05 = "#505050";
        hex06 = "#606060";
        hex07 = "#707070";
        hex08 = "#808080";
        hex09 = "#909090";
        hex10 = "#A0A0A0";

        ansi00 = "232";
        ansi01 = "233";
        ansi02 = "234";
        ansi03 = "235";
        ansi04 = "236";
        ansi05 = "238";
        ansi06 = "240";
        ansi07 = "242";
        ansi08 = "244";
        ansi09 = "246";
        ansi10 = "248";
      };
    };

    lightColors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        hex00 = "#FFFFFF";
        hex01 = "#EFEFEF";
        hex02 = "#DFDFDF";
        hex03 = "#CFCFCF";
        hex04 = "#BFBFBF";
        hex05 = "#AFAFAF";
        hex06 = "#9F9F9F";
        hex07 = "#8F8F8F";
        hex08 = "#7F7F7F";
        hex09 = "#6F6F6F";
        hex10 = "#5F5F5F";

        ansi00 = "255";
        ansi01 = "254";
        ansi02 = "253";
        ansi03 = "252";
        ansi04 = "251";
        ansi05 = "249";
        ansi06 = "247";
        ansi07 = "245";
        ansi08 = "243";
        ansi09 = "241";
        ansi10 = "239";
      };
    };

    font = lib.mkOption {
      type = lib.types.attrsOf (lib.types.either lib.types.str lib.types.int);
      default = {
        name = "monospace";
        size = 10;
      };
    };
  };

  config = {
    theme = {
      colors =
        if cfg.palette == "dark" then
          cfg.darkColors
        else if cfg.palette == "light" then
          cfg.lightColors
        else
          throw "Unsupported palette: ${cfg.palette}";
    };

    programs.foot.settings.colors = {
      "232" = "000000";
      "233" = "101010";
      "234" = "202020";
      "235" = "303030";
      "236" = "404040";
      "237" = "4F4F4F";
      "238" = "505050";
      "239" = "5F5F5F";
      "240" = "606060";
      "241" = "6F6F6F";
      "242" = "707070";
      "243" = "7F7F7F";
      "244" = "808080";
      "245" = "8F8F8F";
      "246" = "909090";
      "247" = "9F9F9F";
      "248" = "A0A0A0";
      "249" = "AFAFAF";
      "250" = "B0B0B0";
      "251" = "BFBFBF";
      "252" = "CFCFCF";
      "253" = "DFDFDF";
      "254" = "EFEFEF";
      "255" = "FFFFFF";
    };
  };
}
