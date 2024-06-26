-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.shell = "/bin/fish"
vim.cmd("set wrap linebreak nolist")
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand("~/.cache/nvim/backups/")
vim.opt.breakindent = true
vim.opt.breakindentopt = { "shift:2", "sbr" }
vim.opt.guicursor = "n-v:block-blinkon0,i:ver100-blinkon0,o:hor100-blinkon0,c:hor100-blinkon0"
vim.opt.relativenumber = true
vim.opt.formatoptions:remove("t")
vim.opt.inccommand = "nosplit" -- live substitution
vim.opt.textwidth = 88

-- indentation
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.clipboard = vim.o.clipboard .. ",unnamedplus"
