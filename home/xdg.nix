{ pkgs, config, ... }:
{
  xdg = {
    enable = true;
    portal.enable = true;
    mimeApps.enable = true;
    userDirs = {
      enable = true;
      desktop = null;
      documents = "$HOME/documents";
      download = "$HOME/downloads";
      music = "$HOME/media/music";
      pictures = "$HOME/media";
      publicShare = null;
      templates = null;
      videos = "$HOME/media";
    };
  };

  home = {
    preferXdgDirectories = true;
    packages = [
      (pkgs.writeShellScriptBin "x-terminal-emulator" "exec $TERMINAL $@")
      (pkgs.writeShellScriptBin "xdg-terminal-exec" "exec $TERMINAL $@")
    ];
    sessionVariables = {
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      GOPATH = "${config.xdg.dataHome}/go";
      LESSHISTFILE = "${config.xdg.stateHome}/less/history";
    };
  };
}
