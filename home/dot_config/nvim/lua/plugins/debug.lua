local function add_to_watches(...)
  local add_watch = require("dapui").elements.watches.add
  -- if in visual mode, get the last selected text
  -- otherwise, add the current word
  local selection = ""
  if vim.fn.mode() == "V" or vim.fn.mode() == "v" then
    local startpos = vim.fn.getpos("v")
    local endpos = vim.fn.getpos(".")
    local lines = vim.api.nvim_buf_get_lines(0, startpos[2] - 1, endpos[2], false)
    if #lines > 1 then
      return
    end
    selection = lines[1]:sub(startpos[3], endpos[3])
  else
    selection = vim.fn.expand("<cword>")
    if selection == "" then
      selection = vim.fn.expand("<cWORD>")
    end
  end
  if selection == "" then
    return
  end
  add_watch(selection)
end

M = {
  {
    "andrewferrier/debugprint.nvim",

    -- opts = { … },

    dependencies = {
      "echasnovski/mini.nvim", -- Optional: Needed for line highlighting (full mini.nvim plugin)
      -- ... or ...
      "echasnovski/mini.hipatterns", -- Optional: Needed for line highlighting ('fine-grained' hipatterns plugin)

      "ibhagwan/fzf-lua", -- Optional: If you want to use the `:Debugprint search` command with fzf-lua
      "nvim-telescope/telescope.nvim", -- Optional: If you want to use the `:Debugprint search` command with telescope.nvim
      "folke/snacks.nvim", -- Optional: If you want to use the `:Debugprint search` command with snacks.nvim
    },

    lazy = false, -- Required to make line highlighting work before debugprint is first used
    version = "*", -- Remove if you DON'T want to use the stable version
  },
  -- {
  --   "rcarriga/cmp-dap",
  --   config = function()
  --     require("cmp").setup({
  --       enabled = function()
  --         return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt" or require("cmp_dap").is_dap_buffer()
  --       end,
  --     })
  --
  --     require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  --       sources = {
  --         { name = "dap" },
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   keys = {
  --     { "<leader>dw", add_to_watches, desc = "Add to watches", mode = { "n", "v" } },
  --   },
  --   opts = {
  --     layouts = {
  --       {
  --         elements = { "stacks", "console", "breakpoints" },
  --         size = 40,
  --         position = "right", -- Can be "left" or "right" or "top" or "bottom"
  --       },
  --       {
  --         elements = {
  --           { id = "watches", size = 0.5 },
  --           { id = "repl", size = 0.5 },
  --         },
  --         size = 10,
  --         position = "bottom",
  --       },
  --     },
  --   },
  --   dependencies = {
  --     -- "rcarriga/cmp-dap",
  --     "nvim-neotest/nvim-nio",
  --     -- "LiadOz/nvim-dap-repl-highlights",
  --   },
  -- },
  -- -- {
  -- --   "LiadOz/nvim-dap-repl-highlights",
  -- --   opts = true,
  -- },
}
return M
