vim.g.neoformat_try_node_exe = 1

vim.api.nvim_exec([[
  augroup fmt
    autocmd!
    au BufWritePre * try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry
  augroup END
]], false)

-- Map the key combination to the function
vim.keymap.set("n", "<leader>f", function()
    local current_file = vim.fn.expand('%:p')
    local extension = vim.fn.fnamemodify(current_file, ':e')

    if extension == 'prisma' then
        vim.cmd("silent !npx prisma format")
    elseif extension == 'liquid' then
        vim.cmd("silent !npx prettier --write %")
    else
        vim.cmd("Neoformat")
    end
end)

-- vim.g.neoformat_run_all_formatters = 1
-- vim.g.neoformat_enabled_javascript = {'eslint_d'}
-- vim.g.neoformat_enabled_typescript = {'eslint_d'}
-- vim.g.neoformat_enabled_typescriptreact = {'eslint_d'}

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = {'*.tsx', '*.ts', '*.jsx', '*.js', '*.cjs', '*.mjs', '*.json'},
    command = 'silent! EslintFixAll',
    group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {})
})

