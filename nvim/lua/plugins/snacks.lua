return {
  "snacks.nvim",
  opts = function(_, opts)
    opts.dashboard = { enabled = true }
    opts.scroll = { enabled = false }
    opts.explorer = { enabled = false }
    opts.picker = { enabled = false }
  end,
  keys = {
    { "<leader>fe", false },
    { "<leader>fE", false },
    { "<leader>E", false },
    { "<leader>e", false },
  },
}
