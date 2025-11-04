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

-- this function syncs the theme with the OS light/dark setting
local function sync_theme()
	local appearance
	if wezterm.gui then
		-- wezterm.gui is not available to the mux server, so take care to
		-- do something reasonable when this config is evaluated by the mux
		appearance = wezterm.gui.get_appearance()
	else
		appearance = "Light"
	end
	if appearance:find("Dark") then
		config.color_scheme = "alabaster_dark" -- this has been added by me, see the colors/ dir
	else
		config.color_scheme = "Alabaster" -- the built-in theme is only light
-- config.colors.ansi[8] = "#000000"
-- config.colors.brights[8] = "#000000"
	end
end
config.color_scheme = sync_theme()

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
