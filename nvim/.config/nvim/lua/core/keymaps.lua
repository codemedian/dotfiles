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

-- =====================
-- Config save and reload
-- =====================
map("n", "<leader>ev", "<C-w><C-v><C-l>:e $MYVIMRC<CR>", opts)
map("n", "<leader>sv", function()
  vim.cmd("source $MYVIMRC")
  print("Config reloaded!")
end, opts)

-- =====================
-- Comments (nerdcommenter-style)
-- =====================
map("n", "<leader>cc", "gcc", { remap = true })
map("v", "<leader>cc", "gc", { remap = true })
map("n", "<leader>cu", "gcc", { remap = true })
map("v", "<leader>cu", "gc", { remap = true })
map("n", "<leader>c<space>", "gcc", { remap = true })
map("v", "<leader>c<space>", "gc", { remap = true })

