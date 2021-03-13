call plug#begin('~/.config/nvim/plugs')

" ????? vim plugins
Plug 'APZelos/blamer.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'lokikl/vim-ctrlp-ag'
Plug 'mattn/emmet-vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release' }
Plug 'ryanoasis/vim-devicons'
Plug 'sinetoami/lightline-hunks'
Plug 'tpope/vim-fugitive'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }

" Not sure if i wanna use these or not
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Debugger
Plug 'puremourning/vimspector'

" Languages
Plug 'cespare/vim-toml'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'jparise/vim-graphql'
Plug 'rust-lang/rust.vim'
Plug 'peitalin/vim-jsx-typescript'

" Better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" For native LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" Markdown stuff
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dhruvasagar/vim-table-mode'

" Motions
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'

" Color schemes
Plug 'tomasiser/vim-code-dark'
Plug 'jacoborus/tender.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'morhetz/gruvbox'


call plug#end()
