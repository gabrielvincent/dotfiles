require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"javascript",
		"typescript",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	-- Configure autoclose of HTML and JSX tags
	autoclose = { enable = true },

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ap"] = "@parameter.outer",
				["ip"] = "@parameter.inner",
				["ak"] = "@comment.outer",
			},
			-- selection_modes = {
			-- 	["@parameter.outer"] = "v", -- charwise
			-- 	["@function.outer"] = { "v", "V", "c", "d" }, -- charwise
			-- 	["@class.outer"] = "<c-v>", -- blockwise
			-- },
		},
	},
})

local function noisx(a, b, c)
	print("hello")
end
