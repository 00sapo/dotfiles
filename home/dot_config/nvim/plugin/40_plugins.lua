-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘

-- Some tool for easier keymaps
local nmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("n", "<leader>" .. suffix, rhs, { noremap = true, silent = true, desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("x", "<leader>" .. suffix, rhs, { noremap = true, silent = true, desc = desc })
end

-- Make concise helpers for installing/adding plugins in two stages
local _add, later = MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

-- add default values to 'add'
local add = function(...)
	local arg = { ... }
	if arg["checkout"] ~= nil then
		arg["checkout"] = "HEAD"
	end
	if arg["monitor"] ~= nil then
		arg["monitor"] = "main"
	end
	return _add(unpack(arg))
end

-- Tree-sitter ================================================================
--
-- Add these plugins now if file (and not 'mini.starter') is shown after startup.
now_if_args(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})
	require("nvim-treesitter").setup({
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
				},
			},
		},
	})
	add("nvim-treesitter/nvim-treesitter-textobjects")
	require("nvim-treesitter.configs").setup({
		auto_install = true, -- automatically install a parser when opening a file
	})
end)

-- Language servers ===========================================================
local default_lsp = {
	"lua_ls",
	"pylsp",
	"ts_ls",
	"texlab",
}

now_if_args(function()
	add("neovim/nvim-lspconfig")
	vim.lsp.enable(default_lsp)
end)

-- Formatting =================================================================
later(function()
	add("stevearc/conform.nvim")

	-- See also:
	-- - `:h Conform`
	-- - `:h conform-options`
	-- - `:h conform-formatters`
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "yapf" },
		},
	})
end)

-- Snippets ===================================================================
later(function()
	add("rafamadriz/friendly-snippets")
end)

-- Honorable mentions =========================================================
later(function()
	add("mason-org/mason.nvim")
	require("mason").setup()

	-- add("owallb/mason-auto-install.nvim")
	-- require("mason-auto-install").setup({ packages = default_lsp })
end)

-- Beautiful, usable, well maintained color schemes outside of 'mini.nvim' and
-- have full support of its highlight groups. Use if you don't like 'miniwinter'
-- enabled in 'plugin/30_mini.lua' or other suggested 'mini.hues' based ones.
MiniDeps.now(function()
	-- Install only those that you need
	add("p00f/alabaster.nvim")
	--   add('sainnhe/everforest')
	--   add('Shatur/neovim-ayu')
	--   add('ellisonleao/gruvbox.nvim')
	--
	--   -- Enable only one
	vim.o.background = "dark"
	vim.g.alabaster_dim_comments = true
	vim.g.alabaster_floatborder = false
	vim.cmd("color alabaster")
end)

later(function()
	-- AI plugin
	add("NickvanDyke/opencode.nvim")
	nmap_leader("aA", function()
		require("opencode").ask()
	end, "Ask")
	nmap_leader("aa", function()
		require("opencode").ask("@cursor: ")
	end, "Ask about this")
	xmap_leader("aa", function()
		require("opencode").ask("@selection: ")
	end, "Ask about selection")

	-- debugging
	add("andrewferrier/debugprint.nvim")
	require("debugprint").setup({
		keymaps = {
			normal = {
				plain_below = "<leader>dp",
				plain_above = "<leader>dP",
				variable_below = "<leader>dv",
				variable_above = "<leader>dV",
				variable_below_alwaysprompt = "",
				variable_above_alwaysprompt = "",
				surround_plain = "<leader>dsp",
				surround_variable = "<leader>dsv",
				surround_variable_alwaysprompt = "",
				textobj_below = "<leader>do",
				textobj_above = "<leader>dO",
				textobj_surround = "<leader>dso",
				toggle_comment_debug_prints = "<leader>dc",
				delete_debug_prints = "<leader>dd",
			},
			insert = {
				plain = "<C-G>p",
				variable = "<C-G>v",
			},
			visual = {
				variable_below = "<leader>dv",
				variable_above = "<leader>dV",
			},
		},
	})

	-- :Quickmath
	add("jbyuki/quickmath.nvim")

	-- <C-u> for icon picking
	add("ziontee113/icon-picker.nvim")
	require("icon-picker").setup({ disable_legacy_commands = true })
	local opts = { noremap = true, silent = true }
	vim.keymap.set("i", "<C-u>", "<cmd>IconPickerInsert<cr>", opts)

	-- :SudaWrite, :SudaRead
	add("lambdalisue/suda.vim")

	-- interesting word <3
	add("Mr-LLLLL/interestingwords.nvim")
	require("interestingwords").setup({
		colors = {
			"#ff4538",
			"#ffe438",
			"#7bff38",
			"#38ff95",
			"#38caff",
			"#4538ff",
			"#e438ff",
			"#ff387b",
			"#ff9538",
			"#caff38",
			"#9538ff",
		},
		search_count = true,
		navigation = true,
		search_key = "<leader>ks",
		cancel_search_key = "<leader>kS",
		color_key = "<leader>kk",
		cancel_color_key = "<leader>kK",
	})

	-- undotree history (:Atone toggle/open/close/focus)
	add("XXiaoA/atone.nvim")
	require("atone").setup()
	nmap_leader("ht", "<cmd>Atone toggle<cr>", "Atone toggle")
	nmap_leader("hf", "<cmd>Atone focus<cr>", "Atone focus")

	-- github urls (:GitHubURLRepo...)
	add("pgr0ss/vim-github-url")
	nmap_leader("gur", "<cmd>GitHubURLRepo<cr>", "Copy GitHub Repo URL")
	nmap_leader("gur", "<cmd>GitHubURLBlame<cr>", "Copy GitHub Blame line URL")
	nmap_leader("gur", "<cmd>GitHubURLBlob<cr>", "Copy GitHub Blob line URL")

	add({ source = "kdheepak/lazygit.nvim", depends = { "nvim-lua/plenary.nvim" } })
	nmap_leader("gg", "<cmd>LazyGit<cr>", "Lazygit")
	nmap_leader("gh", "<cmd>LazyGitFilterCurrentFile<cr>", "Lazygit File History")
	-- -- python's venv selection
	-- add("linux-cultist/venv-selector.nvim")
	-- require("venv-selector").setup()

	-- latex automatic texlab config forward/backward search
	add({
		source = "f3fora/nvim-texlabconfig",
		hooks = {
			post_checkout = function()
				os.execute("go build -o ~/.local/bin/")
			end,
		},
	})
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "tex", "latex" },
		callback = function(ev)
			vim.o.updatetime = 500 -- used by CursorHold for automatic forward search
			require("nvim-texlabconfig").setup()
		end,
	})

	-- better escape from insert mode (jk/kj, etc)
	add("max397574/better-escape.nvim")
	require("better_escape").setup()

	-- nvim-spectre for multi-file replacements
	add({ source = "MagicDuck/grug-far.nvim" })
	nmap_leader("fe", function()
		require("grug-far").open({ windowCreationCommand = 'tabnew'})
	end, "Search&Replace multi-file")
end)

------------ Other plugins non lazy loaded
MiniDeps.now(function()
	-- navigation between windows
	add("mrjones2014/smart-splits.nvim") -- recommended mappings
	-- resizing splits
	-- these keymaps will also accept a range,
	-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
	vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
	vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
	vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
	vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
	-- moving between splits
	vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
	vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
	vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
	vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
	vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
end)
