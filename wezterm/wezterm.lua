local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

--- Theme
config.color_scheme = "Catppuccin Latte"

-- Font
config.font_size = 18.0

-- Tab bar
config.use_fancy_tab_bar = false

-- Window padding
config.window_padding = {
	left = 16,
	right = 0,
	top = 16,
	bottom = 0,
}

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
}

return config
