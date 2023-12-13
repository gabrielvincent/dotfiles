local illuminate = require("illuminate")

illuminate.configure({
    providers = {'lsp', 'treesitter'},
    delay = 0,
    min_count_to_highlight = 2
})

vim.keymap.set("n", "<C-n>",
               "<cmd>lua require('illuminate').goto_next_reference{wrap=true}<CR>",
               {noremap = true, silent = true})

-- local reference = require("illuminate.reference")
-- local engine = require("illuminate.engine")
-- local stackmap = require("stackmap")
--
-- illuminate.configure({
--     providers = {'lsp', 'treesitter'},
--     delay = 0,
--     min_count_to_highlight = 2
-- })
--
-- local is_printing_references = false
--
-- local function on_cursor_move()
--     local bufnr = vim.api.nvim_get_current_buf()
--     engine.refresh_references(bufnr)
--     local number_of_refs = #reference.buf_get_references(bufnr)
--
--     if number_of_refs <= 1 then
--         if stackmap._stack["illuminate"] ~= nil and
--             stackmap._stack["illuminate"]["n"] ~= nil then
--             stackmap.pop("illuminate", "n")
--         end
--         if is_printing_references then
--             print(" ") --- clear the line
--             is_printing_references = false
--         end
--         return
--     end
--
--     print(string.format("Highlighted items: %d", number_of_refs))
--     is_printing_references = true
--     stackmap.push("illuminate", "n", {
--         ["<C-n>"] = illuminate.goto_next_reference,
--         ["<C-p>"] = illuminate.goto_prev_reference
--     })
-- end
--
-- vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"},
--                             {callback = on_cursor_move})
--
