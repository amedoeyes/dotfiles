{ lib, config, ... }:
let
  cfg = config.programs.beets;
in
{
  config.programs.beets = lib.mkIf cfg.enable {
    settings = {
      directory = "~/music";

      import = {
        move = true;
      };

      ui = {
        color = false;
      };

      plugins = [
        "badfiles"
        "edit"
        "embedart"
        "fetchart"
        "fromfilename"
        "info"
        "scrub"
        "zero"
      ];

      edit = {
        itemfields = [
          "title"
          "artist"
        ];
      };

      zero = {
        keep_fields = [
          "title"
          "albumartist"
          "artist"
          "album"
          "year"
          "track"
          "images"
        ];
      };

      fetchart = {
        maxwidth = 1500;
        quality = 75;
        max_filesize = 300000;
        enforce_ratio = true;
        cover_format = "jpeg";
        sources = [
          "filesystem"
          "coverart"
          "itunes"
          "albumart"
          "*"
        ];
      };

      embedart = {
        remove_art_file = true;
      };
    };
  };
}
