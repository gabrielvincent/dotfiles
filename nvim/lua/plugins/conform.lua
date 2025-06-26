return {
  "conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}

    -- Function to check if prettier config exists
    local function has_prettier_config()
      local prettier_configs = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.js",
        ".prettierrc.yaml",
        ".prettierrc.yml",
        "prettier.config.js",
        "prettier.config.mjs",
        "prettier.config.cjs",
      }

      for _, config in ipairs(prettier_configs) do
        if vim.fn.findfile(config, ".;" .. vim.fn.getcwd()) ~= "" then
          return true
        end
      end

      return false
    end

    -- Conditional formatter function
    local function js_formatter()
      return has_prettier_config() and { "prettierd" } or { "biome", "biome-organize-imports" }
    end

    opts.formatters_by_ft.javascript = js_formatter()
    opts.formatters_by_ft.typescript = js_formatter()
    opts.formatters_by_ft.json = js_formatter()
    opts.formatters_by_ft.jsonc = js_formatter()
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
