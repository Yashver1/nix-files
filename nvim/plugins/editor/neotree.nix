{ ... }:
{
  plugins.neo-tree = {
    enable = true;
    closeIfLastWindow = true;
    sources = [
      "filesystem"
      "buffers"
      "git_status"
      "document_symbols"
    ];
    popupBorderStyle = "rounded"; # “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code

    filesystem = {
      bindToCwd = false;
      useLibuvFileWatcher = true;
      followCurrentFile.enabled = true;
    };

    defaultComponentConfigs = {
      gitStatus = {
        symbols = {
          added = " ";
          conflict = "󰩌 ";
          deleted = "󱂥 ";
          ignored = " ";
          modified = " ";
          renamed = " ";
          staged = "✓ ";
          unstaged = " ";
          untracked = " ";
        };
      };
    };

    window.mappings = {
      "<space>" = "none";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>E";
      action = "<cmd>Neotree toggle<cr>";
      options = {
        silent = true;
        desc = "Explorer NeoTree (root dir)";
      };
    }
  ];
}
