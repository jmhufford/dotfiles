local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-M-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-M-q>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-M-w>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-M-f>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-M-p>", function() ui.nav_file(4) end)
