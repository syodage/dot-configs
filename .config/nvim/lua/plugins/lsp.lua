local cmp = require("cmp")
return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      -- Ctrl + j and Ctrl + k to navigate in auto complete window.
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      }),
    },
  },
}
