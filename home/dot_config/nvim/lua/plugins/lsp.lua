require("lint").linters.cython = {
  name = "cython",
  cmd = "cython",
  stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
  append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
  -- add time to the output file
  args = { "-Wextra", "-o", ".cython_linter_output" }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
  stream = "both", -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
  ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
  env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
  parser = function(output, bufnr, cwd)
    local result = {}
    local pattern1 = "([%w ]*):? ?([^:]+):(%d+):(%d+): (.+)"
    local pattern2 = "([^:]+):(%d+):(%d+): (.+)"
    for line in output:gmatch("[^\n]+") do
      local severities = {
        ["error"] = vim.diagnostic.severity.ERROR,
        ["warning"] = vim.diagnostic.severity.WARN,
        ["information"] = vim.diagnostic.severity.INFO,
        ["performance hint"] = vim.diagnostic.severity.HINT,
      }
      local file, lnum, col, message
      local severity = line:match("^[^:]+")
      if severity == "warning" or severity == "information" or severity == "performance hint" then
        severity, file, lnum, col, message = line:match(pattern1)
      else
        severity = "error"
        file, lnum, col, message = line:match(pattern2)
      end
      if file then
        local diagnostic = {
          bufnr = bufnr,
          file = file,
          lnum = tonumber(lnum) - 1,
          col = tonumber(col),
          message = message,
          severity = severities[severity],
          source = "cython",
        }
        table.insert(result, diagnostic)
      end
    end
    return result
  end,
}

local M = {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        fish = { "fish" },
        cmake = { "cmakelint" },
        pyrex = { "cython" },
        -- python = { "cython" },
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
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-outdir=/tmp/texlab", "%f" },
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
                modifyLineBreaks = false,
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
        pyright = { enable = false }, -- only use ruff
        ltex = {
          mason = true,
          autostart = true,
          enable = true,
          on_attach = function(client, bufnr)
            -- setup ltex_extra
            require("ltex_extra").setup({
              load_langs = { "it", "en-US" },
              init_check = true,
              path = vim.fn.expand("~") .. "/.local/share/ltex",
            })
          end,
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
    keys = { { "<leader><", "<cmd>TexlabForward<cr>", desc = "Forward Search (LaTeX)" } },
    -- build = "go build",
    build = "go build -o ~/.local/bin/",
  },
  {
    "linux-cultist/venv-selector.nvim",
    cmd = { "VenvSelectCached" },
    keys = { { "<leader>cV", "<cmd>VenvSelectCached<cr>", desc = "Select cached virtualenv" } },
  },
  {
    "barreiroleo/ltex_extra.nvim",
    ft = { "markdown", "tex" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
  -- {
  --   "lervag/vimtex",
  --   lazy = false,
  --   init = function()
  --     -- VimTeX configuration goes here, e.g.
  --     vim.g.vimtex_view_method = "zathura"
  --   end,
  -- },
}
return M
