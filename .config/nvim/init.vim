if !exists('g:vscode')
  source ~/.config/nvim/plugins.vim
  source ~/.config/nvim/remaps.vim
  source ~/.config/nvim/theme.vim

  " Source everything in config folder
  for f in split(glob('~/.config/nvim/configs/*.vim'),'\n')
    exec 'source' f
  endfor

  " Load lsp configs
  luafile ~/.config/nvim/configs/lsp-confs.lua

  " Leader char
  let mapleader="-"

  " Filetype autocommands
  au BufNewFile,BufRead *.ts setlocal filetype=typescript
  au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

  syntax on

  filetype plugin on

  " Set relative linenumbers
  set relativenumber
  set number

  " Copied from https://gist.github.com/benawad/b768f5a5bbd92c8baabd363b7e79786f
  set smarttab
  set cindent
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  " always uses spaces instead of tab characters
  set expandtab

  " set automatic folding
  set foldmethod=syntax

  " Hide normal insert mode indicator
  set noshowmode

  " Mouse scrolling
  set mouse=a

endif

source ~/.config/nvim/remaps.vim
