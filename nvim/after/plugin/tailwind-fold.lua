local tailwind_fold = require("tailwind-fold")
tailwind_fold.setup({ ft = { "html", "svelte", "templ", "typescriptreact", "javascriptreact" } })

vim.keymap.set("n", "<leader>tf", ":TailwindFoldToggle<CR>", { noremap = true, silent = true })
