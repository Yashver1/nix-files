return { {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "ibhagwan/fzf-lua",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim"
  },
  opts = {
    image_support = true,

  },
},
  {
    "3rd/image.nvim",
    build = false,

    opts = {
      backend = "kitty",
      processor = "magick_cli",

      integrations = {
        markdown = {
          enabled = true,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          floating_windows = false,
        },
      },
    },

  }

}
