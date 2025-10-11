local function should_open_fyler()
  local buftype = vim.bo.buftype
  return buftype ~= "terminal" and buftype ~= "nowrite"
end

local function toggle_fyler(opts)
  -- Check if there's already a Fyler buffer open
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })

    -- Check if this is a Fyler buffer (it should have fyler filetype or specific buffer name pattern)
    if filetype == "fyler" or buf_name:match("fyler://") then
      -- Close the Fyler window
      vim.api.nvim_win_close(win, false)
      return
    end
  end

  -- If no Fyler buffer found, open it
  require("fyler").open(opts or {})
end

return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable",
  lazy = false,
  keys = {
    {
      "-",
      function()
        if should_open_fyler() == false then
          return
        end
        toggle_fyler()
      end,
      desc = "Toggle Explorer (Fyler)",
    },
  },
  opts = {
    default_explorer = true,

    mappings = {
      ["q"] = "CloseView",
      ["<CR>"] = "Select",
      ["-"] = "GotoParent",
      ["+"] = "GotoNode",
      ["="] = "GotoCwd",
      ["#"] = "CollapseAll",
      ["<BS>"] = "CollapseNode",
    },
  },
}
