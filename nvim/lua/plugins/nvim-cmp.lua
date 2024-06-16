return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-.>"] = cmp.mapping.complete(),
    })

    table.insert(opts.sources, 1, {
      name = "codeium",
      group_index = 1,
      priority = 1,
    })
  end,
}
