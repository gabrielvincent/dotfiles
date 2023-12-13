vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

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
vim.opt.listchars:append({lead = '·'})

vim.api.nvim_exec([[
    autocmd BufNewFile,BufRead *.env.* set filetype=bash
    autocmd BufNewFile,BufRead Podfile set syntax=ruby
]], false)

vim.keymap.set('n', 'i', function()
    return
        string.match(vim.api.nvim_get_current_line(), '%g') == nil and 'cc' or
            'i'
end, {expr = true, noremap = true})
