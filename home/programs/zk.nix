{ lib, config, ... }:
let
  cfg = config.programs.zk;
in
{
  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "zk/templates/default.md".text = ''
        ---
        title: {{title}}
        date: {{now}}
        tags: []
        ---
      '';

      "zk/templates/idea.md".text = ''
        ---
        title: {{title}}
        date: {{now}}
        tags: [idea]
        ---

        # {{title}}

        ---

        ## Related Notes

        ## Resources
      '';

      "zk/templates/project.md".text = ''
        ---
        title: {{title}}
        date: {{now}}
        tags: [project]
        ---

        # {{title}}

        ## To-do

        ---

        ## Related Notes

        ## Resources
      '';

      "zk/templates/study.md".text = ''
        ---
        title: {{title}}
        date: {{now}}
        tags: [study]
        ---

        # {{title}}

        ---

        ## Related Notes

        ## Resources
      '';
    };

    programs.zk = {
      settings = {
        notebook.dir = "$HOME/notes/";

        note = {
          language = "en";
          default-title = "Untitled";
          filename = "{{format-date now 'timestamp-unix'}}";
          extension = "md";
          template = "default.md";
          id-charset = "alphanum";
          id-length = 4;
          id-case = "lower";
        };

        format.markdown = {
          link-format = "wiki";
          link-encode-path = false;
          link-drop-extension = false;
          hashtags = false;
          colon-tags = false;
          multiword-tags = false;
        };

        lsp.diagnostics = {
          wiki-title = "none";
          dead-link = "error";
        };

        group = {
          idea.note = {
            filename = "{{slug title}}";
            template = "idea.md";
          };

          project.note = {
            filename = "{{slug title}}";
            template = "project.md";
          };

          study.note = {
            filename = "{{slug title}}";
            template = "study.md";
          };
        };

        tool = {
          fzf-bind-new = "";
        };
      };
    };
  };
}
