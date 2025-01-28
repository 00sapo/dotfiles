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
  {
    "rcarriga/nvim-dap-ui",
    keys = {
      { "<leader>dw", add_to_watches, desc = "Add to watches", mode = { "n", "v" } },
    },
    opts = {
      layouts = {
        {
          elements = {},
          size = 0,
          position = "left", -- Can be "left" or "right"
        },
        {
          elements = {
            -- "console",
            -- { id = "breakpoints", size = 0.25 },
            { id = "watches", size = 0.75 },
            { id = "stacks", size = 0.25 },
          },
          size = 10,
          position = "bottom", -- Can be "bottom" or "top"
        },
      },
    },
    dependencies = {
      -- "rcarriga/cmp-dap",
      "nvim-neotest/nvim-nio",
      "LiadOz/nvim-dap-repl-highlights",
    },
  },
  {
    "LiadOz/nvim-dap-repl-highlights",
    opts = true,
  },
}
return M
