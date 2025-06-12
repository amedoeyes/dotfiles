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
      "--height '-1'"
      "--reverse"
      "--list-border sharp"
      "--preview-border sharp"
      "--info=inline-right:''"
      "--prompt ' '"
      "--highlight-line"
      "--bind ctrl-y:accept"
    ];

    fileWidgetOptions = [
      "--preview '${lib.getExe' pkgs.coreutils "cat"} {}'"
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
      "--preview '${lib.getExe pkgs.tree} --noreport {}'"
    ];

    colors = {
      "fg" = config.theme.colors.hex10;
      "fg+" = "${config.theme.colors.hex10}:regular";
      "bg" = config.theme.colors.hex00;
      "bg+" = config.theme.colors.hex01;
      "hl" = config.theme.colors.hex10;
      "hl+" = config.theme.colors.hex10;
      "gutter" = config.theme.colors.hex00;
      "query" = "${config.theme.colors.hex10}:regular";
      "disabled" = config.theme.colors.hex04;
      "info" = config.theme.colors.hex04;
      "border" = config.theme.colors.hex04;
      "label" = config.theme.colors.hex10;
      "prompt" = config.theme.colors.hex06;
      "pointer" = config.theme.colors.hex10;
      "marker" = config.theme.colors.hex10;
      "spinner" = config.theme.colors.hex04;
      "header" = config.theme.colors.hex10;
    };
  };
}
