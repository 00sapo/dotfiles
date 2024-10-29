local function add_to_watches(...)
  local add_watch = require("dapui").elements.watches.add
  add_watch(...)
end

local actions_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local function load_launchjs(bufnr)
  local file = actions_state.get_selected_entry()[1]
  require("dap.ext.vscode").load_launchjs(file)
  actions.close(bufnr)
end

local function dap_chooser()
  require("telescope.builtin").find_files({
    attach_mappings = function(_, map)
      map("n", "<cr>", load_launchjs)
      map("i", "<cr>", load_launchjs)
      return true
    end,
  })
end

M = {
  {
    "rcarriga/cmp-dap",
    config = function()
      require("cmp").setup({
        enabled = function()
          return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt" or require("cmp_dap").is_dap_buffer()
        end,
      })

      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    keys = {
      { "<leader>dw", add_to_watches, desc = "Add to watches" },
      { "<leader>dL", dap_chooser, desc = "Load dap configuration" },
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
  },
  dependencies = {
    "rcarriga/cmp-dap",
    "LiadOz/nvim-dap-repl-highlights",
  },
}
return M
