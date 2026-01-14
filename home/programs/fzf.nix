{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.fzf;
in
{
  config.programs.fzf = lib.mkIf cfg.enable {
    defaultCommand = "${lib.getExe pkgs.ripgrep} --files --hidden --follow";

    defaultOptions = [
      "--no-info"
      "--no-separator"
      "--no-scrollbar"
      "--pointer ''"
      "--reverse"
      "--prompt ' '"
      "--highlight-line"
      "--preview-border left"
      "--bind ctrl-y:accept"
    ];

    changeDirWidgetOptions = [
      "--walker dir,follow,hidden"
      "--walker-skip ${
        lib.strings.concatStringsSep "," [
          ".cache"
          ".direnv"
          ".git"
          ".local/share/Smart\\ Code\\ ltd"
          ".local/share/cargo"
          ".local/share/containers"
          ".local/share/docker"
          ".local/share/ghcup"
          ".local/share/go"
          ".local/share/qutebrowser"
          ".local/share/rustup"
          ".local/share/xmake"
          ".local/state/cabal"
          ".local/state/home-manager"
          ".local/state/nix"
          ".ruff_cache"
          ".xmake"
          "Trash"
          "__pycache__"
          "build"
          "games"
          "media/screenrecords"
          "media/screenshots"
          "music"
          "node_modules"
          "old"
          "target"
          "venv"
        ]
      }"
    ];

    colors = {
      "fg" = "#${config.theme.colors.c10.hex}";
      "fg+" = "#${config.theme.colors.c10.hex}:regular";
      "bg" = "#${config.theme.colors.c00.hex}";
      "bg+" = "#${config.theme.colors.c01.hex}";
      "hl" = "#${config.theme.colors.c10.hex}";
      "hl+" = "#${config.theme.colors.c10.hex}";
      "gutter" = "#${config.theme.colors.c00.hex}";
      "query" = "#${config.theme.colors.c10.hex}:regular";
      "disabled" = "#${config.theme.colors.c04.hex}";
      "info" = "#${config.theme.colors.c04.hex}";
      "border" = "#${config.theme.colors.c04.hex}";
      "label" = "#${config.theme.colors.c10.hex}";
      "prompt" = "#${config.theme.colors.c06.hex}";
      "pointer" = "#${config.theme.colors.c10.hex}";
      "marker" = "#${config.theme.colors.c10.hex}";
      "spinner" = "#${config.theme.colors.c04.hex}";
      "header" = "#${config.theme.colors.c10.hex}";
    };
  };
}
