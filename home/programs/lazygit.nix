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
        authorColors."*" = config.theme.colors.hex06;

        theme = {
          activeBorderColor = [ config.theme.colors.hex10 ];
          cherryPickedCommitBgColor = [ config.theme.colors.hex10 ];
          cherryPickedCommitFgColor = [ config.theme.colors.hex10 ];
          defaultFgColor = [ config.theme.colors.hex10 ];
          inactiveBorderColor = [ config.theme.colors.hex04 ];
          inactiveViewSelectedLineBgColor = [ config.theme.colors.hex01 ];
          markedBaseCommitBgColor = [ config.theme.colors.hex10 ];
          markedBaseCommitFgColor = [ config.theme.colors.hex10 ];
          optionsTextColor = [ config.theme.colors.hex10 ];
          searchingActiveBorderColor = [ config.theme.colors.hex10 ];
          selectedLineBgColor = [ config.theme.colors.hex01 ];
          unstagedChangesColor = [ config.theme.colors.hex04 ];
        };
      };
    };
  };
}
