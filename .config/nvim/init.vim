call plug#begin('~/.config/nvim/plugs')

" vim plugins

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" TYPESCRIPT
" REQUIRED: Add a syntax file. YATS is the best
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" For async completion
Plug 'Shougo/deoplete.nvim'
" For Denite features
Plug 'Shougo/denite.nvim'
" Git blame
Plug 'APZelos/blamer.nvim'

Plug 'scrooloose/nerdTree'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'morhetz/gruvbox'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'jacoborus/tender.vim'
Plug 'tomasiser/vim-code-dark'


call plug#end()

syntax on

colorscheme codedark
"colorscheme dracula 
"colorscheme gruvbox 
"colorscheme tender 

" Set relative linenumbers
set relativenumber
set number

" Set ctrlp to skip files in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_complete_snippet = 1

let g:blamer_enabled = 1
let g:blamer_delay = 250

" Remaps
nmap <C-b> :NERDTreeToggle<CR> 

map <Leader> <Plug>(easymotion-prefix)

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Custom keybinds

" Indent document
map <C-M-l> magg=G'a
" Tab movement and creation
noremap <M-k> :tabn<CR>
noremap <M-j> :tabp<CR>
noremap <M-t> :tabnew<CR>

" -------------- TYPESCRIPT SPESIFIC STUFF --------------
" Show TypeScript diagnostics
noremap <M-.> :TSGetDiagnostics<CR>
" Open TSDoc
noremap <M-q> :TSDoc<CR>
" Jump to definition
noremap <M-d> :TSDef<CR>
" Rename
noremap <M-r> :TSRename<CR>
" Show references
noremap <M-f> :TSRefs<CR>
" Show error diagnostics
noremap <M-CR> :TSGetCodeFix<CR>
" -------------- End TS  --------------
