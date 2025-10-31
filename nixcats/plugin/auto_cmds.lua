vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "Make*",
    "make*",
  },
  callback = function()
    vim.o.softtabstop = 4
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
  end,
})
