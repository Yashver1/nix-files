return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Parent Directory" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-s>"] = false,

        ["<C-h>"] = "<cmd>TmuxNavigateLeft<CR>",
        ["<C-j>"] = "<cmd>TmuxNavigateDown<CR>",
        ["<C-k>"] = "<cmd>TmuxNavigateUp<CR>",
        ["<C-l>"] = "<cmd>TmuxNavigateRight<CR>",

        ["<C-x>"] = "actions.select_split",
        ["<C-v>"] = "actions.select_vsplit",
      },
    },
  },

  {
    "benomahony/oil-git.nvim",
    dependencies = {
      "stevearc/oil.nvim",
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Tree" },
    },
    opts = {
      disable_netrw = true,
      hijack_netrw = true,
      update_focused_file = {
        enable = true
      },

      view = {
        width = 30,
        side = "right",
        preserve_window_proportions = true,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = false,
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
      filters = {
        dotfiles = false,
        custom = { "^.git$" },
      },
    },
  },
}
