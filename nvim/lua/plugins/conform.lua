return {
  "conform.nvim",
  opts = function(_, opts)
    if LazyVim.has_extra("formatting.prettier") then
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.javascript = { "prettierd" }
      opts.formatters_by_ft.typescript = { "prettierd" }

      opts.formatters.golines = {
        command = "golines",
        args = { "-m", "80" },
      }
    end
  end,
}
