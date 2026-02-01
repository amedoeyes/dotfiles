{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.helix;
in
{
  options.programs.helix = {
    default = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config.programs.helix = lib.mkIf cfg.enable {
    defaultEditor = cfg.default;
    extraPackages = with pkgs; [
      bash-language-server
      clang-tools
      clippy
      haskell-language-server
      marksman
      nixd
      nixfmt
      biome
      ruff
      rust-analyzer
      rustfmt
      shellcheck
      shfmt
      taplo
      tinymist
      ty
      typescript-go
      vscode-langservers-extracted
    ];
    settings = {
      theme = "eyes";
      editor = {
        line-number = "relative";
        cursorline = true;
        auto-completion = false;
        true-color = true;
        preview-completion-insert = false;
        trim-trailing-whitespace = true;
        popup-border = "all";
        auto-pairs = false;
        statusline = {
          left = [
            "mode"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right = [ "position" ];
        };
        lsp = {
          auto-signature-help = false;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };
        soft-wrap = {
          wrap-indicator = "";
        };
        inline-diagnostics = {
          cursor-line = "warning";
        };
      };
    };
    languages = {
      language = [
        {
          name = "bash";
          language-servers = [ "bash-language-server" ];
          formatter = {
            command = "shfmt";
          };
          auto-format = true;
        }
        {
          name = "c";
          language-servers = [ "clangd" ];
          auto-format = true;
        }
        {
          name = "cpp";
          language-servers = [ "clangd" ];
          auto-format = true;
        }
        {
          name = "css";
          language-servers = [ "vscode-css-language-server" ];
          formatter = {
            command = "biome";
            args = [
              "format"
              "--stdin-file-path=_.css"
            ];
          };
          auto-format = true;
        }
        {
          name = "haskell";
          language-servers = [ "haskell-language-server" ];
          auto-format = true;
        }
        {
          name = "html";
          formatter = {
            command = "biome";
            args = [
              "format"
              "--stdin-file-path=_.html"
            ];
          };
          language-servers = [ "vscode-html-language-server" ];
          auto-format = true;
        }
        {
          name = "javascript";
          language-servers = [
            {
              name = "tsgo";
              except-features = [ "format" ];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = [
              "format"
              "--stdin-file-path=_.js"
            ];
          };
          auto-format = true;
        }
        {
          name = "json";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = [ "format" ];
            }
          ];
          formatter = {
            command = "biome";
            args = [
              "format"
              "--stdin-file-path=_.json"
            ];
          };
          auto-format = true;
        }
        {
          name = "jsonata";
          scope = "source.jsonata";
          injection-regex = "jsonata";
          file-types = [ "jsonata" ];
          indent = {
            tab-width = 2;
            unit = "  ";
          };
          block-comment-tokens = {
            start = "/*";
            end = "*/";
          };
        }
        {
          name = "jsx";
          language-servers = [
            {
              name = "tsgo";
              except-features = [ "format" ];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = [
              "format"
              "--stdin-file-path=_.jsx"
            ];
          };
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = [
            "marksman"
            "zk"
          ];
          auto-format = true;
        }
        {
          name = "nix";
          language-servers = [ "nixd" ];
          auto-format = true;
        }
        {
          name = "python";
          language-servers = [
            "ty"
            "ruff"
          ];
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
          auto-format = true;
        }
        {
          name = "toml";
          language-servers = [ "taplo" ];
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = [
            {
              name = "tsgo";
              except-features = [ "format" ];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = [
              "format"
              "--stdin-file-path=_.tsx"
            ];
          };
          auto-format = true;
        }
        {
          name = "typescript";
          language-servers = [
            {
              name = "tsgo";
              except-features = [ "format" ];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = [
              "format"
              "--stdin-file-path=_.ts"
            ];
          };
          auto-format = true;
        }
        {
          name = "typst";
          language-servers = [ "tinymist" ];
          auto-format = true;
        }
      ];
      language-server = {
        biome = {
          command = "biome";
          args = [ "lsp-proxy" ];
        };
        tinymist = {
          command = "tinymist";
          config = {
            formatterMode = "typstyle";
          };
        };
        tsgo = {
          command = "tsgo";
          args = [
            "--lsp"
            "--stdio"
          ];
        };
        zk = {
          command = "zk";
          args = [ "lsp" ];
          required-root-patterns = [ ".zk" ];
        };
      };
    };
    themes = {
      eyes = with config.theme.colors; {
        "ui.background" = {
          fg = "#${c04.hex}";
          bg = "#${c00.hex}";
        };
        "ui.background.separator" = "#${c04.hex}";
        "ui.cursor" = {
          fg = "#${c00.hex}";
          bg = "#${c08.hex}";
        };
        "ui.cursor.normal" = {
          fg = "#${c00.hex}";
          bg = "#${c08.hex}";
        };
        "ui.cursor.insert" = {
          fg = "#${c00.hex}";
          bg = "#${c08.hex}";
        };
        "ui.cursor.select" = {
          fg = "#${c00.hex}";
          bg = "#${c08.hex}";
        };
        "ui.cursor.match" = {
          fg = "#${c10.hex}";
          bg = "#${c02.hex}";
        };
        "ui.cursor.primary" = {
          fg = "#${c00.hex}";
          bg = "#${c10.hex}";
        };
        "ui.cursor.primary.normal" = {
          fg = "#${c00.hex}";
          bg = "#${c10.hex}";
        };
        "ui.cursor.primary.insert" = {
          fg = "#${c00.hex}";
          bg = "#${c10.hex}";
        };
        "ui.cursor.primary.select" = {
          fg = "#${c00.hex}";
          bg = "#${c10.hex}";
        };
        "ui.debug.breakpoint" = "#${c10.hex}";
        "ui.debug.active" = "#${c10.hex}";
        "ui.gutter" = "#${c10.hex}";
        "ui.gutter.selected" = "#${c10.hex}";
        "ui.linenr" = "#${c04.hex}";
        "ui.linenr.selected" = "#${c10.hex}";
        "ui.statusline" = {
          fg = "#${c10.hex}";
          modifiers = [ "bold" ];
        };
        "ui.statusline.inactive" = {
          fg = "#${c06.hex}";
          modifiers = [ "bold" ];
        };
        "ui.statusline.normal" = {
          fg = "#${c10.hex}";
          modifiers = [ "bold" ];
        };
        "ui.statusline.insert" = {
          fg = "#${c10.hex}";
          modifiers = [ "bold" ];
        };
        "ui.statusline.select" = {
          fg = "#${c10.hex}";
          modifiers = [ "bold" ];
        };
        "ui.statusline.separator" = "#${c04.hex}";
        "ui.bufferline" = "#${c06.hex}";
        "ui.bufferline.active" = {
          fg = "#${c10.hex}";
          modifiers = [ "bold" ];
        };
        "ui.bufferline.background" = { };
        "ui.popup" = "#${c04.hex}";
        "ui.popup.info" = "#${c04.hex}";
        "ui.picker.header" = { };
        "ui.picker.header.column" = "#${c06.hex}";
        "ui.picker.header.column.active" = "#${c10.hex}";
        "ui.window" = "#${c04.hex}";
        "ui.help" = "#${c10.hex}";
        "ui.text" = "#${c10.hex}";
        "ui.text.focus" = {
          bg = "#${c01.hex}";
        };
        "ui.text.inactive" = "#${c04.hex}";
        "ui.text.info" = "#${c10.hex}";
        "ui.text.directory" = "#${c09.hex}";
        "ui.virtual.ruler" = "#${c10.hex}";
        "ui.virtual.whitespace" = "#${c03.hex}";
        "ui.virtual.indent-guide" = "#${c03.hex}";
        "ui.virtual.inlay-hint" = "#${c04.hex}";
        "ui.virtual.inlay-hint.parameter" = "#${c04.hex}";
        "ui.virtual.inlay-hint.type" = "#${c04.hex}";
        "ui.virtual.wrap" = "#${c03.hex}";
        "ui.virtual.jump-label" = {
          fg = "#${c10.hex}";
          bg = "#${c02.hex}";
        };
        "ui.menu" = "#${c10.hex}";
        "ui.menu.selected" = {
          bg = "#${c01.hex}";
        };
        "ui.menu.scroll" = "#${c04.hex}";
        "ui.selection" = {
          bg = "#${c02.hex}";
        };
        "ui.selection.primary" = {
          bg = "#${c02.hex}";
        };
        "ui.highlight" = {
          bg = "#${c01.hex}";
        };
        "ui.highlight.frameline" = {
          bg = "#${c01.hex}";
        };
        "ui.cursorline.primary" = {
          bg = "#${c01.hex}";
        };
        "ui.cursorline.secondary" = { };
        "ui.cursorcolumn.primary" = "#${c10.hex}";
        "ui.cursorcolumn.secondary" = { };
        "warning" = "#${c10.hex}";
        "error" = "#${c10.hex}";
        "info" = "#${c10.hex}";
        "hint" = "#${c10.hex}";
        "diagnostic" = "#${c10.hex}";
        "diagnostic.hint" = {
          underline = {
            color = "#${c10.hex}";
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = "#${c10.hex}";
            style = "curl";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = "#${c10.hex}";
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = "#${c10.hex}";
            style = "curl";
          };
        };
        "diagnostic.unnecessary" = "#${c04.hex}";
        "diagnostic.deprecated" = {
          fg = "#${c04.hex}";
          modifiers = [ "crossed_out" ];
        };
        "tabstop" = {
          fg = "#${c10.hex}";
          bg = "#${c02.hex}";
        };
        rainbow = [ "#A0A0A0" ];
        "type" = "#${c07.hex}";
        "constructor" = "#${c07.hex}";
        "constant" = "#${c08.hex}";
        "string" = "#${c08.hex}";
        "comment" = "#${c04.hex}";
        "variable" = "#${c10.hex}";
        "label" = "#${c10.hex}";
        "punctuation" = "#${c06.hex}";
        "keyword" = "#${c06.hex}";
        "operator" = "#${c07.hex}";
        "function" = "#${c09.hex}";
        "tag" = "#${c08.hex}";
        "namespace" = "#${c07.hex}";
        "special" = "#${c06.hex}";
        "markup.heading" = {
          fg = "#${c10.hex}";
          modifiers = [ "bold" ];
        };
        "markup.list" = "#${c10.hex}";
        "markup.bold" = {
          fg = "#${c10.hex}";
          modifiers = [ "bold" ];
        };
        "markup.italic" = {
          fg = "#${c10.hex}";
          modifiers = [ "italic" ];
        };
        "markup.link.url" = {
          fg = "#${c08.hex}";
          modifiers = [
            "italic"
            "underlined"
          ];
        };
        "markup.quote" = "#${c08.hex}";
        "markup.raw" = "#${c08.hex}";
        "diff.plus" = "#${c08.hex}";
        "diff.minus" = "#${c04.hex}";
        "diff.delta" = "#${c06.hex}";
      };
    };
  };
}
