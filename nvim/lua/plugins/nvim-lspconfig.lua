return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      opts.inlay_hints = { enabled = false }

      opts.servers = opts.servers or {}

      opts.servers.dartls = {
        cmd = { "dart", "language-server", "--protocol=lsp" },
      }

      opts.servers.tailwindcss = {
        filetypes_include = { "go", "templ" },
      }

      opts.servers.volar = {
        require("lspconfig").volar.setup({
          filetypes = { "vue", "json" },
        }),
      }

      ---@type lspconfig.options
      opts.setup = {
        gopls = function()
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
        end,

        crystalline = function()
          LazyVim.lsp.on_attach(function(client, _)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end, "crystalline")
        end,
      }
    end,
  },
}
