local opt = vim.opt

-- Encoding
opt.encoding = "utf-8"

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.signcolumn = "yes"
opt.termguicolors = true

-- Tabs / indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true
opt.ignorecase = true

-- Undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo//"
opt.undolevels = 1000

-- History / buffers
opt.history = 1000
opt.hidden = true

-- Files
opt.swapfile = false
opt.backup = false

-- Wildmenu (kept minimal – Telescope handles most)
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- List chars
opt.list = true
opt.listchars = {
  tab = "▸ ",
  trail = "·",
  nbsp = "·",
}

-- Misc
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.spelllang = "en_gb"
opt.scrolloff = 5

