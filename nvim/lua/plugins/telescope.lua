return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return {
        mappings = {
          n = {
            ["<leader>sf"] = function()
              require("telescope.builtin").lsp_document_symbols({
                ignore = { "variable", "property" },
              })
            end,
          },
        },
      }
    end,
  },
}
