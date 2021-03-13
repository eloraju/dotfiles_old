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

" Navigating in autocomplete in input mode
"inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
"inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Reload vimrc
nnoremap <F5> :source ~/.config/nvim/init.vim<CR>
