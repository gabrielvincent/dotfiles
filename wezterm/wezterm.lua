local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Font
config.font_size = 22.0
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- disable ligatures

-- Window padding
config.window_padding = {
	left = 16,
	right = 0,
	top = 16,
	bottom = 0,
}

config.leader = { key = " ", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "-",
		mods = "CMD",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "\\",
		mods = "CMD",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CMD",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "h",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action({
			SpawnCommandInNewTab = {
				cwd = wezterm.home_dir,
			},
		}),
	},
	{ key = "s", mods = "LEADER", action = wezterm.action({ EmitEvent = "save_session" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ EmitEvent = "load_session" }) },
	{ key = "r", mods = "LEADER", action = wezterm.action({ EmitEvent = "restore_session" }) },
}

-- Setup Colorscheme
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Light"
end

local appearance = get_appearance()
local color_scheme = nil

if appearance == "Dark" then
	color_scheme = "PaperColor Dark (base16)"
else
	color_scheme = "PaperColor Light (base16)"
end

config.color_scheme = color_scheme

-- Tabs
config.use_fancy_tab_bar = false
config.tab_max_width = 32

-- Session Management
local session_manager = require("wezterm-session-manager/session-manager")
wezterm.on("save_session", function(window)
	session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
	session_manager.restore_state(window)
end)


return config
