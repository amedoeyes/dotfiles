{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.cmus;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.cmusfm
      pkgs.cmus-cover
    ];

    xdg.configFile."cmus/eyes.theme".text = ''
      set color_win_fg=${config.theme.colors.ansi10}
      set color_win_bg=${config.theme.colors.ansi00}
      set color_win_attr=default

      set color_win_dir=${config.theme.colors.ansi08}

      set color_win_title_bg=${config.theme.colors.ansi00}
      set color_win_title_fg=${config.theme.colors.ansi10}
      set color_win_title_attr=bold

      set color_win_cur=${config.theme.colors.ansi10}
      set color_win_cur_attr=blink

      set color_cur_sel_attr=default

      set color_win_cur_sel_fg=${config.theme.colors.ansi10}
      set color_win_cur_sel_bg=${config.theme.colors.ansi01}
      set color_win_cur_sel_attr=blink

      set color_win_inactive_cur_sel_bg=${config.theme.colors.ansi00}
      set color_win_inactive_cur_sel_fg=${config.theme.colors.ansi10}
      set color_win_inactive_cur_sel_attr=blink

      set color_win_sel_fg=${config.theme.colors.ansi10}
      set color_win_sel_bg=${config.theme.colors.ansi01}
      set color_win_sel_attr=default

      set color_win_inactive_sel_bg=${config.theme.colors.ansi00}
      set color_win_inactive_sel_fg=${config.theme.colors.ansi10}
      set color_win_inactive_sel_attr=default

      set color_trackwin_album_fg=${config.theme.colors.ansi10}
      set color_trackwin_album_bg=${config.theme.colors.ansi00}
      set color_trackwin_album_attr=bold

      set color_separator=${config.theme.colors.ansi04}

      set color_statusline_fg=${config.theme.colors.ansi10}
      set color_statusline_bg=${config.theme.colors.ansi00}
      set color_statusline_attr=bold

      set color_statusline_progress_fg=${config.theme.colors.ansi10}
      set color_statusline_progress_bg=${config.theme.colors.ansi00}
      set color_statusline_progress_attr=default

      set color_titleline_fg=${config.theme.colors.ansi10}
      set color_titleline_bg=${config.theme.colors.ansi00}
      set color_titleline_attr=bold

      set color_cmdline_fg=${config.theme.colors.ansi10}
      set color_cmdline_bg=${config.theme.colors.ansi00}
      set color_cmdline_attr=default

      set color_error=${config.theme.colors.ansi10}
      set color_info=${config.theme.colors.ansi10}
    '';

    programs.cmus = {
      theme = "eyes";

      extraConfig = ''
        set auto_hide_playlists_panel=true
        set format_current= %a - %l%! - %02n %t%= %y 
        set format_trackwin= %02n %t%= %d 
        set format_playlist= %-21%a %02n %t%= %y %d %{?X!=0?%3X ?    }
        set format_playlist_va= %-21%A %02n %t (%a)%= %y %d %{?X!=0?%3X ?    }
        set format_trackwin_va= %02n %t (%a)%= %d 
        set status_display_program=cmusfm
      '';
    };
  };
}
