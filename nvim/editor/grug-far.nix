{ ... }:
{

  plugins.grug-far = {
    enable = true;
    luaConfig.content = ''
      local ok, grug = pcall(require, "grug-far")
      if not ok then return end

      -- Safe: plugin exports setup() in recent versions; no-op if missing
      if type(grug.setup) == "function" then
        grug.setup({
          headerMaxWidth = 80,
        })
      end

      _G.__grug_open_with_ext = function()
        local grug = require("grug-far")
        local ext = (vim.bo.buftype == "" and vim.fn.expand("%:e")) or nil
        grug.open({
          transient = true,
          prefills = {
            filesFilter = (ext and ext ~= "" and ("*." .. ext)) or nil,
          },
        })
      end
    '';
  };

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>sr";
      action = "<cmd>lua __grug_open_with_ext()<CR>";
      options.desc = "Search and Replace (grug-far)";
    }
  ];

}
