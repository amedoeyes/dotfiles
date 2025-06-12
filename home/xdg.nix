{ pkgs, config, ... }:
{
  xdg = {
    enable = true;
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
    packages = [ (pkgs.writeShellScriptBin "x-terminal-emulator" "exec $TERMINAL $@") ];

    sessionVariables = {
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      GOPATH = "${config.xdg.dataHome}/go";
      LESSHISTFILE = "${config.xdg.stateHome}/less/history";
      XMAKE_GLOBALDIR = "${config.xdg.configHome}/xmake";
      XMAKE_PKG_CACHEDIR = "${config.xdg.cacheHome}/xmake";
      XMAKE_PKG_INSTALLDIR = "${config.xdg.dataHome}/xmake";
    };
  };
}
