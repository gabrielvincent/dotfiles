-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmode = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.g.mapleader = " "

vim.opt.list = true
vim.opt.listchars:append({ lead = "·", trail = "·", tab = "» " })
-- vim.g.indentLine_enabled = 1
-- vim.g.indentLine_leadingSpaceChar = "•"
-- vim.g.indentLine_leadingSpaceEnabled = "1"

-- split windows separators
vim.opt.laststatus = 3

-- Customize SpellBad highlight to use an undercurl
vim.o.spelllang = "en"
vim.api.nvim_set_hl(0, "SpellBad", {
  sp = "Red", -- Color of the undercurl
  undercurl = true, -- Enable undercurl
})

-- You can similarly set up other spelling-related highlights if needed
vim.api.nvim_set_hl(0, "SpellCap", {
  sp = "Yellow",
  undercurl = true,
})

vim.api.nvim_set_hl(0, "SpellRare", {
  sp = "Cyan",
  undercurl = true,
})

vim.api.nvim_set_hl(0, "SpellLocal", {
  sp = "Blue",
  undercurl = true,
})

vim.api.nvim_create_user_command("SpellBufToggle", function()
  vim.wo.spell = not vim.wo.spell
end, {})

vim.api.nvim_create_user_command("SpellBufLang", function(details) -- I name it details out of preference
  if vim.wo.spell == false then
    vim.wo.spell = true
  end

  local args = details.fargs
  vim.cmd("setlocal spell spelllang=" .. args[1])
end, { nargs = "*" })