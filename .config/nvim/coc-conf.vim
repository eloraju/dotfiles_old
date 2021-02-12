" Extensions
let g:coc_global_extensions = [ 'coc-actions', 'coc-css', 'coc-emmet', 'coc-eslint', 'coc-html', 'coc-jedi', 'coc-json', 'coc-markdownlint', 'coc-prettier', 'coc-python', 'coc-react-refactor', 'coc-rls', 'coc-styled-components', 'coc-toml', 'coc-tsserver', 'coc-yaml', 'coc-yank', 'coc-fzf-preview', 'coc-json']

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

