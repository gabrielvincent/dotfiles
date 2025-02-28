-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Set up underline color for diagnostic
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*", -- Apply to all colorschemes
  callback = function()
    vim.cmd([[
            hi DiagnosticUnderlineError guisp=#FF0000 gui=undercurl
            hi DiagnosticUnderlineWarn guisp=#df8e1d gui=undercurl
            hi DiagnosticUnderlineInfo guisp=#ADD8E6 gui=undercurl
            hi DiagnosticUnderlineHint guisp=#90EE90 gui=undercurl
        ]])
  end,
})

-- Trigger the autocmd manually once to apply the settings initially
vim.cmd("doautocmd ColorScheme")

-- Claude terminal command setup
-- Using ID 100 which is well outside the normal terminal range (normal terminals start at 1)
local claude_term_id = 100

-- Register the terminal once at startup
local create_claude_terminal = function()
  local Terminal = require("toggleterm.terminal").Terminal

  -- Create a dedicated Claude terminal
  local claude = Terminal:new({
    cmd = "claude",
    id = claude_term_id,
    direction = "vertical",
    size = 80,
    persist_size = true,
    close_on_exit = false, -- Keep it around when the process exits
    shade_terminals = false,
    hidden = true, -- Start hidden and only show with our custom command
    on_open = function()
      vim.cmd("startinsert!")
    end,
  })

  return claude
end

-- Store the Claude terminal instance globally to avoid recreating it
_G.claude_terminal = _G.claude_terminal or create_claude_terminal()

-- Create the :Claude command
vim.api.nvim_create_user_command("Claude", function()
  _G.claude_terminal:toggle()
end, {})

-- Enable file name in Wezterm tab
if vim.env.WEZTERM_EXECUTABLE then
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function(event)
      local title = "vim"
      if event.file ~= "" then
        local cwd = vim.fn.getcwd()
        title = cwd:match("([^/]+)$")
      end

      vim.fn.system({ "wezterm", "cli", "set-tab-title", title })
    end,
  })
  vim.api.nvim_create_autocmd({ "VimLeave" }, {
    callback = function()
      -- Setting title to empty string causes wezterm to revert to its
      -- default behavior of setting the tab title automatically
      vim.fn.system({ "wezterm", "cli", "set-tab-title", "" })
    end,
  })
end

-- Set max text width for markdown and text files.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.bo.textwidth = 80
  end,
})

-- Hide overflowing terminal colorscheme
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then
      return
    end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})
vim.api.nvim_create_autocmd("UILeave", {
  callback = function()
    io.write("\027]111\027\\")
  end,
})

-- Start insert mode when a terminal buffer is opened
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})
