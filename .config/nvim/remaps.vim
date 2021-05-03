" Move lines up and down
nnoremap <C-M-j> :m+<cr>
nnoremap <C-M-k> :m-2<cr>

" Tab movement and creation
noremap <M-k> :tabn<CR>
noremap <M-j> :tabp<CR>
noremap <M-t> :tabnew<CR>

" Split creation
noremap <C-s>j :split<CR><C-w>j:CtrlP<CR>
noremap <C-s>l :vsplit<CR><C-w>l:CtrlP<CR>

" Reload vimrc
nnoremap <F5> :source ~/.config/nvim/init.vim<CR>
