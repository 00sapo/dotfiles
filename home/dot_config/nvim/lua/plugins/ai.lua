local M = {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "Davidyz/VectorCode",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "List actions" },
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle Chat",
      },
      {
        "<leader>an",
        "<cmd>CodeCompanionChat<cr>",
        mode = { "n", "v" },
        desc = "New Chat",
      },
      {
        "<leader>av",
        "<cmd>CodeCompanionChat Add<cr>",
        mode = { "v" },
        desc = "Add Visual Selection",
      },
    },
    opts = {
      chat = {
        adapter = "copilot",
        model = "gpt-4.1",
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    },
  },
  {
    "Davidyz/VectorCode",
    version = "*",
    build = "uv tool install -U vectorcode", -- This helps keeping the CLI up-to-date
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- {
  --   "ravitemer/mcphub.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --
  --   build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
  --   config = function()
  --     require("mcphub").setup()
  --   end,
  -- },
}
return M
