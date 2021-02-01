if !exists('g:vscode')
    source ./plugins.vim
    source ./theme.vim
    source ./netwr-conf.vim
    source ./coc-conf.vim
    source ./lightline-conf.vim
    source ./floaterm-conf.vim


    " MIGRATE SHIT BELOW THIS LINE TO THEIR OWN FILES!

    " Vimspector debug adapters
    let g:vimspector_install_gadgets = [ 'debugpy' ]
    " Other Vimspector stuff


    " Filetype autocommands
    au BufNewFile,BufRead *.ts setlocal filetype=typescript
    au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

    syntax on

    let mapleader=" "
    filetype plugin on

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


    " Git blame confs
    let g:blamer_enabled = 1
    let g:blamer_delay = 250


    " Hide normal insert mode indicator
    set noshowmode


    " Mouse scrolling
    set mouse=a

endif

source ./remaps.vim
