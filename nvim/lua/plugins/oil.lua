local function should_open_oil()
  local buftype = vim.bo.buftype
  return buftype ~= "terminal" and buftype ~= "nowrite"
end

return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "-",
      function()
        if should_open_oil() == false then
          return
        end
        vim.cmd.Oil()
      end,
      desc = "Open parent directory",
    },
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    delete_to_trash = true,
    use_default_keymaps = false,
    keymaps = {
      ["<leader>r"] = "actions.refresh",
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
  },
}
