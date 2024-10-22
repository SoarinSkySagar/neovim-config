call plug#begin('~/.vim/plugged')

" GitHub CoPilot
Plug 'github/copilot.vim'

" Treesitter for better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" File Explorer - NvimTree
Plug 'kyazdani42/nvim-tree.lua'

" Fuzzy Finder - Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" Git Integration - Fugitive
Plug 'tpope/vim-fugitive'

" Prettier integration via null-ls
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-lua/plenary.nvim'

" Bracket Autocompletion - Auto pairs
Plug 'windwp/nvim-autopairs'

" Status Line - Lualine
Plug 'nvim-lualine/lualine.nvim'

" Color Scheme - Gruvbox
Plug 'morhetz/gruvbox'

" Commenting - Vim Commentary
Plug 'tpope/vim-commentary'

" Autocompletion Engine
Plug 'hrsh7th/nvim-cmp'

" LSP Completion Source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Tailwind CSS suggestions
Plug 'roobert/tailwindcss-colorizer-cmp.nvim'

" npm package suggestions
Plug 'David-Kunz/cmp-npm', { 'do': 'npm install' }

" Snippet Support
Plug 'L3MON4D3/LuaSnip'

" LSP Config for Language Servers
Plug 'neovim/nvim-lspconfig'

" Mason for installing and managing LSPs, Linters, and Formatters
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Rust Tools for better Rust integration
Plug 'simrat39/rust-tools.nvim'

call plug#end()

" Enable Treesitter for multiple languages
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "python", "rust", "lua", "typescript", "go", "html", "css", "cairo" },  -- Add more languages here
    highlight = { enable = true },
  }
EOF

" Setup null-ls for Prettier
lua <<EOF
local null_ls = require("null-ls")
local sources = {
  null_ls.builtins.formatting.prettier.with({
      command = "prettierd",  -- Use Prettier from within null-ls
  }),
}
null_ls.setup({ sources = sources })
EOF

" Setup nvim-tree for file explorer
lua <<EOF
require'nvim-tree'.setup {}
EOF

" Setup telescope for fuzzy finding
lua <<EOF
require'telescope'.setup {}
EOF

" Setup lualine with gruvbox theme
lua <<EOF
require('lualine').setup {
  options = { theme = 'gruvbox' }
}
EOF

" Setup nvim-cmp for autocompletion
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- LSP suggestions
    { name = 'luasnip' },   -- Snippet suggestions
    { name = 'npm', keyword_length = 4 },  -- npm package suggestions
  }),
  formatting = {
    format = require('tailwindcss-colorizer-cmp').formatter,
  }
})
EOF

" Setup Mason for managing LSP servers
lua <<EOF
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "rust_analyzer", "ts_ls", "lua_ls", "pyright", "gopls" } -- Add more languages here
})

-- Setup LSP servers through nvim-lspconfig
local lspconfig = require("lspconfig")

-- Enable LSP for installed languages
local servers = { "rust_analyzer", "ts_ls", "lua_ls", "pyright", "gopls" }
for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end,
  }
end
EOF

" Rust Analyzer for Rust LSP
lua <<EOF
require('rust-tools').setup({
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<C-space>", require('rust-tools').hover_actions.hover_actions, { buffer = bufnr })
    end,
  }
})
EOF

" Syntax highlighting and colorscheme
syntax enable
colorscheme gruvbox

" Set line numbers
set number

