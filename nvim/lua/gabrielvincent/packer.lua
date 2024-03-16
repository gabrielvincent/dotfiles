-- This file can be loaded by calling `lua require('plugins')` from your init.vimpackep-z
vim.keymap.set("n", "<C-h>", function()
	ui.nav_file(1)
end)

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		-- or                            , branch = "0.1.x",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	})
	use({ "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("nvim-treesitter/nvim-treesitter")
	use("mbbill/undotree")
	use("theprimeagen/vim-be-good")
	use("tpope/vim-fugitive")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use({
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!:).
		run = "make install_jsregexp",
	})
	use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" })
	use("nvimdev/lspsaga.nvim")
	use("neovim/nvim-lspconfig")
	use("m4xshen/autoclose.nvim")
	use("romainl/vim-cool")
	use("Exafunction/codeium.vim")
	use("theprimeagen/harpoon")
	use("tjdevries/stackmap.nvim")
	use("nvim-treesitter/nvim-treesitter-context")
	use("windwp/nvim-ts-autotag")
	use("lewis6991/gitsigns.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
			"ryanoasis/vim-devicons",
			opt = true,
		},
	})
	use("numtoStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
	use("tpope/vim-surround")
	use("RRethy/vim-illuminate")
	use("f-person/auto-dark-mode.nvim")
	use("stevearc/oil.nvim")
	use("stevearc/conform.nvim")
	use("echasnovski/mini.nvim")
	use("nvim-pack/nvim-spectre")
	use("folke/todo-comments.nvim")
	use("RRethy/base16-nvim")
	--
	-- Local plugins
	-- use("~/Code/nvim/plugins/slate.nvim")
end)
