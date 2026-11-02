lsps = {
  clangd = {
    cmd = {
      "clangd",
      "--query-driver=/usr/bin/clang++,/opt/homebrew/opt/llvm/bin/clang++",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu", "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
  },
  lua_ls = {},
  termux_language_server = {},
  bashls = {},
  hyprls = {},
  texlab = {},
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          ["https://www.schemastore.org/clangd.json"] = ".clangd",
        },
      },
    },
  },
  pyrefly = {},
  rust_analyzer = {},
  tombi = {},
  nil_ls = {},
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "mason-org/mason.nvim",
    },
    config = function(_, opts)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for lsp, base_config in pairs(lsps) do
        local lsp_config = vim.tbl_extend("force", base_config, {
          capabilities = capabilities,
        })
        vim.lsp.config(lsp, lsp_config)
        vim.lsp.enable(lsp)
      end
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = vim.tbl_keys(lsps)
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
