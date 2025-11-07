local M = {}

local wezterm = require("wezterm")

local function get_pane_info(pane, tab)
	for _, item in ipairs(tab:panes_with_info()) do
		if item.pane:pane_id() == pane:pane_id() then
			return item
		end
	end
	return nil
end

local side_pane_info = {}
local function toggle_side_pane(size, command, zoomed, name)
	if name == nil then
		name = "default"
	end
	side_pane_info[name] = nil
	local last_active_pane_id = nil
	return function(_, pane)
		local tab = pane:tab()
		local panes = tab:panes_with_info()
		local function open_side_pane()
			last_active_pane_id = pane:pane_id()
			local side_pane = pane:split({
				size = size,
				direction = "Right",
				args = command,
			})
			if zoomed then
				tab:set_zoomed(true)
			end
			side_pane_info[name] = get_pane_info(side_pane, tab)
			side_pane_info[name].orig_width = side_pane_info[name].width
		end
		if side_pane_info[name] == nil then
			wezterm.log_info("side_pane not existing yet, creating")
			open_side_pane()
		elseif pane:pane_id() == side_pane_info[name].pane:pane_id() then
			wezterm.log_info("side_pane is active, hiding it")
			tab:set_zoomed(false)
			-- using cli to change the size because this function is not exposed to lua
			wezterm.background_child_process({
				"wezterm",
				"cli",
				"adjust-pane-size",
				"--pane-id",
				pane:pane_id(),
				"--amount",
				side_pane_info[name].orig_width - 1,
				"right",
			})
			for _, p in ipairs(panes) do
				if p.pane:pane_id() == last_active_pane_id then
					p.pane:activate()
					return
				end
			end
		else
			local orig_width = side_pane_info[name].orig_width
			side_pane_info[name] = get_pane_info(side_pane_info[name].pane, tab)
			if side_pane_info[name] == nil then
				-- it was closed, opening it again
				wezterm.log_info("side_pane already toggled once but closed, reopening")
				open_side_pane()
			else
				side_pane_info[name].orig_width = orig_width
				wezterm.log_info("side_pane already toggled once and existing, activating")
				last_active_pane_id = pane:pane_id()
				if zoomed then
					side_pane_info[name].pane:activate()
					tab:set_zoomed(true)
				else
					local direction = "left"
					if orig_width == side_pane_info[name].width then
						wezterm.log_info("side_panel opened, closing it from another buffer")
						direction = "right"
					else
						side_pane_info[name].pane:activate()
						wezterm.log_info("side_panel closed, opening it")
					end
					wezterm.background_child_process({
						"wezterm",
						"cli",
						"adjust-pane-size",
						"--pane-id",
						side_pane_info[name].pane:pane_id(),
						"--amount",
						orig_width - 1,
						direction,
					})
				end
			end
		end
	end
end

function M.apply_to_config(config)
	table.insert(config.keys, {
		key = "g",
		mods = "LEADER",
		action = wezterm.action_callback(toggle_side_pane(0, { "lazygit" }, true, "lazygit")),
	})
	table.insert(config.keys, {
		key = "e",
		mods = "LEADER",
		action = wezterm.action_callback(toggle_side_pane(0.5, { "opencode" }, false, "opencode")),
	})
	table.insert(config.keys, {
		key = "t",
		mods = "LEADER",
		action = wezterm.action_callback(toggle_side_pane(0.5, { "btop" }, true, "btop")),
	})
end

return M
