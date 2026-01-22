{ lib, config, ... }:
let
  cfg = config.programs.lazygit;
in
{
  config.programs.lazygit = lib.mkIf cfg.enable {
    settings = {
      notARepository = "quit";
      gui = with config.theme.colors; {
        border = "single";
        nerdFontsVersion = "3";
        showBottomLine = false;
        showCommandLog = false;
        showFileIcons = false;
        showPanelJumps = false;
        showRandomTip = false;
        tabWidth = 2;
        authorColors."*" = "#${c06.hex}";
        branchColorPatterns."*" = "#${c06.hex}";
        theme = {
          activeBorderColor = [ "#${c10.hex}" ];
          cherryPickedCommitBgColor = [ "#${c10.hex}" ];
          cherryPickedCommitFgColor = [ "#${c10.hex}" ];
          defaultFgColor = [ "#${c10.hex}" ];
          inactiveBorderColor = [ "#${c04.hex}" ];
          inactiveViewSelectedLineBgColor = [ "#${c01.hex}" ];
          markedBaseCommitBgColor = [ "#${c10.hex}" ];
          markedBaseCommitFgColor = [ "#${c10.hex}" ];
          optionsTextColor = [ "#${c10.hex}" ];
          searchingActiveBorderColor = [ "#${c10.hex}" ];
          selectedLineBgColor = [ "#${c01.hex}" ];
          unstagedChangesColor = [ "#${c04.hex}" ];
        };
      };
    };
  };
}
