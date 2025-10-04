return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-mini/mini.icons",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local alpha = require("alpha")
    local theta = require("alpha.themes.theta")

    alpha.setup(theta.config)

    -- Show alpha on startup
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
          alpha.start()
        end
      end,
    })
  end,
}
