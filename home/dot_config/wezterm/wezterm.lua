local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
config.default_prog = { "fish", "-l" }

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

local function sync_theme()
	local appearance
	if wezterm.gui then
		-- wezterm.gui is not available to the mux server, so take care to
		-- do something reasonable when this config is evaluated by the mux
		appearance = wezterm.gui.get_appearance()
	else
		appearance = "Dark"
	end
	if appearance:find("Dark") then
		return "Builtin Dark"
	else
		return "Builtin Light"
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
				"\\w+?://[.\\-_:&?=,;/\\w]+",
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
}

-- navigation (nvim integration)
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config)

-- allow nvim-zenmode to setup wezterm
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return config
