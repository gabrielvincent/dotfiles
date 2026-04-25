return {
  "conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}

    -- Function to check if a config file exists
    local function has_config(config_files)
      for _, config in ipairs(config_files) do
        if vim.fn.findfile(config, ".;" .. vim.fn.getcwd()) ~= "" then
          return true
        end
      end
      return false
    end

    -- Function to check package.json for a dependency
    local function has_package_dep(package_name)
      local package_json = vim.fn.findfile("package.json", ".;" .. vim.fn.getcwd())
      if package_json == "" then
        return false
      end

      local ok, decoded = pcall(vim.fn.json_decode, vim.fn.readfile(package_json))
      if not ok then
        return false
      end

      local deps = vim.tbl_extend("force", decoded.dependencies or {}, decoded.devDependencies or {})
      return deps[package_name] ~= nil
    end

    -- Detect the best formatter for JS/TS projects
    local function js_formatter()
      -- Priority 1: Check for config files (strongest signal)
      if has_config({ "oxlintrc.json", ".oxlintrc.json", ".oxfmtrc.json" }) then
        return { "oxfmt" }
      end

      if has_config({ "biome.json", "biome.jsonc" }) then
        return { "biome", "biome-organize-imports" }
      end

      if
        has_config({
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.js",
          ".prettierrc.yaml",
          ".prettierrc.yml",
          "prettier.config.js",
          "prettier.config.mjs",
          "prettier.config.cjs",
        })
      then
        return { "prettierd" }
      end

      -- Priority 2: Check package.json dependencies
      if has_package_dep("oxlint") or has_package_dep("@oxc/oxlint") then
        return { "oxfmt" }
      end

      if has_package_dep("@biomejs/biome") or has_package_dep("biome") then
        return { "biome", "biome-organize-imports" }
      end

      if has_package_dep("prettier") then
        return { "prettierd" }
      end

      -- Priority 3: Try fast formatters if available system-wide
      if vim.fn.executable("oxfmt") == 1 then
        return { "oxfmt" }
      end

      if vim.fn.executable("biome") == 1 then
        return { "biome", "biome-organize-imports" }
      end

      return { "prettierd" }
    end

    opts.formatters_by_ft.javascript = js_formatter()
    opts.formatters_by_ft.typescript = js_formatter()
    opts.formatters_by_ft.vue = js_formatter()
    opts.formatters_by_ft.json = js_formatter()
    opts.formatters_by_ft.jsonc = js_formatter()
    opts.formatters_by_ft.svelte = { "prettierd" }
    opts.formatters_by_ft.liquid = { "prettierd" }
    opts.formatters_by_ft.templ = { "templ" }
    opts.formatters_by_ft.hcl = { "hclfmt" }
    opts.formatters_by_ft.sql = { "sqlfluff" }
    opts.formatters_by_ft.go = { "golines" }
    opts.formatters_by_ft.crystal = { "crystal_fmt" }
    opts.formatters_by_ft.eruby = { "erb_format" }
    opts.formatters_by_ft["eruby.html"] = { "erb_format" }
    opts.formatters_by_ft.python = { "ruff_organize_imports", "ruff_format" }
    opts.formatters_by_ft.markdown = {}

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
