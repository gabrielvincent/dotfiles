require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	shade_terminals = false,
	direction = "vertical",
	size = 80,
	persist_size = true,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.bo.filetype == "toggleterm" then
			vim.cmd("startinsert")
		end
	end,
})
