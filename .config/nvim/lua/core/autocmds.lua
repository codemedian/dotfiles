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

