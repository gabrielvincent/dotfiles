return {
  "conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.javascript = { "prettierd" }
    opts.formatters_by_ft.typescript = { "biome", "biome-organize-imports" }
    opts.formatters_by_ft.svelte = { "prettierd" }
    opts.formatters_by_ft.liquid = { "prettierd" }
    opts.formatters_by_ft.templ = { "templ" }
    opts.formatters_by_ft.hcl = { "hclfmt" }
    opts.formatters_by_ft.sql = { "sql-formatter" }
    opts.formatters_by_ft.go = { "golines" }
    opts.formatters_by_ft.crystal = { "crystal_fmt" }

    -- Add formatter definitions
    opts.formatters = opts.formatters or {}
    opts.formatters.hclfmt = {
      command = "hclfmt",
    }
    opts.formatters["sql-formatter"] = {
      command = "sql-formatter",
    }
    opts.formatters.crystal_fmt = {
      command = "crystal",
      args = { "tool", "format", "-" },
      stdin = true,
    }
  end,
}
