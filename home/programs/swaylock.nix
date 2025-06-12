{ ... }:
{
  programs.swaylock = {
    enable = true;
    settings = {
      daemonize = true;

      ignore-empty-password = true;
      hide-keyboard-layout = true;

      image = ../wallpapers/eyes.png;
      color = "000000";

      font = "monospace";

      bs-hl-color = "A0A0A0";
      key-hl-color = "A0A0A0";
      caps-lock-bs-hl-color = "A0A0A0";
      caps-lock-key-hl-color = "A0A0A0";

      indicator-radius = "150";
      indicator-thickness = "2";

      inside-color = "000000";
      inside-clear-color = "000000";
      inside-caps-lock-color = "000000";
      inside-ver-color = "000000";
      inside-wrong-color = "000000";

      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";

      ring-color = "404040";
      ring-clear-color = "404040";
      ring-caps-lock-color = "404040";
      ring-ver-color = "404040";
      ring-wrong-color = "404040";

      separator-color = "00000000";

      text-color = "A0A0A0";
      text-clear-color = "A0A0A0";
      text-caps-lock-color = "A0A0A0";
      text-ver-color = "A0A0A0";
      text-wrong-color = "A0A0A0";
    };
  };
}
