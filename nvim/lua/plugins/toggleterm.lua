function _G.close_current_terminal()
  local term_id = require("toggleterm.terminal").get_focused_id()
  if term_id then
    vim.cmd(term_id .. "ToggleTerm")
  end
end

function _G.open_next_terminal()
  -- Get all terminals
  require("toggleterm.terminal").get_focused_id()
  local terminals = require("toggleterm.terminal").get_all()

  -- Find the highest terminal number
  local max_num = 0
  local has_closed = false
  local closed_num = 1

  for _, term in pairs(terminals) do
    if term.id > max_num then
      max_num = term.id
    end
    -- Check for any closed terminals
    if not term:is_open() then
      has_closed = true
      closed_num = term.id
      break
    end
  end

  -- If there's a closed terminal, open it
  if has_closed then
    vim.cmd(closed_num .. "ToggleTerm")
  else
    -- Otherwise, open a new terminal with next number
    vim.cmd((max_num + 1) .. "ToggleTerm")
  end
end

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-u>", [[<C-\><C-n><C-u>]], opts)
  vim.keymap.set("t", "<C-d>", [[<C-\><C-n><C-d>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

  -- Set the keymap for normal, insert and terminal modes
  vim.keymap.set({ "n", "i", "t" }, "<C-t>", function()
    open_next_terminal()
  end, { noremap = true, silent = true })

  -- Add ZZ to close the current terminal
  vim.keymap.set("t", "ZZ", close_current_terminal, opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    set_terminal_keymaps()
  end,
})

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      shade_terminals = false,
      direction = "vertical",
      size = 80,
      persist_size = true,
      -- Add your keymaps here
      terminal_mappings = true,
      -- These will only apply to toggleterm terminals
      custom_key_bindings = {
        ["<esc>"] = [[<C-\><C-n>]],
        ["<C-h>"] = [[<C-\><C-n><C-W>h]],
        ["<C-j>"] = [[<C-\><C-n><C-W>j]],
        ["<C-k>"] = [[<C-\><C-n><C-W>k]],
        ["<C-l>"] = [[<C-\><C-n><C-W>l]],
      },
    },
  },
}
