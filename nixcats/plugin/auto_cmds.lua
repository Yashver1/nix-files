vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.o.expandtab = true
    vim.o.softtabstop = 4
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
  end,
})
