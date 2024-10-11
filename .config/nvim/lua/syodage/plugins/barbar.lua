return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released

  config = function(opt)
    require("barbar").setup(opt)

    local kopts = { noremap = true, silent = true }
    local keymap = function(mode, keys, func, desc)
      kopts.desc = desc or ""
      vim.keymap.set(mode, keys, func, kopts)
    end

    keymap("n", "<leader>bc", "<CMD>BufferClose<CR>", "[B]uffer [C]lose.")
    keymap("n", "<leader>bC", "<CMD>BufferCloseAllButCurrent<CR>", "Close buffers all but current.")
    keymap("n", "<leader>bl", "<CMD>BufferCloseBuffersLeft<CR>", "Close all buffers to the left.")
    keymap("n", "<leader>br", "<CMD>BufferCloseBuffersRight<CR>", "Close all buffers to the left.")
  end,
}
