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

call plug#end()

"Enable Treesitter
lua <<EOF
	require'nvim-treesitter.configs'.setup {
		highlight = { enable = true },
	}
EOF

lua << EOF
local null_ls = require("null-ls")
local sources = {
    null_ls.builtins.formatting.prettier.with({
        command = "prettierd",  -- Use Prettier from within null-ls
    }),
}
null_ls.setup({ sources = sources })
EOF

lua << EOF
require'nvim-tree'.setup {}
EOF

lua << EOF
require'telescope'.setup {}
EOF

lua << EOF
require('lualine').setup {
  options = { theme = 'gruvbox' }
}
EOF

syntax enable
colorscheme gruvbox

set number
