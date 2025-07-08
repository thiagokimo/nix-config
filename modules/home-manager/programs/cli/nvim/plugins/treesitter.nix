{ pkgs, ... }: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [
          "lua"
          "python"
          "javascript"
          "typescript"
          "vimdoc"
          "vim"
          "regex"
          "sql"
          "dockerfile"
          "toml"
          "json"
          "java"
          "groovy"
          "go"
          "gitignore"
          "yaml"
          "make"
          "cmake"
          "markdown"
          "markdown_inline"
          "bash"
          "tsx"
          "css"
          "html"
          "kotlin"
        ];
        auto_install = true;

        highlight = { enable = true; };
        indent = { enable = true; };
      };
    };
  };
}