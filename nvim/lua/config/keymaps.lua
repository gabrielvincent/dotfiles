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
vim.keymap.set("n", "<S-G>", "<S-G>zz", { remap = false })
vim.keymap.set("n", "<leader>j", "i<CR><Esc>")

-- Disable buffer navigation
vim.keymap.set("n", "L", "")
vim.keymap.set("n", "H", "")

--- Jump to end of line
vim.keymap.set("v", "$", "g_")

-- Insert mode keymaps
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "<C-u>", "<Esc><C-u>")
vim.keymap.set("i", "<C-d>", "<Esc><C-d>")

vim.api.nvim_create_augroup("TerminalInsert", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  group = "TerminalInsert",
  pattern = "term://*", -- Only trigger for terminal buffers
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert!")
    end
  end,
})

-- Yank the line on `dd` only if it is non-empty
vim.keymap.set("n", "dd", function()
  if vim.fn.getline("."):match("^%s*$") then
    return '"_dd'
  end
  return "dd"
end, { expr = true })
