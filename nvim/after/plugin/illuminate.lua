local illuminate = require("illuminate")

illuminate.configure({
    providers = {'lsp', 'treesitter'},
    delay = 0,
    min_count_to_highlight = 2
})

vim.keymap.set("n", "<C-n>",
               "<cmd>lua require('illuminate').goto_next_reference{wrap=true}<CR>",
               {noremap = true, silent = true})
