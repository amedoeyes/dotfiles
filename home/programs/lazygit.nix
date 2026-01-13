{ lib, config, ... }:
let
  cfg = config.programs.lazygit;
in
{
  config.programs.lazygit = lib.mkIf cfg.enable {
    settings = {
      notARepository = "quit";

      os = {
        editPreset = "nvim-remote";
      };

      gui = {
        border = "single";
        nerdFontsVersion = "3";
        showBottomLine = false;
        showCommandLog = false;
        showFileIcons = false;
        showPanelJumps = false;
        showRandomTip = false;
        tabWidth = 2;
        authorColors."*" = "#${config.theme.colors.c06.hex}";

        theme = {
          activeBorderColor = [ "#${config.theme.colors.c10.hex}" ];
          cherryPickedCommitBgColor = [ "#${config.theme.colors.c10.hex}" ];
          cherryPickedCommitFgColor = [ "#${config.theme.colors.c10.hex}" ];
          defaultFgColor = [ "#${config.theme.colors.c10.hex}" ];
          inactiveBorderColor = [ "#${config.theme.colors.c04.hex}" ];
          inactiveViewSelectedLineBgColor = [ "#${config.theme.colors.c01.hex}" ];
          markedBaseCommitBgColor = [ "#${config.theme.colors.c10.hex}" ];
          markedBaseCommitFgColor = [ "#${config.theme.colors.c10.hex}" ];
          optionsTextColor = [ "#${config.theme.colors.c10.hex}" ];
          searchingActiveBorderColor = [ "#${config.theme.colors.c10.hex}" ];
          selectedLineBgColor = [ "#${config.theme.colors.c01.hex}" ];
          unstagedChangesColor = [ "#${config.theme.colors.c04.hex}" ];
        };
      };
    };
  };
}
