local lualine = require("lualine")

lualine.setup({
	options = {
		theme = "iceberg",
	},
	sections = {
		lualine_c = { { "filename", path = 3 } },
	},
})
