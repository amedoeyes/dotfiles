{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [
        "Noto Sans"
        "Noto Sans Arabic"
      ];
      serif = [
        "Noto Sans"
        "Noto Sans Arabic"
      ];
      monospace = [
        "JetBrains Mono Nerd Font"
        "DejaVuSansM Nerd Font"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
    hinting = "full";
    subpixelRendering = "rgb";
  };

  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.dejavu-sans-mono
    liberation_ttf
  ];
}
