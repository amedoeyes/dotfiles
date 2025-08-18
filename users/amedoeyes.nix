{
  config =
    { pkgs, ... }:
    {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

  home =
    let
      gpgKey = "0xB6B6382BFC9F2BC4";
      gpgKeygrip = "4A76EBB0C2CEEE55FBB4F9DAD44D37F38784E5A1";
    in
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      xdg.configFile."pam-gnupg".text = ''
        ${config.xdg.dataHome}/gnupg
        ${gpgKeygrip}
      '';

      accounts = {
        email = {
          maildirBasePath = "mail";

          accounts = {
            personal = {
              primary = true;
              address = "amedoeyes@gmail.com";
              realName = "Ahmed AbouEleyoun";
              passwordCommand = "${lib.getExe pkgs.pass} passwords/email/personal";
              flavor = "gmail.com";

              gpg = {
                key = gpgKey;
                signByDefault = true;
              };

              mbsync = {
                enable = true;
                create = "both";
                remove = "both";
                expunge = "both";
              };

              aerc = {
                enable = true;
                extraAccounts = {
                  check-mail = "60s";
                  check-mail-cmd = "${lib.getExe pkgs.isync} personal";
                  check-mail-timeout = "60s";
                };
              };
            };

            professional = {
              address = "ahmed.m.aboueleyoun@gmail.com";
              realName = "Ahmed AbouEleyoun";
              passwordCommand = "${lib.getExe pkgs.pass} passwords/email/professional";
              flavor = "gmail.com";

              gpg = {
                key = gpgKey;
                signByDefault = true;
              };

              mbsync = {
                enable = true;
                create = "both";
                remove = "both";
                expunge = "both";
              };

              aerc = {
                enable = true;
                extraAccounts = {
                  check-mail = "60s";
                  check-mail-cmd = "${lib.getExe pkgs.isync} professional";
                  check-mail-timeout = "60s";
                };
              };
            };
          };
        };
      };

      home.packages = with pkgs; [
        blobdrop
        nix-index
        select-geometry
        screenrecord
        screenshot
        wl-clipboard
      ];

      programs = {
        aerc.enable = true;
        btop.enable = true;
        cava.enable = true;
        cmus.enable = true;
        direnv.enable = true;
        foot = {
          enable = true;
          default = true;
        };
        fzf.enable = true;
        git = {
          enable = true;
          userEmail = "amedoeyes@gmail.com";
          userName = "Ahmed AbouEleyoun";
          signing = {
            key = gpgKey;
            signByDefault = true;
          };
        };
        gpg.enable = true;
        imv.enable = true;
        lazygit = {
          enable = true;
          settings = {
            git = {
              overrideGpg = true;
            };
          };
        };
        less.enable = true;
        mbsync.enable = true;
        mpv = {
          enable = true;
          config = {
            hwdec = "vaapi";
            gpu-api = "opengl";
          };
        };
        newsboat = {
          enable = true;
          urls = [
            { url = "https://lwn.net/headlines/newrss"; }
            { url = "https://isocpp.org/blog/rss"; }
            { url = "https://www.cppstories.com/index.xml"; }
          ];
        };
        nixCats = {
          enable = true;
          default = true;
          unwrap = true;
        };
        password-store = {
          enable = true;
          settings = {
            PASSWORD_STORE_KEY = gpgKey;
          };
        };
        qutebrowser.enable = true;
        ripgrep.enable = true;
        swaylock.enable = true;
        vifm = {
          enable = true;
          default = true;
          picker = true;
        };
        waybar.enable = true;
        zathura.enable = true;
        zk.enable = true;
        zsh.enable = true;
      };

      services = {
        batsignal.enable = true;
        cliphist.enable = true;
        mako.enable = true;
        swayidle.enable = true;

        gpg-agent = {
          enable = true;
          extraConfig = ''
            allow-preset-passphrase
            default-cache-ttl 31536000
            max-cache-ttl 31536000
          '';
        };
      };

      wayland.windowManager.sway.enable = true;
    };
}
