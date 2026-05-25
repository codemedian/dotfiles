-- Save on focus lost
vim.api.nvim_create_autocmd("FocusLost", {
  command = "wa",
})

-- TeX wrapping
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tex",
  command = "set wrap linebreak nolist textwidth=0 wrapmargin=0",
})

-- Gradle
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gradle",
  command = "setfiletype groovy",
})

-- Open nvim-tree when starting nvim with a directory or no file
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local path = vim.fn.argv(0) -- check the first argument
    local is_directory = path ~= "" and vim.fn.isdirectory(path) == 1

    if vim.fn.argc() == 0 or is_directory then
      -- Delay to ensure nvim-tree is loaded
      vim.defer_fn(function()
        require("nvim-tree.api").tree.open()
      end, 10)
    end
  end,
})

local state_file = vim.fn.expand("~/.config/macos-theme-sync/theme_state")

local function sync_theme()
  vim.defer_fn(function()
    local f = io.open(state_file, "r")
    if f then
      local mode = f:read("*a"):gsub("%s+", "")
      f:close()
      local new_bg = mode:match("Dark") and "dark" or "light"
      if vim.o.background ~= new_bg then
        vim.schedule(function()
          vim.opt.background = new_bg
          vim.cmd("silent! colorscheme gruvbox")
          -- Force a redraw so the command line clears
          vim.cmd("redraw")
        end)
      end
    end
  end, 50)
end

-- Watch for system theme changes via a state file
local w = vim.uv.new_fs_event()
if w then
  local function on_change(err, filename, events)
    if err then return end
    sync_theme()
  end

  local state_dir = vim.fn.fnamemodify(state_file, ":h")
  w:start(state_dir, {}, on_change)
end

-- Also listen for SIGUSR1 signal for instant updates
local signal = vim.uv.new_signal()
if signal then
  vim.uv.signal_start(signal, "sigusr1", function()
    sync_theme()
  end)
end

