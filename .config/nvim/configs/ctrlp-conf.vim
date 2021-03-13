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
