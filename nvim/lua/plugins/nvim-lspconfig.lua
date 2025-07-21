-- Whenever an LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    -- When the client is Biome, add an automatic event on
    -- save that runs Biome's "source.fixAll.biome" code action.
    -- This takes care of things like JSX props sorting and
    -- removing unused imports.
    if client.name == "biome" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("BiomeFixAll", { clear = true }),
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.jsonc" },
        callback = function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source.fixAll.biome" },
              diagnostics = {},
            },
            apply = true,
          })
        end,
      })
    end
  end,
})

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
