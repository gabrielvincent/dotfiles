local auto_dark_mode = require("auto-dark-mode")

local DEFAULT_COLORSCHEME_LIGHT = "base16-grayscale-light"
local DEFAULT_COLORSCHEME_DARK = "base16-grayscale-dark"
local FUGITIVE_COLORSCHEME_LIGHT = "catppuccin-latte"
local FUGITIVE_COLORSCHEME_DARK = "catppuccin-mocha"

local theme = "light"

local colorschemes = {
	light = {
		fugitive = FUGITIVE_COLORSCHEME_LIGHT,
		regular = DEFAULT_COLORSCHEME_LIGHT,
	},
	dark = {
		fugitive = FUGITIVE_COLORSCHEME_DARK,
		regular = DEFAULT_COLORSCHEME_DARK,
	},
}

local function change_colorscheme()
	local filetype = vim.bo.filetype
	local mode = "regular"

	if filetype == "fugitive" then
		mode = "fugitive"
	end

	local colorscheme = colorschemes[theme][mode]

	vim.cmd("colorscheme " .. colorscheme)
end

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		theme = "dark"
		change_colorscheme()
	end,
	set_light_mode = function()
		theme = "light"
		change_colorscheme()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		change_colorscheme()
	end,
})
