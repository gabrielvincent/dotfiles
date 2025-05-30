return {
  "saghen/blink.cmp",
  optional = true,
  dependencies = { "codeium.nvim", "saghen/blink.compat" },
  opts = function(_, opts)
    opts.keymap = {
      preset = "super-tab",
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
