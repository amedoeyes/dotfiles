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
    themes = with config.theme.colors; {
      eyes = ''
        theme[main_bg]="#${c00.hex}"
        theme[main_fg]="#${c10.hex}"
        theme[title]="#${c10.hex}"
        theme[hi_fg]="#${c06.hex}"
        theme[selected_bg]="#${c01.hex}"
        theme[selected_fg]="#${c10.hex}"
        theme[inactive_fg]="#${c04.hex}"
        theme[graph_text]="#${c06.hex}"
        theme[meter_bg]="#${c04.hex}"
        theme[proc_misc]="#${c10.hex}"
        theme[cpu_box]="#${c04.hex}"
        theme[mem_box]="#${c04.hex}"
        theme[net_box]="#${c04.hex}"
        theme[proc_box]="#${c04.hex}"
        theme[div_line]="#${c04.hex}"
        theme[temp_start]="#${c10.hex}"
        theme[temp_mid]="#${c10.hex}"
        theme[temp_end]="#${c10.hex}"
        theme[cpu_start]="#${c10.hex}"
        theme[cpu_mid]="#${c10.hex}"
        theme[cpu_end]="#${c10.hex}"
        theme[free_start]="#${c10.hex}"
        theme[free_mid]="#${c10.hex}"
        theme[free_end]="#${c10.hex}"
        theme[cached_start]="#${c10.hex}"
        theme[cached_mid]="#${c10.hex}"
        theme[cached_end]="#${c10.hex}"
        theme[available_start]="#${c10.hex}"
        theme[available_mid]="#${c10.hex}"
        theme[available_end]="#${c10.hex}"
        theme[used_start]="#${c10.hex}"
        theme[used_mid]="#${c10.hex}"
        theme[used_end]="#${c10.hex}"
        theme[download_start]="#${c10.hex}"
        theme[download_mid]="#${c10.hex}"
        theme[download_end]="#${c10.hex}"
        theme[upload_start]="#${c10.hex}"
        theme[upload_mid]="#${c10.hex}"
        theme[upload_end]="#${c10.hex}"
        theme[process_start]="#${c10.hex}"
        theme[process_mid]="#${c10.hex}"
        theme[process_end]="#${c10.hex}"
      '';
    };
  };
}
