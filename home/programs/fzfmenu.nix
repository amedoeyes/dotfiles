{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.fzfmenu;
in
{
  options.programs.fzfmenu = {
    enable = lib.mkEnableOption "fzfmenu program";

    terminal = lib.mkOption {
      type = lib.types.package;
      description = "Terminal emulator package to use";
    };

    terminalBinary = lib.mkOption {
      type = lib.types.str;
      description = "Terminal emulator binary to use";
    };

    fzfOptions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Default arguments to pass to fzf";
    };
  };

  config =
    let
      terminalOptions =
        if cfg.terminalBinary == "foot" || cfg.terminalBinary == "foot" then
          [
            "--app-id"
            "fzfmenu"
          ]
        else
          [ ];

      fzfOptions =
        let
          fzf = config.programs.fzf;
        in
        if fzf.enable then
          fzf.defaultOptions
          ++ lib.optionals (fzf.colors != { }) [
            "--color ${
              lib.concatStringsSep "," (lib.mapAttrsToList (name: value: "${name}:${value}") fzf.colors)
            }"
          ]
          ++ cfg.fzfOptions
        else
          cfg.fzfOptions;

      package = pkgs.callPackage ../../pkgs/fzfmenu.nix {
        fzfOptions = fzfOptions;
        terminal = cfg.terminal;
        terminalBinary = cfg.terminalBinary;
        terminalOptions = terminalOptions;
      };
    in
    lib.mkIf cfg.enable {
      home.packages = [ package ];

      wayland.windowManager.sway.config.window.commands =
        lib.mkIf config.wayland.windowManager.sway.enable
          [
            {
              command = "floating enable";
              criteria = {
                app_id = "fzfmenu";
              };
            }
            {
              command = "focus";
              criteria = {
                app_id = "fzfmenu";
              };
            }
          ];
    };
}
