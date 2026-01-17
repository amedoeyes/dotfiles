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
      "--pointer ''"
      "--prompt ' '"
      "--scrollbar '█'"
      "--reverse"
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
          "Trash"
          "__pycache__"
          "build"
          "games"
          "music"
          "node_modules"
          "old"
          "target"
          "venv"
        ]
      }"
    ];
    colors = with config.theme.colors; {
      "fg" = "#${c10.hex}";
      "fg+" = "#${c10.hex}:regular";
      "bg" = "#${c00.hex}";
      "bg+" = "#${c01.hex}";
      "hl" = "#${c10.hex}";
      "hl+" = "#${c10.hex}";
      "gutter" = "#${c00.hex}";
      "query" = "#${c10.hex}:regular";
      "disabled" = "#${c04.hex}";
      "info" = "#${c04.hex}";
      "border" = "#${c04.hex}";
      "label" = "#${c10.hex}";
      "prompt" = "#${c06.hex}";
      "pointer" = "#${c10.hex}";
      "marker" = "#${c10.hex}";
      "spinner" = "#${c04.hex}";
      "header" = "#${c10.hex}";
    };
  };
}
