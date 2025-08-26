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

-- clipboard
if vim.env.SSH_TTY or vim.env.TMUX then
  if vim.fn.has("nvim-0.11") == 1 then -- nvim 0.11+ has simpler osc52 support
    vim.g.clipboard = "osc52"
  else
    local function paste()
      return {
        vim.fn.split(vim.fn.getreg(""), "\n"),
        vim.fn.getregtype(""),
      }
    end
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
      },
      -- for pasting, just use ctrl+shift+v, because many terminal don't support it via osc52
      paste = {
        ["+"] = paste,
        ["*"] = paste,
      },
    }
  end
end
