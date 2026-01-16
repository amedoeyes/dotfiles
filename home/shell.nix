{ config, ... }:
{
  home = {
    sessionVariables = {
      LS_COLORS =
        with config.theme.colors;
        "di=38;2;${with c09; "${r};${g};${b}"}:*=38;2;${with c10; "${r};${g};${b}"}";
    };
    shellAliases = { };
  };
}
