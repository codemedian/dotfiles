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

-- Open nvim-tree when starting nvim without a file
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only open if no file was specified
    if vim.fn.argc() == 0 then
      -- Delay to ensure nvim-tree is loaded
      vim.defer_fn(function()
        require("nvim-tree.api").tree.open()
      end, 10)
    end
  end,
})

