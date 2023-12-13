vim.g.undotree_WindowLayout = 3
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_RelativeTimestamp = 1

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
