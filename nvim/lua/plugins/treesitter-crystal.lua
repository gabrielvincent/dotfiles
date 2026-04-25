local function register_crystal_parser()
  require("nvim-treesitter.parsers").crystal = {
    install_info = {
      url = "https://github.com/crystal-lang-tools/tree-sitter-crystal",
      generate = false,
      generate_from_json = false,
      queries = "queries/nvim",
    },
  }
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      register_crystal_parser()

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = register_crystal_parser,
      })

      vim.treesitter.language.register("crystal", { "cr" })
    end,
  },
}
