local lspsaga = require("lspsaga")

lspsaga.setup({
	ui = { code_action = "" },
	diagnostic = { keys = { quit = { "q", "<ESC>" } } },
})

vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
vim.keymap.set("n", "<leader>df", "<cmd>Lspsaga peek_definition<CR>")
vim.keymap.set("n", "<leader>dc", "<cmd>Lspsaga hover_doc<CR>")
vim.keymap.set("n", "<leader>tr", "<cmd>Lspsaga term_toggle<CR>")
vim.keymap.set("t", "<leader>tr", "<cmd>Lspsaga term_toggle<CR>")
vim.keymap.set("n", "<leader>i", "<cmd>Lspsaga incoming_calls<CR>")
