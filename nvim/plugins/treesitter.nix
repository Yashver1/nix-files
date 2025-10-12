{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;
        autotag.enable = true;
        folding.enable = true;
        ensure_installed = [
          "bash"
          "c"
          "cpp"
          "css"
          "html"
          "javascript"
          "json"
          "lua"
          "markdown"
          "markdown_inline"
          "python"
          "regex"
          "rust"
          "toml"
          "tsx"
          "typescript"
          "vimdoc"
          "yaml"
          "nix"
          "vim"
        ];
        autoinstall = true;
        nixvimInjections = true;
      };
    };
  };
}
