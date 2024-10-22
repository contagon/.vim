require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- Remap file search
-- nomap("n", "<leader>ff")
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", {desc = "VSCode file search"})

-- Remap file explorer
nomap("n", "<C-n>")
map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", {desc = "VSCode toggle window"})
