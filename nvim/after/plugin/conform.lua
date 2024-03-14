local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "eslint_d" },
		javascriptreact = { "prettierd", "eslint_d" },
		typescript = { "prettierd", "eslint_d" },
		typescriptreact = { "prettierd", "eslint_d" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		yaml = { "prettierd" },
		html = { "prettierd" },
		css = { "prettierd" },
		prisma = { "prettierd" },
		python = { "black" },
		go = { "golines" },
		templ = { "templ" },
		gotmpl = { "gopls" },
		mod = { "golines" },
		liquid = { "prettierd" },
		gleam = { "gleam" },
	},
})

conform.formatters.golines = {
	command = "golines",
	args = { "-m", "80" },
}

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({
		async = false,
		lsp_fallback = true,
		range = range,
	})
end, { range = true })

vim.keymap.set("n", "<leader>f", function()
	conform.format()
end)

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
