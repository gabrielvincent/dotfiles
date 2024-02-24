local spectre = require("spectre")

vim.keymap.set("n", "<leader>S", function()
	spectre.toggle()
end, { desc = "Toggle Spectre" })
