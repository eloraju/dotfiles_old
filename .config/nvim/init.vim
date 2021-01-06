if !exists('g:vscode')
    call plug#begin('~/.config/nvim/plugs')

    " vim plugins
    Plug 'APZelos/blamer.nvim'
    Plug 'airblade/vim-gitgutter'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'easymotion/vim-easymotion'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'itchyny/lightline.vim'
    Plug 'jacoborus/tender.vim'
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'lokikl/vim-ctrlp-ag'
    Plug 'mattn/emmet-vim'
    Plug 'morhetz/gruvbox'
    Plug 'neoclide/coc.nvim', {'branch': 'release' }
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'ryanoasis/vim-devicons'
    Plug 'sinetoami/lightline-hunks'
    Plug 'tomasiser/vim-code-dark'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'voldikss/vim-floaterm'

    " Debugger
    Plug 'puremourning/vimspector'

    " Languages
    Plug 'cespare/vim-toml'
    Plug 'leafgarland/typescript-vim'
    Plug 'ianks/vim-tsx'
    Plug 'jparise/vim-graphql'
    Plug 'rust-lang/rust.vim'

    " Color schemes
    Plug 'drewtempelmeyer/palenight.vim'
    Plug 'dracula/vim', {'as': 'dracula'}


    call plug#end()

    " CoC extensions
 let g:coc_global_extensions = [ 'coc-actions', 'coc-css', 'coc-emmet', 'coc-eslint', 'coc-html', 'coc-jedi', 'coc-json', 'coc-markdownlint', 'coc-prettier', 'coc-python', 'coc-react-refactor', 'coc-rls', 'coc-styled-components', 'coc-toml', 'coc-tsserver', 'coc-yaml', 'coc-yank']
    " Filetype autocommands
    au BufNewFile,BufRead *.ts setlocal filetype=typescript
    au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

    syntax on

    let mapleader=" "
    filetype plugin on

    "colorscheme codedark
    colorscheme dracula 
    "colorscheme gruvbox 
    "colorscheme tender 
    "colorscheme palenight

    if (g:colors_name == "palenight")
        set termguicolors
    endif



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


    inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
    inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
    inoremap jk <esc>


    " Fold code
    nnoremap ff za 
    set noshowmode

    " Reload vimrc
    nnoremap <F5> :source ~/.config/nvim/init.vim<CR>

    " Lightline + CoC
    function! CocCurrentFunction()
        return get(b:, 'coc_current_function', '')
    endfunction

    " Lighline filepath
    function! LightlineFilePath()
        let path = expand("%")
        let splitPath = split(path,"/")
        let size = len(splitPath)
        if size > 3
            let newArray = ["..."] + splitPath[-3:]
            return join(newArray, "/")
        endif

        return path
    endfunction

    let g:lightline = {
                \ 'colorscheme': 'one',
                \ 'active': {
                \   'left': [ ['mode', 'paste'],
                \             ['filepath', 'modified']],
                \  'right': [['lineinfo'],
                \           ['filetype'],
                \           ['lightline_hunks']]
                \ },
                \ 'component_function': {
                \   'currentfunction': 'CocCurrentFunction',
                \   'lightline_hunks': 'lightline#hunks#composer',
                \   'filepath': 'LightlineFilePath'
                \ },
                \ 'mode_map': {
                    \ 'n' : 'N',
                    \ 'i' : 'I',
                    \ 'R' : 'R',
                    \ 'v' : 'V',
                    \ 'V' : 'VL',
                    \ "\<C-v>": 'VB',
                    \ 'c' : 'C',
                    \ 's' : 'S',
                    \ 'S' : 'SL',
                    \ "\<C-s>": 'SB',
                    \ 't': 'T',
                    \ },
                \ }

    let g:lightline#hunks#only_branch = 1

    " CoC stuff
    inoremap <silent><expr> <C-space> coc#refresh()
    " Remap goto
    nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    nmap gn <Plug>(coc-diagnostic-next)
    nmap gp <Plug>(coc-diagnostic-prev)

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

    " Floaterm stuff
    let g:floaterm_keymap_new    = '<leader><F1>'
    let g:floaterm_keymap_toggle = '<leader><F2>'
    let g:floaterm_keymap_kill   = '<leader><F3>'

    " Floaterm
    let g:floaterm_width=0.8
    let g:floaterm_height=0.8
    let g:floaterm_autoclose=1
endif


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
