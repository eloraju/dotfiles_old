call plug#begin('~/.config/nvim/plugs')

" vim plugins
Plug 'neoclide/coc.nvim', {'branch': 'release' }
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
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sinetoami/lightline-hunks'

call plug#end()

syntax on

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

let g:NERDTreeIgnore = ['^node_modules$']

" open NERDTree automatically
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080"   
    "\ }                         

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" Set ctrlp to skip files in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:neosnippet#enable_complete_snippet = 1

let g:blamer_enabled = 1
let g:blamer_delay = 250

" Remaps
nmap <C-b> :NERDTreeToggle<CR> 

map <space>m <Plug>(easymotion-prefix)w
map <C-space>m <Plug>(easymotion-prefix)b

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap jk <esc>


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
nnoremap <M-5> :source ~/.config/nvim/init.vim<CR>

" Lightline + CoC
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['filename', 'modified']],
      \  'right': [ ['lineinfo'],
      \             ['filetype'],
      \             ['lightline_hunks']]
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
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <space>j  <Plug>(coc-diagnostic-next)
" Do default action for previous item.
nnoremap <space>k  <Plug>(coc-diagnostic-prev)
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
