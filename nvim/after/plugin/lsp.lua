local lsp_zero = require('lsp-zero')

local function rename_file()
    local source_file, target_file

    vim.ui.input({
        prompt = "Source : ",
        completion = "file",
        default = vim.api.nvim_buf_get_name(0)
    }, function(input) source_file = input end)
    vim.ui.input({
        prompt = "Target : ",
        completion = "file",
        default = source_file
    }, function(input) target_file = input end)

    local params = {
        command = "_typescript.applyRenameFile",
        arguments = {{sourceUri = source_file, targetUri = target_file}},
        title = ""
    }

    vim.lsp.util.rename(source_file, target_file)
    vim.lsp.buf.execute_command(params)
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'tsserver', 'eslint', 'jsonls', 'lua_ls'},
    handlers = {lsp_zero.default_setup}
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-ENTER>'] = cmp.mapping.confirm({select = true}),
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false
                    })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({select = true}),
            c = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            })
        }),
        ["<C-Space>"] = cmp.mapping.complete()
    })
    -- sources = {{name = 'nvim_lua'}, {name = 'nvim_lsp'}, {name = "luasnip"}}
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

lspconfig.biome.setup {}

-- Configure rust_analyzer language server
lspconfig.rust_analyzer.setup({capabilities = capabilities})

-- Configure lua_ls language server
lspconfig.lua_ls.setup {
    settings = {Lua = {diagnostics = {globals = {'vim', 'ui'}}}}
}

lspconfig.tailwindcss.setup({
    capabilities = capabilities,
    init_options = {userLanguages = {typescriptreact = "javascript"}},
    handlers = {
        ["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
            vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse",
                               {_id = params._id})
        end
    },
    settings = {
        includeLanguages = {
            tsx = "html",
            typescriptreact = "javascript",
            svelte = "html",
            rust = "html"
        },
        tailwindCSS = {
            emmetCompletions = true,
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning"
            },
            classAttributes = {"class", "className", "tw"},
            experimental = {
                classRegex = {
                    "twc\\(\"([^\"]*)", "tw\\(\\s*['\"]([^'\"]*)",
                    "twc\\(\\s*['\"]([^'\"]*)", "tw`([^`]*)", "tw=\"([^\"]*)",
                    "tw={\"([^\"}]*)", "tw\\.\\w+`([^`]*)",
                    "tw\\(.*?\\)`([^`]*)", "tw\\.style\\(([^)]*)\\)",
                    "\\bclass:\\s*'([^']*)'", "\\bclass:\\s*\"([^\"]*)\""
                }
            },
            validate = true
        }
    },
    filetypes = {
        "css", "scss", "sass", "html", "javascript", "javascriptreact",
        "typescript", "typescriptreact", "rust", "svelte"
    }
})

lspconfig.tsserver.setup({
    capabilities = capabilities,
    commands = {RenameFile = {rename_file, description = "Rename File"}}
    -- on_attach = function(client)
    --     client.resolved_capabilities.document_formatting = false
    --     client.resolved_capabilities.document_range_formatting = false
    -- end
})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = {'*.tsx', '*.ts', '*.jsx', '*.js', '*.cjs', '*.mjs', '*.json'},
    command = 'EslintFixAll',
    group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {})
})
