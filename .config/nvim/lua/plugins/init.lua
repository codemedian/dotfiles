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
  -- Tmux/Vim Navigation
  -- ===============================
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- ===============================
  -- Comments
  -- ===============================
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup()
    end,
  },

  -- ===============================
  -- File tree
  -- ===============================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })
    end,
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
        "rust", "lua", "vim", "python", "go", "javascript", "typescript", "html", "css"
      },
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    },
  },

  -- ===============================
  -- LSP Configuration (Neovim 0.11+ native API)
  -- ===============================
  {
    name = "lsp-config",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 100,
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Get capabilities from nvim-cmp for LSP autocompletion
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
          rust_analyzer = {
              cmd = { "rust-analyzer" },
              filetypes = { "rust" },
              root_markers = { "Cargo.toml", ".git" },
              settings = {
                  ["rust-analyzer"] = {
                      cargo = {
                          allFeatures = true,
                      },
                      check = {
                          command = "clippy",
                      },
                      procMacro = {
                          enable = true,
                      },
                  },
              },
          },
      }

      -- Configure each server
      for name, config in pairs(servers) do
        vim.lsp.config(name, {
          cmd = config.cmd,
          filetypes = config.filetypes,
          root_dir = function(filename, bufnr)
            return vim.fs.root(filename, config.root_markers)
          end,
          capabilities = capabilities,
          settings = config.settings,
        })
      end

      -- Start LSP servers via FileType autocmds
      for name, config in pairs(servers) do
        vim.api.nvim_create_autocmd("FileType", {
          pattern = config.filetypes,
          callback = function(args)
            vim.lsp.start({
              name = name,
              cmd = config.cmd,
              root_dir = vim.fs.root(args.buf, config.root_markers),
              capabilities = capabilities,
              settings = config.settings,
            })
          end,
        })
      end

      -- Set up LSP keymaps when a buffer attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local opts = { buffer = bufnr, silent = true }

          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        end,
      })
    end,
  },

  -- ===============================
  -- Completion
  -- ===============================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip"
    },
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
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
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

