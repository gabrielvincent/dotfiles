-- Set leader key
vim.g.mapleader = " "

-- Visual mode keymaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Normal mode keymaps
vim.keymap.set("n", "J", "mzJ`z") -- Join lines
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "Q", "<nop>")

-- Paste and yank keymaps
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "x" }, "P", [["*p]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without yank
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--- Jump to end of line
vim.keymap.set("n", "$", "g_")

-- Insert mode keymaps
vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true })
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "<C-u>", "<Esc><C-u>")
vim.keymap.set("i", "<C-d>", "<Esc><C-d>")

-- Move between splits
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-l>", "<C-w>l")
vim.keymap.set("i", "<M-h>", "<Esc><C-w>h")
vim.keymap.set("i", "<M-j>", "<Esc><C-w>j")
vim.keymap.set("i", "<M-k>", "<Esc><C-w>k")
vim.keymap.set("i", "<M-l>", "<Esc><C-w>l")
vim.keymap.set("t", "<M-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<M-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<M-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<M-l>", [[<C-\><C-n><C-w>l]])
vim.keymap.set("t", "<C-u>", [[<C-\><C-n><C-u>l]])
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")

-- Quickfix list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- LSP keymaps
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- Other keymaps
vim.keymap.set("n", "<M-CR>", "o<Esc>")
vim.keymap.set("n", "<M-BS>", "O<Esc>")

-- Terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.cmd("set filetype=terminal")
		vim.cmd("startinsert")
	end,
})
