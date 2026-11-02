vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.fillchars = "eob: "
vim.opt.relativenumber = true
vim.opt.number = true;

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.winbar = " "

vim.opt.shortmess:append("I")

vim.cmd("colorscheme habamax")
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

vim.opt.clipboard = "unnamedplus"

vim.opt.undofile = true

vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "fg", bg = "bg" })

vim.opt.conceallevel = 1

vim.opt.scrolloff = 8
