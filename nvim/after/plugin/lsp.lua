require("mason").setup({})
require("mason-lspconfig").setup({})

require("codeium").setup({})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-j>"] = cmp.mapping.scroll_docs(-4),
		["<C-k>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "codeium" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "luasnip" },
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})

local ICONS = {
	diagnostics = { Error = " ", Warn = " ", Hint = " ", Info = " " },
}

local function get_diagnostic_prefix(severity)
	local prefix_map = {
		[vim.diagnostic.severity.ERROR] = ICONS.diagnostics.Error,
		[vim.diagnostic.severity.WARN] = ICONS.diagnostics.Warn,
		[vim.diagnostic.severity.INFO] = ICONS.diagnostics.Info,
		[vim.diagnostic.severity.HINT] = ICONS.diagnostics.Hint,
	}
	return prefix_map[severity] or ""
end

vim.diagnostic.config({
	underline = true,
	severity_sort = true,
	signs = true,
	virtual_text = {
		prefix = function(diagnostic)
			return get_diagnostic_prefix(diagnostic.severity)
		end,
	},
})

for type, icon in pairs(ICONS.diagnostics) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

-- Configure rust_analyzer language server
lspconfig.rust_analyzer.setup({ capabilities = capabilities })

-- Configure lua_ls language server
lspconfig.lua_ls.setup({
	settings = { Lua = { hint = { enable = true }, diagnostics = { globals = { "vim", "ui" } } } },
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	init_options = { userLanguages = { typescriptreact = "javascript" } },
	handlers = {
		["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
			vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
		end,
	},
	settings = {
		includeLanguages = {
			tsx = "html",
			typescriptreact = "javascript",
			svelte = "html",
			rust = "html",
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
				recommendedVariantOrder = "warning",
			},
			classAttributes = { "class", "className", "tw" },
			experimental = {
				classRegex = {
					'twc\\("([^"]*)',
					"tw\\(\\s*['\"]([^'\"]*)",
					"twc\\(\\s*['\"]([^'\"]*)",
					"tw`([^`]*)",
					'tw="([^"]*)',
					'tw={"([^"}]*)',
					"tw\\.\\w+`([^`]*)",
					"tw\\(.*?\\)`([^`]*)",
					"tw\\.style\\(([^)]*)\\)",
					"\\bclass:\\s*'([^']*)'",
					'\\bclass:\\s*"([^"]*)"',
				},
			},
			validate = true,
		},
	},
	filetypes = {
		"css",
		"scss",
		"sass",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"rust",
		"svelte",
		"templ",
	},
})

lspconfig.tsserver.setup({
	capabilities = capabilities,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	root_dir = require("lspconfig.util").root_pattern(
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.yaml",
		".eslintrc.yml",
		".eslintrc.json",
		"eslint.config.js",
		"eslint.config.cjs",
		"eslint.config.mjs"
	),
})

lspconfig.prismals.setup({
	capabilities = capabilities,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
})

lspconfig.html.setup({
	capabilities = capabilities,
})

lspconfig.cssls.setup({
	capabilities = capabilities,
})

lspconfig.pylsp.setup({
	capabilities = capabilities,
})

lspconfig.gopls.setup({
	capabilities = capabilities,
	settings = {
		hints = {
			rangeVariableTypes = true,
			parameterNames = true,
			constantValues = true,
			assignVariableTypes = true,
			compositeLiteralFields = true,
			compositeLiteralTypes = true,
			functionTypeParameters = true,
		},
	},
})

lspconfig.htmx.setup({
	capabilities = capabilities,
	filetypes = { "html", "templ" },
})

lspconfig.theme_check.setup({
	capabilities = capabilities,
	cmd = { "/opt/homebrew/bin/theme-check" },
	root_dir = require("lspconfig.util").root_pattern("config/settings_data.json"),
})

vim.filetype.add({ extension = { templ = "templ" } })
lspconfig.templ.setup({
	capabilities = capabilities,
	filetypes = { "templ" },
})

lspconfig.gleam.setup({
	capabilities = capabilities,
})

lspconfig.elixirls.setup({
	capabilities = capabilities,
})

lspconfig.svelte.setup({
	capabilities = capabilities,
})
