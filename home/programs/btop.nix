{ lib, config, ... }:
let
  cfg = config.programs.btop;
in
{
  config.programs.btop = lib.mkIf cfg.enable {
    settings = {
      clock_format = "";
      color_theme = "eyes";
      proc_gradient = false;
      rounded_corners = false;
      show_battery = false;
      update_ms = 1000;
      vim_keys = true;
    };

    themes = {
      eyes = ''
        theme[main_bg]="${config.theme.colors.hex00}"
        theme[main_fg]="${config.theme.colors.hex10}"

        theme[title]="${config.theme.colors.hex10}"

        theme[hi_fg]="${config.theme.colors.hex06}"

        theme[selected_bg]="${config.theme.colors.hex01}"
        theme[selected_fg]="${config.theme.colors.hex10}"

        theme[inactive_fg]="${config.theme.colors.hex04}"

        theme[graph_text]="${config.theme.colors.hex06}"

        theme[meter_bg]="${config.theme.colors.hex00}"

        theme[proc_misc]="${config.theme.colors.hex10}"

        theme[cpu_box]="${config.theme.colors.hex04}"
        theme[mem_box]="${config.theme.colors.hex04}"
        theme[net_box]="${config.theme.colors.hex04}"
        theme[proc_box]="${config.theme.colors.hex04}"

        theme[div_line]="${config.theme.colors.hex04}"

        theme[temp_start]="${config.theme.colors.hex10}"
        theme[temp_mid]="${config.theme.colors.hex10}"
        theme[temp_end]="${config.theme.colors.hex10}"

        theme[cpu_start]="${config.theme.colors.hex10}"
        theme[cpu_mid]="${config.theme.colors.hex10}"
        theme[cpu_end]="${config.theme.colors.hex10}"

        theme[free_start]="${config.theme.colors.hex10}"
        theme[free_mid]="${config.theme.colors.hex10}"
        theme[free_end]="${config.theme.colors.hex10}"

        theme[cached_start]="${config.theme.colors.hex10}"
        theme[cached_mid]="${config.theme.colors.hex10}"
        theme[cached_end]="${config.theme.colors.hex10}"

        theme[available_start]="${config.theme.colors.hex10}"
        theme[available_mid]="${config.theme.colors.hex10}"
        theme[available_end]="${config.theme.colors.hex10}"

        theme[used_start]="${config.theme.colors.hex10}"
        theme[used_mid]="${config.theme.colors.hex10}"
        theme[used_end]="${config.theme.colors.hex10}"

        theme[download_start]="${config.theme.colors.hex10}"
        theme[download_mid]="${config.theme.colors.hex10}"
        theme[download_end]="${config.theme.colors.hex10}"

        theme[upload_start]="${config.theme.colors.hex10}"
        theme[upload_mid]="${config.theme.colors.hex10}"
        theme[upload_end]="${config.theme.colors.hex10}"

        theme[process_start]="${config.theme.colors.hex10}"
        theme[process_mid]="${config.theme.colors.hex10}"
        theme[process_end]="${config.theme.colors.hex10}"
      '';
    };
  };
}
