local M = {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "Davidyz/VectorCode",
      "ravitemer/codecompanion-history.nvim",
      "lalitmee/codecompanion-spinners.nvim",
      "folke/snacks.nvim",
    },
    build = "uv tool install -U vectorcode", -- This helps keeping the CLI up-to-date
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
    config = function(_, opts)
      require("codecompanion").setup(opts)
      local default_system_prompt = require("codecompanion.config").strategies.chat.opts.system_prompt
      require("codecompanion.config").strategies.chat.opts.system_prompt = function(...)
        -- default system prompt can be called only after setup
        local default = default_system_prompt(...)
        -- replace CodeCompanion with Eleonora
        return default:gsub("CodeCompanion", "Eleonora")
      end
    end,
    opts = {
      strategies = {
        chat = {
          adapter = {
            name = "copilot",
            model = "gpt-4o",
          },
          roles = {
            ---The header name for the LLM's messages
            llm = function(adapter)
              return "Eleonora (" .. adapter.formatted_name .. ")"
            end,
            ---The header name for your messages
            user = "Federico",
          },
          tools = {
            opts = {
              default_tools = {
                "devtools",
              },
            },
            groups = {
              ["web"] = {
                description = "Web agent",
                system_prompt = "These tools allow to access web and online information that are more up-to-date than the LLM knowledge and contains detail that the LLM may is missing.",
                tools = { "fetch_webpage", "serch_web" },
              },
              ["devtools"] = {
                description = "A miniml set of dev tools",
                system_prompt = "These tools allow to find files, read and write code, and run commands. Being in unix environment, you can use unix commands, such as `cat`, `head`, `tail`, `grep`, `awk`, `python`, `sed`, `git`, `ls`, `tree`, `find`, and more. One command that is especially useful to navigate code is `ast-grep`. Other tools are provided for easier, more efficient, and more secure code discovery and modification.",
                tools = {
                  "cmd_runner",
                  -- "list_code_usages",
                  -- "vectorcode_query",
                  -- "vectorcode_ls",
                  -- "vectorcode_files_ls",
                  -- "vectorcode_vectorise",
                  "insert_edit_into_file",
                },
              },
            },
          },
        },
      },
      display = {
        diff = {
          enabled = true,
          provider_opts = {
            -- Options for inline diff provider
            inline = {
              layout = "split",
            },
          },
        },
        chat = {
          window = {
            layout = "buffer",
          },
          intro_message = "Welcome to Eleonora 🌳! Press ? for options",
        },
      },
      memory = {
        default = {
          description = "Collection of common files for all projects",
          parser = "claude",
          files = {
            "ai/CONVENTIONS.md",
            "ai/DESIGN.md",
          },
        },
        opts = {
          chat = {
            enabled = true,
          },
        },
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
        spinner = {
          opts = {
            style = "snacks", -- Choose your spinner style
          },
          -- opts = {
          --   -- Full configuration available
          -- },
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
        vectorcode = {
          opts = {
            tool_group = {
              -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
              enabled = true,
              -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
              -- if you use @vectorcode_vectorise, it'll be very handy to include
              -- `file_search` here.
              extras = { "file_search" },
              collapse = true, -- whether the individual tools should be shown in the chat
            },
          },
        },
        history = {
          enabled = true,
          picker_keymaps = {
            rename = { n = "r", i = "<C-s>" },
            delete = { n = "d", i = "<C-w>" },
            duplicate = { n = "<C-y>", i = "<C-y>" },
          },
        },
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
