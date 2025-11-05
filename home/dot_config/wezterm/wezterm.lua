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

-- this function, called at every `window-config-reloaded`, allows to sync the theme with the OS'
-- dark/light setting
function scheme_for_appearance(window)
	-- this is used to set a universal variable, which emits an event in fish
	local function tell_clis_about_appearance(arg)
		wezterm.background_child_process({
			"fish",
			"-c",
			"set --universal OS_APPEARANCE " .. arg,
		})
	end

	local appearance = window:get_appearance()
	if appearance:find("Dark") then
		tell_clis_about_appearance("dark")
		return "alabaster_dark" -- this has been added by me, see the colors/ dir  else
	else
		tell_clis_about_appearance("light")
		return "Alabaster" -- the built-in theme is only light
	end
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local scheme = scheme_for_appearance(window)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

-- keybindings
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.CharSelect,
	},
	{ key = "d", mods = "LEADER", action = act.ScrollByPage(0.5) },
	{ key = "j", mods = "LEADER", action = act.ScrollToPrompt(1) },
	{ key = "k", mods = "LEADER", action = act.ScrollToPrompt(-1) },
	{
		key = "o",
		mods = "LEADER",
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
		key = "s",
		mods = "LEADER",
		action = act.SplitVertical,
	},
	{ key = "u", mods = "LEADER", action = act.ScrollByPage(-0.5) },
	{
		key = "v",
		action = act.SplitHorizontal,
		mods = "LEADER",
	},

	-- keybidnings not using LEADER
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
	{ key = "h", mods = "CTRL|ALT", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "CTRL|ALT", action = act.ActivateTabRelative(1) },
}

-- plugins
require("plugins").apply_to_config(config)

-- side_pane
require("side_pane").apply_to_config(config)
return config
