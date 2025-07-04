{
  lib,
  inputs,
  config,
  ...
}:
let
  cfg = config.programs.nixCats;
in
{
  imports = [ inputs.nixCats.homeModule ];

  options.programs.nixCats = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = lib.mkIf cfg.default {
      EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
    };

    nixCats = {
      enable = true;
      packageNames = [ "nvim" ];
      luaPath = ./.;

      categoryDefinitions.replace = (
        { pkgs, ... }:
        {
          lspsAndRuntimeDeps = with pkgs; {
            general = [
              chafa
              xdg-utils
              wl-clipboard
            ];

            c = [ clang-tools ];

            css = [
              nodePackages.prettier
              nodePackages.vscode-langservers-extracted
            ];

            go = [
              gofumpt
              gopls
            ];

            haskell = [ haskellPackages.haskell-language-server ];

            html = [
              nodePackages.prettier
              nodePackages.vscode-langservers-extracted
            ];

            js = [
              nodePackages.eslint_d
              nodePackages.prettier
              typescript-language-server
            ];

            json = [
              nodePackages.prettier
              nodePackages.vscode-langservers-extracted
            ];

            lua = [
              lua-language-server
              stylua
            ];

            markdown = [ marksman ];

            nix = [
              nixd
              nixfmt-rfc-style
            ];

            python = [
              pyright
              ruff
            ];

            rust = [
              clippy
              rust-analyzer
              rustfmt
            ];

            sh = [
              nodePackages.bash-language-server
              shellcheck
              shfmt
            ];

            typst = [
              tinymist
              typstyle
            ];
          };

          startupPlugins = with pkgs.vimPlugins; {
            general = [
              (pkgs.fetchFromGitHub {
                owner = "amedoeyes";
                repo = "eyes.nvim";
                rev = "master";
                hash = "sha256-tUeuORxJ0Oe/z9bMBb5uPplYp6CoHVmBshxajAJACjs=";
              })
              blink-cmp
              friendly-snippets
              none-ls-nvim
              nvim-treesitter.withAllGrammars
              fzf-lua
              mini-nvim
              mini-ai
              mini-align
              mini-clue
              mini-diff
              mini-icons
              mini-move
              mini-operators
              mini-pairs
              mini-splitjoin
              mini-surround
            ];

            markdown = [ render-markdown-nvim ];

          };
          environmentVariables = {
            general = {
              NVIM_BACKGROUND = config.theme.palette;
            };
          };
        }
      );

      packageDefinitions.replace = {
        nvim =
          { ... }:
          {
            settings = {
              hosts = {
                node.enable = false;
                perl.enable = false;
                python.enable = false;
                ruby.enable = false;
              };
            };

            categories = {
              general = true;

              c = true;
              css = true;
              go = true;
              haskell = true;
              html = true;
              js = true;
              json = true;
              lua = true;
              markdown = true;
              nix = true;
              python = true;
              rust = true;
              sh = true;
              typst = true;
            };
          };
      };
    };
  };
}
