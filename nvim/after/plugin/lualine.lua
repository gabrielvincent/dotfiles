local lualine = require("lualine")

local function tablelength(T)
	local count = 0
	for _ in pairs(T) do
		count = count + 1
	end
	return count
end

local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local function get_root_dir()
	local cwd = vim.fn.getcwd()
	local path_items = split(cwd, "/")
	return path_items[tablelength(path_items)]
end

lualine.setup({
	options = {
		theme = "iceberg",
	},
	sections = {
		lualine_b = { { get_root_dir } },
		lualine_c = { { "filename", path = 1 } },
	},
})
