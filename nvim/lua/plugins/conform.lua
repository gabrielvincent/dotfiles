return {
  "conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.javascript = { "prettierd" }
    opts.formatters_by_ft.typescript = { "prettierd" }
    opts.formatters_by_ft.svelte = { "prettierd" }
    opts.formatters_by_ft.liquid = { "prettierd" }
    opts.formatters_by_ft.templ = { "templ" }
  end,
}
