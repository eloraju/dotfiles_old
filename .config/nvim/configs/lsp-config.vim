nnoremap  gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap  gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap  gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap  gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap  K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap  <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap  <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap  <C-N> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

nnoremap  <C-k> <cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap  <M-F> <cmd>lua vim.lsp.buf.formatting_sync(nil, 100)
