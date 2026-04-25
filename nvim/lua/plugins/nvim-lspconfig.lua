return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      crystalline = {
        cmd = { "crystalline" },
        filetypes = { "crystal" },
      },
    },
  },
}
