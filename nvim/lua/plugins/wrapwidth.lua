return {
  "rickhowe/wrapwidth",
  init = function()
    vim.g.wrapwidth_sign = "↵"
    -- vim.g.wrapwidth_number = 1
    vim.api.nvim_create_augroup("MarkdownWrap", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufLeave" }, {
      group = "MarkdownWrap",
      pattern = "*.md",
      callback = function(event)
        if event.event == "BufEnter" then
          vim.cmd("Wrapwidth 80")
          vim.opt.wrap = true
        else
          vim.opt.wrap = false
        end
      end,
    })
  end,
}
