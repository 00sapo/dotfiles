-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-p>", "<cmd>Telescope commands<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><cr>", "<C-/>!!<cr>", { remap = true, desc = "Run command in toggled terminal" })

-- movements across splits
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
-- select last pasted text
-- i.e. in vim: nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
vim.keymap.set("n", "gl", function()
  local start_mark = vim.api.nvim_buf_get_mark(0, "[")
  local end_mark = vim.api.nvim_buf_get_mark(0, "]")

  -- Move cursor to start of last pasted text
  vim.api.nvim_win_set_cursor(0, start_mark)

  -- Get the register type to determine selection mode
  local regtype = vim.fn.getregtype()
  local selection_mode

  if regtype:sub(1, 1) == "v" then
    selection_mode = "v" -- characterwise
  elseif regtype:sub(1, 1) == "V" then
    selection_mode = "V" -- linewise
  else
    selection_mode = "\22" -- blockwise (Ctrl-V)
  end

  -- Enter visual mode and select to end mark
  vim.cmd("normal! " .. selection_mode)
  vim.api.nvim_win_set_cursor(0, end_mark)
end, { desc = "Select last pasted text" })

-- scratch buffer (don't know why, it's not enabled, maybe something is overriding it)
vim.keymap.set("n", "<leader>.", function()
  Snacks.scratch()
end, { desc = "Open scratch buffer" })

-- scratch math (i.e. snacks' scratch with lua ft and Quickmath enabled)
vim.keymap.set("n", "<leader>:", function()
  Snacks.scratch({
    ft = "lua",
    icon = "💻",
    name = "Scratch Math",
  })
  vim.cmd("Quickmath")
end, { desc = "Scratch math" })
