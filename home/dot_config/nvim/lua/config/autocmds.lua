-- Autocmds are automatically loaded on the VeryLazy event

-- remove lazyvim's autocmd wrap_spell (I prefer using ltex or turn builtin spellcheck on
-- manually)
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

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
-- Using this trick of OnlyOnce because VimEnter doesn't work for some reason
-- but BufEnter does
vim.api.nvim_create_augroup("OnlyOnce", {})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = "OnlyOnce",
  callback = function()
    local file = vim.fn.expand(".")
    if vim.fn.filereadable(file .. "/nvim-dap.json") then
      require("dap.ext.vscode").load_launchjs(file .. "/nvim-dap.json")
    end
    vim.api.nvim_del_augroup_by_name("OnlyOnce")
  end,
})

-- run custom commands when background is set to light or to dark
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.v.option_new == "light" then
      -- commands to run when background is set to light
      vim.cmd("highlight Visual guibg=#DAF7A6")
      vim.cmd("highlight CursorLine guibg=#E9EBF1")
    else
      -- commands to run when background is set to dark
      -- set highlight cursorline and visual
      vim.cmd("highlight CursorLine guibg=#30194D")
      vim.cmd("highlight Visual guibg=#4D1935")
    end
  end,
})

-- add custom mappings to copilot-chat buffer
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-*",
  callback = function()
    -- C-q to accept and save the last buffer and to close neovim
    vim.keymap.set({ "n", "i" }, "<A-q>", "<esc><C-y>q:w<cr>:qa<cr>", { buffer = true, remap = true })
  end,
})
