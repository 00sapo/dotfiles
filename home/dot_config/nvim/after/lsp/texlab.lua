return {
	settings = {
    -- NOTE: All of this should still be tested, this was copy-pasted from lazyvim
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
}
