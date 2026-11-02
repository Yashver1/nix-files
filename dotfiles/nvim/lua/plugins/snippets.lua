return
{ {
  "L3MON4D3/LuaSnip",
  version = "v2.5.0",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    enable_autosnippets = true,
    update_events = "TextChanged,TextChangedI",
  },
  config = function(_, opts)
    local ls = require("luasnip")
    ls.setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })

    -- vim.keymap.set({ "i" }, "<C-K>", function()
    -- 	ls.expand()
    -- end, { silent = true })
    -- vim.keymap.set({ "i", "s" }, "<C-L>", function()
    -- 	ls.jump(1)
    -- end, { silent = true })
    -- vim.keymap.set({ "i", "s" }, "<C-J>", function()
    -- 	ls.jump(-1)
    -- end, { silent = true })
    --
    -- vim.keymap.set({ "i", "s" }, "<C-E>", function()
    -- 	if ls.choice_active() then
    -- 		ls.change_choice(1)
    -- 	end
    -- end, { silent = true })
  end,
},
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require 'luasnip-latex-snippets'.setup({
        allow_on_markdown = true,
      })
      require("luasnip").config.setup { enable_autosnippets = true }
    end,
  },
}
