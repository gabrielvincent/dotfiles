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
	color_scheme = "Tokyo Night Moon"
else
	color_scheme = "Catppuccin Latte"
end

config.color_scheme = color_scheme

-- Tabs
config.use_fancy_tab_bar = false
config.tab_max_width = 32

return config
