-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- If file is latex, then setup CTRL-B and CTRL-I to \textbf{} and \textit{} when in
-- visual mode and the same in insert mode but the cursor ends before the }
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.tex" },
  callback = function(ev)
    vim.keymap.set("i", "<C-b>", "\\textbf{}<esc>i", { noremap = true, silent = true, buffer = true })
    vim.keymap.set("i", "<C-i>", "\\textit{}<esc>i", { noremap = true, silent = true, buffer = true })
    vim.keymap.set("v", "<C-b>", "c\\textbf{}<esc>P", { noremap = true, silent = true, buffer = true })
    vim.keymap.set("v", "<C-i>", "c\\textit{}<esc>P", { noremap = true, silent = true, buffer = true })
  end,
})

-- Load file nvim-dap.json in current working directory if it exists
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function(ev)
    local file = vim.fn.expand(".")
    if vim.fn.filereadable(file .. "/nvim-dap.json") then
      require("dap.ext.vscode").load_launchjs(file .. "/nvim-dap.json")
    end
  end,
})
