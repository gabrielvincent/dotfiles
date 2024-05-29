local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Font
config.font_size = 18.0
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- disable ligatures

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

-- Setup Colorscheme
local function get_appearance()
	local handle =
		io.popen("osascript -e 'tell application \"System Events\" to tell appearance preferences to get dark mode'")
	if handle == nil then
		return "light"
	end

	local result = handle:read("*a")
	if result == nil then
		return "light"
	end

	handle:close()
	if result:find("true") then
		return "dark"
	else
		return "light"
	end
end

local appearance = get_appearance()
local color_scheme = nil

if appearance == "dark" then
	color_scheme = "Tokyo Night Moon"
else
	color_scheme = "Catppuccin Latte"
end

config.color_scheme = color_scheme

return config
