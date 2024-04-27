vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--- Delete next blank line or "J"oin lines
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("", "G", "Gzz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
-- vim.keymap.set("i", "<Tab>", "<Esc>")
-- vim.keymap.set("i", "<S-Tab>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true })

vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<M-CR>", "o<Esc>")
vim.keymap.set("n", "<M-BS>", "O<Esc>")

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")

-- Move between splits
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-l>", "<C-w>l")

-- Leave terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.cmd("set filetype=terminal")
		vim.cmd("startinsert")
	end,
})

local function enter_term_mode()
	vim.cmd("term")
	vim.cmd("set filetype=terminal")
	vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("VSplitTerm", function()
	vim.cmd("vs")
	enter_term_mode()
end, { desc = "Open terminal window in window split vertically" })

vim.api.nvim_create_user_command("SplitTerm", function()
	vim.cmd("sp")
	vim.api.nvim_command("wincmd j")
	enter_term_mode()
end, { desc = "Open terminal window in window split horizontally" })

-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	callback = function()
-- 		if vim.bo.filetype == "terminal" then
-- 			vim.cmd("startinsert")
-- 		end
-- 	end,
-- })
