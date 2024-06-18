return {
  "conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.javascript = { "prettierd" }
    opts.formatters_by_ft.typescript = { "prettierd" }
    opts.formatters_by_ft.svelte = { "prettierd" }
    opts.formatters.golines = {
      command = "golines",
      args = { "-m", "80" },
    }
  end,
}
