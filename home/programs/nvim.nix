{ pkgs, ... }:
{
  home.sessionVariables = {
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;
    extraPackages = with pkgs; [
      xdg-utils
      bash-language-server
      gofumpt
      gopls
      lua-language-server
      marksman
      nil
      nixfmt-rfc-style
      nodePackages.prettier
      pyright
      ruff
      clippy
      rustfmt
      rust-analyzer
      shellcheck
      shfmt
      stylua
      typescript-language-server
      vscode-langservers-extracted
    ];
  };
}
