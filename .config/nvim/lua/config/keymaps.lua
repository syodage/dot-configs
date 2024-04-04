-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Delete a word backward
keymap.set("n", "<tab>", ":tabnext<CR>", opts)
keymap.set("n", "<s-tab>", ":tabprev<CR>", opts)

-- Split windows
-- keymap.set("n", "<leader>ss", ":split<CR>", opts)
-- keymap.set("n", "<leader>sv", ":vsplit<CR>", opts)

-- Move windows
-- keymap.set("n", "<leader>sh", "<C-w>h")
-- keymap.set("n", "<leader>sk", "<C-w>k")
-- keymap.set("n", "<leader>sj", "<C-w>j")
-- keymap.set("n", "<leader>sl", "<C-w>l")

-- Resize windows
-- keymap.set("n", "<C-w><left>", "<C-w><")
-- keymap.set("n", "<C-w><right>", "<C-w>>")
-- keymap.set("n", "<C-w><up>", "<C-w>+")
-- keymap.set("n", "<C-w><down>", "<C-w>-")
--
-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end)
