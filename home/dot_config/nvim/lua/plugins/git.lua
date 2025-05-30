local M = {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
  },
  -- {
  --   "NeogitOrg/neogit",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- required
  --     "sindrets/diffview.nvim", -- optional - Diff integration
  --
  --     -- Only one of these is needed.
  --     "nvim-telescope/telescope.nvim", -- optional
  --     -- "ibhagwan/fzf-lua", -- optional
  --     -- "echasnovski/mini.pick",         -- optional
  --     -- "folke/snacks.nvim",             -- optional
  --   },
  --   cmd = "Neogit",
  --   keys = {
  --     { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
  --     {
  --       "<leader>gG",
  --       function()
  --         local Job = require("plenary.job")
  --         Job:new({
  --           command = "aider-copilot",
  --           args = { "--commit" },
  --           on_exit = function(j, return_val)
  --             if return_val == 0 then
  --               print("Auto commit message generated successfully.")
  --             else
  --               print("Failed to generate auto commit message.")
  --             end
  --           end,
  --         }):start()
  --       end,
  --       desc = "Auto commit message via aider",
  --     },
  --   },
  --   opts = {
  --     integrations = {
  --       diffview = true, -- requires `diffview.nvim`
  --       telescope = true, -- requires `telescope.nvim`
  --       -- fzf_lua = true, -- requires `fzf-lua`
  --       -- mini_pick = true, -- requires `mini.pick`
  --       -- snacks = true, -- requires `snacks.nvim`
  --     },
  --   },
  -- },
}
return M
