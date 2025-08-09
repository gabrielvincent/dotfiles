return {
  "saghen/blink.cmp",
  optional = true,
  dependencies = { "codeium.nvim", "saghen/blink.compat" },
  ---@module 'blink.cmp'
  ---@type fun(_, opts: blink.cmp.Config)
  opts = function(_, opts)
    opts.keymap = {
      preset = "default",
      ["<Tab>"] = { "select_and_accept" },
    }
    opts.sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      compat = { "codeium" },
      providers = {
        codeium = {
          kind = "Codeium",
          score_offset = -999,
          async = true,
        },
      },
    }
    opts.completion = {
      ghost_text = {
        enabled = false,
      },
    }
  end,
}
