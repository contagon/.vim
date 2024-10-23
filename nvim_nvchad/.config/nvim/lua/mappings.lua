require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- Remap file search
nomap("n", "<leader>ff")
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", {desc = "VSCode file search"})

-- Remap grep all files
nomap("n", "<leader>x")
map("n", "<C-w>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Remap file explorer
-- nomap("n", "<C-n>")
map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", {desc = "VSCode toggle window"})
