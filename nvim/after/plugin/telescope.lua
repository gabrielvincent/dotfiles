local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>gd', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({search = vim.fn.input("Grep > ")});
end)