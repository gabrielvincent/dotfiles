function set_gomod_filetype()
	local filename = vim.fn.expand("%:t")
	if filename == "go.mod" then
		vim.bo.filetype = "gomod"
	end
end

-- Autocommand to trigger the function when opening a buffer
vim.cmd([[
    augroup SetGoModFiletype
        autocmd!
        autocmd BufEnter * lua set_gomod_filetype()
    augroup END
]])
