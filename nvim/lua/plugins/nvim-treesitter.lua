return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
          ["ak"] = "@comment.outer",
        },
      },
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>sn"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>sp"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
      },
    }
  end,
}
