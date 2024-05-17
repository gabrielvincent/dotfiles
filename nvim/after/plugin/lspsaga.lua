local lspsaga = require("lspsaga")

lspsaga.setup({
	ui = { code_action = "" },
	diagnostic = { keys = { quit = { "q", "<ESC>" } } },
})

vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
vim.keymap.set("n", "<leader>df", "<cmd>Lspsaga peek_definition<CR>")
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
vim.keymap.set("n", "<leader>i", "<cmd>Lspsaga incoming_calls<CR>")
vim.keymap.set("n", "<C-W>d", "<cmd>Lspsaga show_line_diagnostics<CR>")
