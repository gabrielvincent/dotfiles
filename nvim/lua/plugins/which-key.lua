local function replace_word_under_cursor()
  local cursor_pos = vim.fn.getcurpos()
  local word = vim.fn.expand("<cword>")

  local replacement = vim.fn.input("Replace '" .. word .. "' with: ")
  if replacement ~= "" then
    local command = "%s/\\<" .. word .. "\\>/" .. replacement .. "/g"

    vim.cmd(command)
    vim.fn.setpos(".", cursor_pos)
    print("Replaced all occurrences of '" .. word .. "' with '" .. replacement .. "'")
  else
    print("Replacement cancelled")
  end
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.preset = "modern"
    local wk = require("which-key")
    wk.add({
      {
        "<leader>sf",
        function()
          require("telescope.builtin").lsp_document_symbols({
            ignore_symbols = { "variable", "property", "string", "array" },
          })
        end,
        desc = "Goto Symbol (functions)",
        icon = "",
      },
      {
        "<leader>sr",
        function()
          replace_word_under_cursor()
        end,
        desc = "Replace word under cursor",
        icon = "",
      },
      {
        "<leader>sR",
        require("spectre").toggle,
        desc = "Replace in workspace with Spectre",
        icon = "",
      },
    })
  end,
}
