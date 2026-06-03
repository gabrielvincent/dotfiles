return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      ["*"] = {
        keys = {
          { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
          { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
          { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
          { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
        },
      },
      crystalline = {
        cmd = { "crystalline" },
        filetypes = { "crystal" },
      },
      cssls = {
        settings = {
          css = { lint = { unknownAtRules = "ignore" } },
          scss = { lint = { unknownAtRules = "ignore" } },
          less = { lint = { unknownAtRules = "ignore" } },
        },
      },
      vue_ls = {
        settings = {
          css = { lint = { unknownAtRules = "ignore" } },
          scss = { lint = { unknownAtRules = "ignore" } },
          less = { lint = { unknownAtRules = "ignore" } },
        },
      },
      volar = {
        settings = {
          css = { lint = { unknownAtRules = "ignore" } },
          scss = { lint = { unknownAtRules = "ignore" } },
          less = { lint = { unknownAtRules = "ignore" } },
        },
      },
    },
  },
}
