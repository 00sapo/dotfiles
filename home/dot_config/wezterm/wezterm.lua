local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
config.default_prog = { "/usr/bin/fish", "-l" }

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
				"\\w+?://[-_&?=,;/\\w]+",
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

-- password notification
PASSWORD_NOTIFICATIONS = {}
local function has_been_notified(pane)
	for _, id in ipairs(PASSWORD_NOTIFICATIONS) do
		if pane:pane_id() == id then
			return true
		end
	end
	return false
end
local function remove_notification(pane)
	for i, id in ipairs(PASSWORD_NOTIFICATIONS) do
		if pane:pane_id() == id then
			table.remove(PASSWORD_NOTIFICATIONS, i)
			return
		end
	end
end

wezterm.on("update-status", function(window, pane)
	local meta = pane:get_metadata() or {}
	local overrides = window:get_config_overrides() or {}
	if meta.password_input then
		overrides.color_scheme = "Red Alert"
		if not has_been_notified(pane) then
			table.insert(PASSWORD_NOTIFICATIONS, pane:pane_id())
			-- activate window if possible
			window:focus()
			-- activate pane if possible
			pane:activate()
			-- send notification to /dev/pts/0
			os.execute("echo 'Password input detected in tab " .. pane:tab():tab_id() .. "!' > /dev/pts/0")
		end
	else
		overrides.color_scheme = nil
		remove_notification(pane)
	end
	window:set_config_overrides(overrides)
end)

return config
