return {
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Show indentation scope with a line.
      require("mini.indentscope").setup()

      -- Auto pair
      require("mini.pairs").setup()

      -- Smart split and join.
      require("mini.splitjoin").setup()

      require("mini.surround").setup()

      -- Move selected text all four directions.
      require("mini.move").setup()
      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    "echasnovski/mini.starter",
    version = "*",
    event = "VimEnter",
    opts = {},
  },
}
