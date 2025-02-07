return {
  {
    "neovim/nvim-lspconfig",
    dendencies = {
      "saghen/blink.cmp",
    },
    ---@class PluginLspOpts
    opts = function(_, opts)
      opts.inlay_hints = { enabled = false }

      ---@type lspconfig.options
      opts.setup = {
        gopls = function()
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          LazyVim.lsp.on_attach(function(client, _)
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end, "gopls")
          -- end workaround
        end,
      }

      opts.servers.dartls = {
        md = { "dart", "language-server", "--protocol=lsp" },
      }
      opts.servers.gleam = {}
    end,
  },
}
