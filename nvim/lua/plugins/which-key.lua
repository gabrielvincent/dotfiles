local function replace_string(str, cursor_pos)
  local replacement = vim.fn.input("Replace '" .. str .. "' with: ")
  if replacement ~= "" then
    local command = "%s/\\<" .. str .. "\\>/" .. replacement .. "/g"

    vim.cmd(command)
    vim.fn.setpos(".", cursor_pos)
    print("Replaced all occurrences of '" .. str .. "' with '" .. replacement .. "'")
  else
    print("Replacement cancelled")
  end
end

local function replace_word_under_cursor()
  local cursor_pos = vim.fn.getcurpos()
  local word = vim.fn.expand("<cword>")
  replace_string(word, cursor_pos)
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
        "<leader>db",
        function()
          vim.cmd("DBUIToggle")
        end,
        desc = "Toggle Dadbod",
        icon = "",
      },
    })
  end,
}
