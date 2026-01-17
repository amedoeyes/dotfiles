{ lib, config, ... }:
let
  cfg = config.programs.zathura;
in
{
  config.programs.zathura = lib.mkIf cfg.enable {
    options = with config.theme; {
      selection-clipboard = "clipboard";
      selection-notification = false;
      window-title-basename = true;
      scroll-step = 50;
      font = "${font.name} ${toString font.size}";
      recolor = true;
      recolor-lightcolor = "#${colors.c00.hex}";
      recolor-darkcolor = "#${colors.c10.hex}";
      default-fg = "#${colors.c10.hex}";
      default-bg = "#${colors.c00.hex}";
      notification-fg = "#${colors.c10.hex}";
      notification-bg = "#${colors.c00.hex}";
      notification-error-fg = "#${colors.c10.hex}";
      notification-error-bg = "#${colors.c00.hex}";
      notification-warning-fg = "#${colors.c10.hex}";
      notification-warning-bg = "#${colors.c00.hex}";
      completion-fg = "#${colors.c10.hex}";
      completion-bg = "#${colors.c00.hex}";
      completion-group-fg = "#${colors.c10.hex}";
      completion-group-bg = "#${colors.c00.hex}";
      completion-highlight-fg = "#${colors.c10.hex}";
      completion-highlight-bg = "#${colors.c01.hex}";
      index-fg = "#${colors.c10.hex}";
      index-bg = "#${colors.c00.hex}";
      index-active-fg = "#${colors.c10.hex}";
      index-active-bg = "#${colors.c01.hex}";
      inputbar-fg = "#${colors.c10.hex}";
      inputbar-bg = "#${colors.c00.hex}";
      statusbar-fg = "#${colors.c10.hex}";
      statusbar-bg = "#${colors.c00.hex}";
      highlight-color = with colors.c10; "rgba(${r}, ${g}, ${b}, 0.1)";
      highlight-active-color = with colors.c10; "rgba(${r}, ${g}, ${b}, 0.3)";
      render-loading = true;
      render-loading-fg = "#${colors.c10.hex}";
      render-loading-bg = "#${colors.c00.hex}";
    };
  };
}
