local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
-- config.enable_wayland = false
config.default_prog = { "ssh-agent", "fish", "-l" }

-- appearance
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.font_size = 10.5
config.initial_rows = 36
config.initial_cols = 120

config.color_scheme = "alabaster_dark"
-- override it to get white and silver darker (for light schemes, e.g. Alabaster)
-- config.colors = wezterm.color.get_builtin_schemes()["Alabaster"]
-- config.colors.ansi[8] = "#000000"
-- config.colors.brights[8] = "#000000"

-- keybindings
config.keys = {
	{ key = "h", mods = "CTRL|ALT", action = act.ActivateTabRelativeNoWrap(-1) },
	{ key = "l", mods = "CTRL|ALT", action = act.ActivateTabRelativeNoWrap(1) },
	{ key = "k", mods = "CTRL|ALT", action = act.ScrollByLine(-1) },
	{ key = "j", mods = "CTRL|ALT", action = act.ScrollByLine(1) },
	{ key = "d", mods = "ALT", action = act.ActivateLastTab },
	{
		key = "c",
		mods = "ALT",
		action = act.Multiple({
			act.SendKey({ key = "\n" }),
			act.SendKey({ key = "\n" }),
			act.SendKey({ key = "\n" }),
			act.SendKey({ key = "\n" }),
			act.SendKey({ key = "!" }),
			act.SendKey({ key = "!" }),
			act.SendKey({ key = "\n" }),
		}),
	},
	{
		key = "u",
		mods = "CTRL|ALT",
		action = act.QuickSelectArgs({
			patterns = {
				"\\w+?://[%~\\+.\\-_:&?=,;/\\w]+",
			},
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},
	{
		key = "v",
		mods = "CTRL|ALT",
		action = act.SplitHorizontal,
	},
	{
		key = "s",
		mods = "CTRL|ALT",
		action = act.SplitVertical,
	},
  {
    key = 'e',
    mods = 'CTRL|ALT',
    action = wezterm.action.CharSelect
  },
}

-- plugins
require('plugins').apply_to_config(config)
return config
