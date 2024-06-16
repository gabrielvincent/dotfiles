vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

return {
  "stevearc/oil.nvim",
  opts = {
    ["<C-s>"] = nil,
    ["<C-h>"] = nil,
    ["<C-t>"] = nil,
    ["<C-p>"] = nil,
    ["<C-c>"] = nil,
    ["<C-l>"] = nil,
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
