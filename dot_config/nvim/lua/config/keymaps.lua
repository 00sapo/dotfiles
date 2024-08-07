local utils = require("utils.utils")
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-p>", "<cmd>Telescope commands<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sm", "<cmd>Telescope bookmarks list<cr>", { desc = "Select bookmark" })
vim.keymap.set("n", "<leader><cr>", "<C-/>!!<cr>", { remap = true, desc = "Run command in toggled terminal" })
vim.keymap.set("n", "<leader>n", require("aerial").nav_toggle, { desc = "Toggle Aerial" })
vim.keymap.set(
  "n",
  "<leader>dL",
  require("utils.utils").dap_chooser,
  { noremap = true, desc = "Load dap configuration" }
)
