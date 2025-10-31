local M = {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        fish = { "fish" },
        cmake = { "cmakelint" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    cond = function()
      -- % -> filename of current buffer
      -- :e -> extensioon only
      return vim.fn.expand("%:e") ~= "scd"
    end,
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                executable = "latexmk",
                args = {
                  "-latex=lualatex",
                  "-interaction=nonstopmode",
                  "-synctex=1",
                  "-outdir=/tmp/texlab",
                  "%f",
                },
                auxDirectory = "/tmp/texlab",
                pdfDirectory = "/tmp/texlab",
                onSave = true,
                -- forwardSearchAfter = true,
              },
              chktex = {
                onEdit = false,
                onOpenAndSave = false,
              },
              diagnosticsDelay = 300,
              formatterLineLength = 80,
              latexFormatter = "latexindent",
              latexindent = {
                modifyLineBreaks = true,
              },
              forwardSearch = {
                -- see nvim-texlabconfig
                -- executable = "zathura",
                -- args = {
                --   "--synctex-editor-command",
                --   [[nvim-texlabconfig -file '%%%{input}' -line %%%{line} -server ]] .. vim.v.servername,
                --   "--synctex-forward",
                --   "%l:1:%f",
                --   "%p",
                -- },
                executable = "sioyek",
                args = {
                  "--reuse-window",
                  -- "--execute-command",
                  -- "toggle_synctex", -- Open Sioyek in synctex mode.
                  "--inverse-search",
                  'nvim-texlabconfig -file "%%%1" -line "%%%2" -server ' .. vim.v.servername,
                  "--forward-search-file",
                  "%f",
                  "--forward-search-line",
                  "%l",
                  "%p",
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "f3fora/nvim-texlabconfig",
    config = function()
      vim.o.updatetime = 500 -- used by CursorHold for automatic forward search
      require("texlabconfig").setup()
    end,
    ft = { "tex", "bib" }, -- Lazy-load on filetype
    keys = {
      { "<leader><", "<cmd>TexlabForward<cr>", desc = "Forward Search (LaTeX)" },
      { "<leader>>", "<cmd>TexlabBuild<cr>", desc = "Compile (LaTeX)" },
    },
    build = "go build -o ~/.local/bin/",
  },
  {
    "linux-cultist/venv-selector.nvim",
    cmd = { "VenvSelectCached" },
    keys = { { "<leader>cV", "<cmd>VenvSelectCached<cr>", desc = "Select cached virtualenv" } },
  },
}
return M
