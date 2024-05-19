vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmode = false

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
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		vim.bo.textwidth = 80
	end,
})
vim.g.mapleader = " "

vim.opt.list = true
vim.opt.listchars:append({ lead = "·", trail = "·", tab = "» " })
-- vim.g.indentLine_enabled = 1
-- vim.g.indentLine_leadingSpaceChar = "•"
-- vim.g.indentLine_leadingSpaceEnabled = "1"

vim.api.nvim_exec(
	[[
    autocmd BufNewFile,BufRead *.env.* set filetype=bash
    autocmd BufNewFile,BufRead Podfile set syntax=ruby
]],
	false
)

vim.keymap.set("n", "i", function()
	return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
end, { expr = true, noremap = true })

-- split windows separators
vim.opt.laststatus = 3

-- Customize SpellBad highlight to use an undercurl
vim.o.spell = true
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

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*", -- Apply to all colorschemes
	callback = function()
		vim.cmd([[
            hi DiagnosticUnderlineError guisp=#FF0000 gui=undercurl
            hi DiagnosticUnderlineWarn guisp=#FFFF00 gui=undercurl
            hi DiagnosticUnderlineInfo guisp=#ADD8E6 gui=undercurl
            hi DiagnosticUnderlineHint guisp=#90EE90 gui=undercurl
        ]])
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*", -- Apply to all files
	callback = function()
		print("Applying diagnostic undercurl highlights") -- Debug print
		vim.cmd([[
            hi DiagnosticUnderlineError guisp=#FF0000 gui=undercurl
            hi DiagnosticUnderlineWarn guisp=#FFFF00 gui=undercurl
            hi DiagnosticUnderlineInfo guisp=#ADD8E6 gui=undercurl
            hi DiagnosticUnderlineHint guisp=#90EE90 gui=undercurl
        ]])
		print("Diagnostic undercurl highlights applied") -- Debug print
	end,
})

-- Trigger the autocmd manually once to apply the settings initially
vim.cmd("doautocmd ColorScheme")
