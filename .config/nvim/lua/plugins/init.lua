-- ~/.config/nvim/lua/plugins/init.lua

local plugins = {

  -- ===============================
  -- Colorscheme
  -- ===============================
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- ===============================
  -- Statusline
  -- ===============================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },

  -- ===============================
  -- File tree
  -- ===============================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = true,
  },

  -- ===============================
  -- Telescope
  -- ===============================
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },

  -- ===============================
  -- Treesitter
  -- ===============================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua", "vim", "python", "go", "javascript", "typescript", "html", "css"
      },
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    },
    -- No config() needed, lazy.nvim handles setup after install
  },

  -- ===============================
  -- LSP Configuration (Neovim 0.11+ native API)
  -- ===============================
  {
    name = "lsp-config",
    dir = vim.fn.stdpath("config"),
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Use the native vim.lsp.config API for Neovim 0.11+
      local servers = {
        pyright = {
          cmd = { "pyright-langserver", "--stdio" },
          filetypes = { "python" },
          root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
        },
        ts_ls = {
          cmd = { "typescript-language-server", "--stdio" },
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          root_markers = { "package.json", "tsconfig.json", ".git" },
        },
        gopls = {
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_markers = { "go.mod", "go.work", ".git" },
        },
      }

      -- Configure each server
      for name, config in pairs(servers) do
        vim.lsp.config(name, {
          cmd = config.cmd,
          filetypes = config.filetypes,
          root_dir = function(filename, bufnr)
            return vim.fs.root(bufnr, config.root_markers)
          end,
        })
      end

      -- Enable LSP servers for their filetypes
      for name, config in pairs(servers) do
        vim.lsp.enable(name)
      end
    end,
  },

  -- ===============================
  -- Completion
  -- ===============================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
        }),
      })
    end,
  },

}

-- ===============================
-- lazy.nvim options
-- ===============================
local opts = {
  install = {
    missing = true, -- auto-install missing plugins on first run
  },
}

require("lazy").setup(plugins, opts)

