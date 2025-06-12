{ pkgs, config, ... }:
{
  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      config = {
        common = {
          default = "gtk";
          "org.freedesktop.impl.portal.Screenshot" = "wlr";
          "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        };
      };
    };
    userDirs = {
      enable = true;
      desktop = null;
      documents = "$HOME/documents";
      download = "$HOME/downloads";
      music = "$HOME/music";
      pictures = "$HOME/media";
      publicShare = null;
      templates = null;
      videos = "$HOME/media";
    };
  };

  home = {
    sessionVariables = {
      BROWSER = "qutebrowser";
      READER = "zathura";

      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      GOPATH = "${config.xdg.dataHome}/go";
      HIGHLIGHT_DATADIR = "${config.xdg.configHome}/highlight/";
      LESSHISTFILE = "${config.xdg.stateHome}/less/history";
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/pass";
      RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
      W3M_DIR = "${config.xdg.configHome}/w3m";
      XMAKE_GLOBALDIR = "${config.xdg.configHome}/xmake";
      XMAKE_PKG_CACHEDIR = "${config.xdg.cacheHome}/xmake";
      XMAKE_PKG_INSTALLDIR = "${config.xdg.dataHome}/xmake";
      GHCUP_USE_XDG_DIRS = "true";

      HIGHLIGHT_OPTIONS = "--style=eyes --out-format=xterm256 --line-numbers";
    };

    stateVersion = "25.05";
  };

  imports = [
    ./programs
    ./window_managers
    ./services
  ];
}
