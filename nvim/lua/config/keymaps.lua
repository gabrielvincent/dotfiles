-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")

-- Visual mode keymaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Normal mode keymaps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")

--- Jump to end of line
vim.keymap.set("v", "$", "g_")

-- Insert mode keymaps
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "<C-u>", "<Esc><C-u>")
vim.keymap.set("i", "<C-d>", "<Esc><C-d>")

-- Terminal mode keymaps
vim.keymap.set("t", "<C-u>", "<C-\\><C-N><C-u>")
vim.keymap.set("t", "<C-d>", "<C-\\><C-N><C-d>")

-- Indent on enter insert mode
vim.keymap.set("n", "i", function()
  return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
end, { expr = true, noremap = true })

-- Telescope
vim.keymap.set("n", "<leader>ss", function()
  require("telescope.builtin").lsp_document_symbols()
end, { desc = "Goto Symbol" })
vim.keymap.set("n", "<leader>sf", function()
  require("telescope.builtin").lsp_document_symbols({
    ignore_symbols = { "variable", "property" },
  })
end, { desc = "Goto Symbol (minus variables and properties)" })

vim.opt.pumblend = 10 -- Make popup menu transparent

-- Configure float appearance
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3e4451" })

-- Adjust LSP float settings
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

-- Configure diagnostic float
vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})
