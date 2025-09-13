-- CodeCompanion.nvim configuration with Claude Code integration
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    default_adapter = "claude_code",
    strategies = {
      inline = {
        adapter = "claude_code",
      },
      chat = {
        adapter = "claude_code",
      },
      agent = {
        adapter = "claude_code",
      },
    },
    adapters = {
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = vim.env.CLAUDE_CODE_OAUTH_TOKEN,
            },
          })
        end,
      },
    },
  },
}
