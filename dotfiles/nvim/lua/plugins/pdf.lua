return {
  "franco-ruggeri/pdf-preview.nvim",
  lazy = true,
  opts = {
  },
  config = function(_, opts)
    require("pdf-preview").setup(opts)
  end
}
