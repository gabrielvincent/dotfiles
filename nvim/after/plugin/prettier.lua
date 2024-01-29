local prettier = require("prettier")

prettier.setup({
    bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
    filetypes = {
        "css", "graphql", "html", "json", "less", "markdown", "scss", "yaml",
        "liquid"
    }
})
