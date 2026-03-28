-- Determine initial theme state
local state_file = vim.fn.expand("~/.config/macos-theme-sync/theme_state")
local f = io.open(state_file, "r")
local mode = ""
if f then
  mode = f:read("*a"):gsub("%s+", "")
  f:close()
else
  -- Fallback to defaults read if state file doesn't exist yet
  mode = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null"):gsub("%s+", "")
end
vim.opt.background = (mode:match("Dark") and "dark" or "light")

local opt = vim.opt

-- Quiet the UI
opt.shortmess:append("IsWcCF") -- I: no intro, s: no search count, W: no write messages, c: no completion messages, C: no scan messages, F: no hit-enter for messages
opt.cmdheight = 1 -- Ensure there is enough space for messages

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

