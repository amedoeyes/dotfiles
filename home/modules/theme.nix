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
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            hex = lib.mkOption {
              type = lib.types.str;
            };
            ansi = lib.mkOption {
              type = lib.types.str;
            };
            rgb = lib.mkOption {
              type = lib.types.submodule {
                options = {
                  r = lib.mkOption { type = lib.types.str; };
                  g = lib.mkOption { type = lib.types.str; };
                  b = lib.mkOption { type = lib.types.str; };
                };
              };
            };
          };
        }
      );
    };

    ansiColors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
    };

    darkColors = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            hex = lib.mkOption {
              type = lib.types.str;
            };
            ansi = lib.mkOption {
              type = lib.types.str;
            };
            rgb = lib.mkOption {
              type = lib.types.submodule {
                options = {
                  r = lib.mkOption { type = lib.types.str; };
                  g = lib.mkOption { type = lib.types.str; };
                  b = lib.mkOption { type = lib.types.str; };
                };
              };
            };
          };
        }
      );
      default = {
        c00 = {
          hex = "000000";
          ansi = "232";
          rgb = {
            r = "0";
            g = "0";
            b = "0";
          };
        };

        c01 = {
          hex = "101010";
          ansi = "233";
          rgb = {
            r = "16";
            g = "16";
            b = "16";
          };
        };

        c02 = {
          hex = "202020";
          ansi = "234";
          rgb = {
            r = "32";
            g = "32";
            b = "32";
          };
        };

        c03 = {
          hex = "303030";
          ansi = "235";
          rgb = {
            r = "48";
            g = "48";
            b = "48";
          };
        };

        c04 = {
          hex = "404040";
          ansi = "236";
          rgb = {
            r = "64";
            g = "64";
            b = "64";
          };
        };

        c05 = {
          hex = "505050";
          ansi = "238";
          rgb = {
            r = "80";
            g = "80";
            b = "80";
          };
        };

        c06 = {
          hex = "606060";
          ansi = "240";
          rgb = {
            r = "96";
            g = "96";
            b = "96";
          };
        };

        c07 = {
          hex = "707070";
          ansi = "242";
          rgb = {
            r = "112";
            g = "112";
            b = "112";
          };
        };

        c08 = {
          hex = "808080";
          ansi = "244";
          rgb = {
            r = "128";
            g = "128";
            b = "128";
          };
        };

        c09 = {
          hex = "909090";
          ansi = "246";
          rgb = {
            r = "144";
            g = "144";
            b = "144";
          };
        };

        c10 = {
          hex = "A0A0A0";
          ansi = "248";
          rgb = {
            r = "160";
            g = "160";
            b = "160";
          };
        };
      };
    };

    lightColors = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            hex = lib.mkOption {
              type = lib.types.str;
            };
            ansi = lib.mkOption {
              type = lib.types.str;
            };
            rgb = lib.mkOption {
              type = lib.types.submodule {
                options = {
                  r = lib.mkOption { type = lib.types.str; };
                  g = lib.mkOption { type = lib.types.str; };
                  b = lib.mkOption { type = lib.types.str; };
                };
              };
            };
          };
        }
      );
      default = {
        c00 = {
          hex = "FFFFFF";
          ansi = "255";
          rgb = {
            r = "255";
            g = "255";
            b = "255";
          };
        };

        c01 = {
          hex = "EFEFEF";
          ansi = "254";
          rgb = {
            r = "239";
            g = "239";
            b = "239";
          };
        };

        c02 = {
          hex = "DFDFDF";
          ansi = "253";
          rgb = {
            r = "223";
            g = "223";
            b = "223";
          };
        };

        c03 = {
          hex = "CFCFCF";
          ansi = "252";
          rgb = {
            r = "207";
            g = "207";
            b = "207";
          };
        };

        c04 = {
          hex = "BFBFBF";
          ansi = "251";
          rgb = {
            r = "191";
            g = "191";
            b = "191";
          };
        };

        c05 = {
          hex = "AFAFAF";
          ansi = "249";
          rgb = {
            r = "175";
            g = "175";
            b = "175";
          };
        };

        c06 = {
          hex = "9F9F9F";
          ansi = "247";
          rgb = {
            r = "159";
            g = "159";
            b = "159";
          };
        };

        c07 = {
          hex = "8F8F8F";
          ansi = "245";
          rgb = {
            r = "143";
            g = "143";
            b = "143";
          };
        };

        c08 = {
          hex = "7F7F7F";
          ansi = "243";
          rgb = {
            r = "127";
            g = "127";
            b = "127";
          };
        };

        c09 = {
          hex = "6F6F6F";
          ansi = "241";
          rgb = {
            r = "111";
            g = "111";
            b = "111";
          };
        };

        c10 = {
          hex = "5F5F5F";
          ansi = "239";
          rgb = {
            r = "95";
            g = "95";
            b = "95";
          };
        };
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

      ansiColors = {
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
  };
}
