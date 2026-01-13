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
        theme[main_bg]="#${config.theme.colors.c00.hex}"
        theme[main_fg]="#${config.theme.colors.c10.hex}"

        theme[title]="#${config.theme.colors.c10.hex}"

        theme[hi_fg]="#${config.theme.colors.c06.hex}"

        theme[selected_bg]="#${config.theme.colors.c01.hex}"
        theme[selected_fg]="#${config.theme.colors.c10.hex}"

        theme[inactive_fg]="#${config.theme.colors.c04.hex}"

        theme[graph_text]="#${config.theme.colors.c06.hex}"

        theme[meter_bg]="#${config.theme.colors.c00.hex}"

        theme[proc_misc]="#${config.theme.colors.c10.hex}"

        theme[cpu_box]="#${config.theme.colors.c04.hex}"
        theme[mem_box]="#${config.theme.colors.c04.hex}"
        theme[net_box]="#${config.theme.colors.c04.hex}"
        theme[proc_box]="#${config.theme.colors.c04.hex}"

        theme[div_line]="#${config.theme.colors.c04.hex}"

        theme[temp_start]="#${config.theme.colors.c10.hex}"
        theme[temp_mid]="#${config.theme.colors.c10.hex}"
        theme[temp_end]="#${config.theme.colors.c10.hex}"

        theme[cpu_start]="#${config.theme.colors.c10.hex}"
        theme[cpu_mid]="#${config.theme.colors.c10.hex}"
        theme[cpu_end]="#${config.theme.colors.c10.hex}"

        theme[free_start]="#${config.theme.colors.c10.hex}"
        theme[free_mid]="#${config.theme.colors.c10.hex}"
        theme[free_end]="#${config.theme.colors.c10.hex}"

        theme[cached_start]="#${config.theme.colors.c10.hex}"
        theme[cached_mid]="#${config.theme.colors.c10.hex}"
        theme[cached_end]="#${config.theme.colors.c10.hex}"

        theme[available_start]="#${config.theme.colors.c10.hex}"
        theme[available_mid]="#${config.theme.colors.c10.hex}"
        theme[available_end]="#${config.theme.colors.c10.hex}"

        theme[used_start]="#${config.theme.colors.c10.hex}"
        theme[used_mid]="#${config.theme.colors.c10.hex}"
        theme[used_end]="#${config.theme.colors.c10.hex}"

        theme[download_start]="#${config.theme.colors.c10.hex}"
        theme[download_mid]="#${config.theme.colors.c10.hex}"
        theme[download_end]="#${config.theme.colors.c10.hex}"

        theme[upload_start]="#${config.theme.colors.c10.hex}"
        theme[upload_mid]="#${config.theme.colors.c10.hex}"
        theme[upload_end]="#${config.theme.colors.c10.hex}"

        theme[process_start]="#${config.theme.colors.c10.hex}"
        theme[process_mid]="#${config.theme.colors.c10.hex}"
        theme[process_end]="#${config.theme.colors.c10.hex}"
      '';
    };
  };
}
