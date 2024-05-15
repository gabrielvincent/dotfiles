local oil = require("oil")
oil.setup({
	delete_to_trash = true,
	use_default_keymaps = false,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		-- ["<C-s>"] = "actions.select_vsplit",
		["<C-h>"] = "actions.select_split",
		["<C-t>"] = "actions.select_tab",
		["<C-Space>"] = "actions.preview",
		["<C-l>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
		["g\\"] = "actions.toggle_trash",
	},
	float = { padding = 8 },
})

local function should_open_oil()
	-- Get the current buffer number
	local bufnr = vim.api.nvim_get_current_buf()
	-- Retrieve the 'buftype' option for the current buffer
	local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
	print(buftype)
	-- Check if the buftype is 'terminal'
	return buftype ~= "terminal" and buftype ~= "nowrite"
end

vim.keymap.set("n", "-", function()
	if should_open_oil() == false then
		return
	end

	local current_dir = oil.get_current_dir()
	oil.open(current_dir)
end)
