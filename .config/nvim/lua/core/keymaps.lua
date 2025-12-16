local map = vim.keymap.set
local opts = { silent = true }

-- Command shortcut
map("n", ";", ":")

-- Fast scrolling
map("n", "<C-e>", "2<C-e>")
map("n", "<C-y>", "2<C-y>")

-- Insert escape
map("i", "jk", "<ESC>")

-- Clear search
map("n", "<leader>/", ":nohlsearch<CR>", opts)

-- Toggle list chars
map("n", "<leader>i", ":set list!<CR>", opts)

-- Strip whitespace
map("n", "<leader>W", ":%s/\\s\\+$//e<CR>:let @/=''<CR>", opts)

-- Paste toggle
vim.keymap.set("n", "<F2>", function()
    vim.opt.paste = not vim.opt.paste:get()
    print("paste = " .. tostring(vim.opt.paste:get()))
end, { silent = true })

-- =====================
-- Telescope
-- =====================
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

-- =====================
-- File tree
-- =====================
map("n", "<leader>n", "<cmd>NvimTreeToggle<CR>")

