require('tokyonight').setup({day_brightness = 0.5})
local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
    update_interval = 60 * 30 * 1000,
    set_dark_mode = function() vim.api.nvim_set_option('background', 'dark') end,
    set_light_mode = function()
        vim.api.nvim_set_option('background', 'light')
    end
})

vim.cmd("colorscheme tokyonight-moon")

