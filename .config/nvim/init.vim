call plug#begin('~/.config/nvim/plugs')

" vim plugins
Plug 'neoclide/coc.nvim', {'branch': 'release' }
" Git blame
Plug 'APZelos/blamer.nvim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'morhetz/gruvbox'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'jacoborus/tender.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sinetoami/lightline-hunks'
Plug 'lokikl/vim-ctrlp-ag'
Plug 'preservim/nerdcommenter'

call plug#end()

syntax on

let mapleader=" "
filetype plugin on

colorscheme codedark
"colorscheme dracula 
"colorscheme gruvbox 
"colorscheme tender 

" Set relative linenumbers
set relativenumber
set number

" Copied from https://gist.github.com/benawad/b768f5a5bbd92c8baabd363b7e79786f
set smarttab
set cindent
set tabstop=4
set shiftwidth=4
" always uses spaces instead of tab characters
set expandtab

" set automatic folding
set foldmethod=syntax

" Set ctrlp to skip files in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" ctrlp and ag bindings

nnoremap <c-f> :CtrlPag<cr>
vnoremap <c-f> :CtrlPagVisual<cr>
let g:ctrlp_ag_ignores = '--ignore .git
    \ --ignore "deps/*"
    \ --ignore "_build/*"
    \ --ignore "dist/*"
    \ --ignore "node_modules/*"
    \ --ignore "node/*"'
" By default ag will search from PWD
" But you may enable one of below line to use an arbitrary directory or,
" Using the magic word 'current-file-dir' to use current file base directory
" let g:ctrlp_ag_search_base = 'current-file-dir'
" let g:ctrlp_ag_search_base = 'app/controllers' " both relative and absolute path supported

let g:neosnippet#enable_complete_snippet = 1

let g:blamer_enabled = 1
let g:blamer_delay = 250


" Remaps
nmap <C-b> :NERDTreeToggle<CR> 

map <C-g> <Plug>(easymotion-prefix)w
map <M-g> <Plug>(easymotion-prefix)b

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap jk <esc>


" Fold code
nnoremap ff za 

" Move lines up and down
nnoremap <C-M-j> :m+<cr>
nnoremap <C-M-k> :m-2<cr>

" Tab movement and creation
noremap <M-k> :tabn<CR>
noremap <M-j> :tabp<CR>
noremap <M-t> :tabnew<CR>:CtrlP<CR>

" Split creation
noremap <C-s>j :split<CR><C-w>j:CtrlP<CR>
noremap <C-s>l :vsplit<CR><C-w>l:CtrlP<CR>

set noshowmode

" Reload vimrc
nnoremap <F5> :source ~/.config/nvim/init.vim<CR>

" Lightline + CoC
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
            \ 'colorscheme': 'one',
            \ 'active': {
            \   'left': [ ['mode', 'paste'],
            \             ['filename', 'modified']],
            \  'right': [['lineinfo'],
            \           ['filetype'],
            \           ['lightline_hunks']]
            \ },
            \ 'component_function': {
            \   'currentfunction': 'CocCurrentFunction',
            \   'lightline_hunks': 'lightline#hunks#composer'
            \ },
            \ }

let g:lightline#hunks#only_branch = 1

" CoC stuff
inoremap <silent><expr> <C-space> coc#refresh()
" Remap goto
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap sag :w<CR>:!git add %<CR>

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <F2> <Plug>(coc-rename)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
nnoremap <silent> <C-M-i> :call CocAction('format')<CR>

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>

nnoremap <silent> <M-f> :CocAction<CR>

" from readme
" if hidden is not set, TextEdit might fail.
" Some servers have issues with backup files, see #649 set nobackup set nowritebackup 
set hidden 
" Better display for messages
set cmdheight=2 
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Mouse scrolling
set mouse=a

" Automatically copy the saved file to the dist folder
"autocmd BufWritePost /home/juuso/hailer/front/src/pwa/* !cp -a %:h/. ~/hailer/front/dist/hailer-frontend2/
