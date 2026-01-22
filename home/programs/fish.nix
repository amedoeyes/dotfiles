{ lib, config, ... }:
let
  cfg = config.programs.fish;
in
{
  config.programs.fish = lib.mkIf cfg.enable {
    shellInitLast = with config.theme.colors; ''
      set fish_greeting

      function fish_prompt
          set_color ${c06.hex}
          printf '$ '
          printf "\e[5 q"
          set_color normal
      end

      set fish_color_normal "#${c10.hex}"
      set fish_color_command "#${c09.hex}"
      set fish_color_keyword "#${c06.hex}"
      set fish_color_quote "#${c08.hex}"
      set fish_color_redirection "#${c07.hex}"
      set fish_color_end "#${c07.hex}"
      set fish_color_error "#${c10.hex}"
      set fish_color_param "#${c10.hex}"
      set fish_color_valid_path "#${c08.hex}"
      set fish_color_option "#${c10.hex}"
      set fish_color_comment "#${c04.hex}"
      set fish_color_selection --background "#${c02.hex}"
      set fish_color_operator "#${c07.hex}"
      set fish_color_escape "#${c08.hex}"
      set fish_color_autosuggestion "#${c04.hex}"
      set fish_color_cwd "#${c10.hex}"
      set fish_color_cwd_root "#${c10.hex}"
      set fish_color_user "#${c10.hex}"
      set fish_color_host "#${c10.hex}"
      set fish_color_host_remote "#${c10.hex}"
      set fish_color_status "#${c10.hex}"
      set fish_color_cancel "#${c10.hex}"
      set fish_color_search_match --background "#${c02.hex}"
      set fish_color_history_current --background "#${c01.hex}"

      set fish_pager_color_progress "#${c10.hex}" --bold
      set fish_pager_color_background
      set fish_pager_color_prefix "#${c10.hex}"
      set fish_pager_color_completion "#${c10.hex}"
      set fish_pager_color_description "#${c10.hex}"
      set fish_pager_color_selected_background --background "#${c01.hex}"
      set fish_pager_color_selected_prefix "#${c10.hex}"
      set fish_pager_color_selected_completion "#${c10.hex}"
      set fish_pager_color_selected_description "#${c10.hex}"
      set fish_pager_color_secondary_background "#${c10.hex}"
      set fish_pager_color_secondary_prefix "#${c10.hex}"
      set fish_pager_color_secondary_completion "#${c10.hex}"
      set fish_pager_color_secondary_description "#${c10.hex}"
    '';
  };
}
