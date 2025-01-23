return {
  "rickhowe/wrapwidth",
  init = function()
    vim.g.wrapwidth_sign = "↵"
    -- vim.g.wrapwidth_number = 1
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        vim.cmd("Wrapwidth 80")
      end,
    })
  end,
}

-- asd skadjasl asld as dhas kdjsksd asdaskdj askd askda sdasdhgas das dasydg asuidg asidhiu
