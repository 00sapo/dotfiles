local M = {
  {
    "MeanderingProgrammer/render-markdown.nvim", -- just to render the codecompanion chat buffer
    ft = { "markdown", "codecompanion" },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
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
      adapters = {
        http = {
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = "cmd:rbw get deepseek_api_key",
              },
            })
          end,
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "cmd:rbw get openai_api_key",
              },
            })
          end,
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = "cmd:rbw get gemini_api_key",
              },
            })
          end,
          openrouter = function()
            return require("codecompanion.adapters").extend("openrouter", {
              env = {
                api_key = "cmd:rbw get openrouter_api_key",
              },
            })
          end,
          tavily = function()
            return require("codecompanion.adapters").extend("tavily", {
              env = {
                api_key = "cmd:rbw get tavily_api_key",
              },
            })
          end,
          mistral = function()
            return require("codecompanion.adapters").extend("mistral", {
              env = {
                api_key = "cmd:rbw get mistral_api_key",
              },
            })
          end,
        },
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
        spinner = {},
      },
    },
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
