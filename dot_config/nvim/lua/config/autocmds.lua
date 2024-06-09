-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = { "*" },
  callback = function(ev)
    -- check if file was already opened in some buffer
    if vim.fn.bufexists(ev.fname) == 1 then
      return
    end
    -- count number of lines in ev.fname using pure lua
    local n = tonumber(vim.fn.system({ "wc", "-l", vim.fn.expand("%") }):match("%d+"))
    if n > 150 then
      vim.o.foldlevel = 0
    else
      vim.o.foldlevel = 99
    end
  end,
})

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

-- Remove cursorline and cursorcolumn when exiting buffer
-- local filetypes_no_cursorline =
--   { "TelescopePrompt", "neo-tree", "undotree", "copilot-chat", "dashboard", "DiffviewFiles" }
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  pattern = { "*" },
  callback = function(ev)
    -- if vim.tbl_contains(filetypes_no_cursorline, vim.bo.filetype) then
    --   return
    -- end
    vim.wo.cursorline = true
    vim.wo.cursorcolumn = true
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  pattern = { "*" },
  callback = function(ev)
    vim.wo.cursorline = false
    vim.wo.cursorcolumn = false
  end,
})
