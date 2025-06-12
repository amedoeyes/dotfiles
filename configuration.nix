{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      use-xdg-base-directories = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 10 * 1024;
    }
  ];

  environment = {
    shellAliases = pkgs.lib.mkForce { };
    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
      "/share/zsh"
    ];
  };

  networking = {
    hostName = "iris";
    useNetworkd = true;
    nameservers = [ "9.9.9.9" ];
    firewall.enable = false;
    wireless = {
      enable = true;
      userControlled.enable = true;
      secretsFile = "/etc/nixos/wifi-passwords";
      networks = {
        "<O>" = {
          pskRaw = "ext:eye_psk";
        };
        "Iris" = {
          hidden = true;
          pskRaw = "ext:iris_psk";
        };
      };
    };
  };

  systemd = {
    network = {
      enable = true;
      networks = {
        "20-wired" = {
          matchConfig.Name = "enp0s25";
          linkConfig.RequiredForOnline = "routable";
          networkConfig.DHCP = "yes";
          dhcpV4Config.RouteMetric = 100;
          ipv6AcceptRAConfig.RouteMetric = 100;
        };
        "25-wireless" = {
          matchConfig.Name = "wlp3s0";
          linkConfig.RequiredForOnline = "routable";
          networkConfig = {
            DHCP = "yes";
            IgnoreCarrierLoss = "3s";
          };
          dhcpV4Config.RouteMetric = 600;
          ipv6AcceptRAConfig.RouteMetric = 600;
        };
      };
    };
  };

  time.timeZone = "Africa/Cairo";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    libinput = {
      enable = true;
    };

    getty = {
      greetingLine = "\\e[0;37m<<< Welcome to ${config.system.nixos.distroName} ${config.system.nixos.label} (\\m) - \\l >>>\\e[0m";
    };

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 100;
        START_CHARGE_THRESH_BAT1 = 75;
        STOP_CHARGE_THRESH_BAT1 = 100;
      };
    };
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock = { };
  };

  fonts = {
    fontconfig = {
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
      hinting.style = "full";
      subpixel.rgba = "rgb";
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.dejavu-sans-mono
    ];
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = false;
      enableLsColors = false;
      promptInit = "";
    };

    git = {
      enable = true;
    };

    lazygit = {
      enable = true;
    };

    nix-ld.enable = true;

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
  };

  system.stateVersion = "25.05";
}
