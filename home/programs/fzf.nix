{ lib, ... }:
{
  programs.fzf = {
    enable = true;
    defaultCommand = "rg --files --hidden --follow";
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
      "--preview 'highlight {}'"
    ];
    changeDirWidgetOptions = [
      "--walker dir,follow,hidden"
      "--walker-skip ${
        lib.strings.concatStringsSep "," [
          ".cache"
          ".dotfiles"
          ".git"
          ".local/share/Smart\\ Code\\ ltd"
          ".local/share/cargo"
          ".local/share/containers"
          ".local/share/ghcup"
          ".local/share/go"
          ".local/share/nvim/site/pack"
          ".local/share/pipx"
          ".local/share/qutebrowser"
          ".local/share/rustup"
          ".local/share/xmake"
          ".local/state/cabal"
          ".local/state/nix"
          ".ruff_cache"
          ".xmake"
          "Trash"
          "__pycache__"
          "build"
          "games"
          "mason/packages"
          "media/screenrecords"
          "media/screenshots"
          "music"
          "node_modules"
          "old"
          "target"
          "venv"
        ]
      }"
      "--preview 'tree --noreport {}'"
    ];
    colors = {
      "fg" = "#A0A0A0";
      "fg+" = "#A0A0A0:regular";
      "bg" = "#000000";
      "bg+" = "#101010";
      "hl" = "#A0A0A0";
      "hl+" = "#A0A0A0";
      "gutter" = "#000000";
      "query" = "#A0A0A0:regular";
      "disabled" = "#404040";
      "info" = "#404040";
      "border" = "#404040";
      "label" = "#A0A0A0";
      "prompt" = "#606060";
      "pointer" = "#A0A0A0";
      "marker" = "#A0A0A0";
      "spinner" = "#404040";
      "header" = "#A0A0A0";
    };
  };
}
