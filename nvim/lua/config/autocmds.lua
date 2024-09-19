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

-- Enable file name in Wezterm tab
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

-- Set max text width for markdown and text files.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.bo.textwidth = 80
  end,
})

-- Disable syntax for large files and reset on leaving
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = "*",
--   callback = function()
--     local file_size = vim.fn.getfsize(vim.fn.expand("%"))
--     if file_size > 1024 * 1024 then -- 1MB
--       vim.cmd("syntax clear")
--       vim.cmd("set syntax=")
--       vim.opt_local.syntax = ""
--       vim.opt_local.filetype = ""
--       vim.cmd("TSDisable highlight")
--       vim.cmd("TSDisable textobjects")
--       print("Large file detected. Syntax highlighting disabled.")
--
--       -- Create autocmd to reset settings when leaving this buffer
--       vim.api.nvim_create_autocmd("BufLeave", {
--         buffer = 0, -- 0 means current buffer
--         callback = function()
--           vim.cmd("syntax on")
--           vim.cmd("set syntax&")
--           vim.opt_local.syntax = vim.opt.syntax
--           vim.cmd("filetype detect")
--           vim.cmd("TSEnable highlight")
--           vim.cmd("TSEnable textobjects")
--           print("Syntax highlighting re-enabled.")
--         end,
--         once = true, -- Run only once
--       })
--     end
--   end,
-- })

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
