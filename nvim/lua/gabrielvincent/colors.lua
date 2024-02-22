-- require('tokyonight').setup({day_brightness = 0.35})
local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
    update_interval = 1000,
    set_dark_mode = function() vim.cmd("colorscheme tokyonight-moon") end,
    set_light_mode = function()
        -- vim.api.nvim_set_option('background', 'light')
        vim.cmd("colorscheme catppuccin-latte")
    end
})

-- vim.cmd("colorscheme tokyonight-moon")

