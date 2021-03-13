-- npm i -g bash-language-server vscode-css-languageserver-bin dockerfile-language-server-nodejs graphql-language-service-cli vscode-html-languageserver-bin typescript typescript-language-server vscode-json-languageserver pyright vim-language-server yaml-language-server

-- npm i -g bash-language-server
require'lspconfig'.bashls.setup{}

-- npm install -g vscode-css-languageserver-bin
require'lspconfig'.cssls.setup{}

-- npm install -g dockerfile-language-server-nodejs
require'lspconfig'.dockerls.setup{}

-- npm install -g graphql-language-service-cli
require'lspconfig'.graphql.setup{}

-- npm install -g vscode-html-languageserver-bin
require'lspconfig'.html.setup{}

-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{}

-- npm install -g vscode-json-languageserver
require'lspconfig'.jsonls.setup {}

-- npm i -g pyright
require'lspconfig'.pyright.setup{}

-- npm install -g vim-language-server
require'lspconfig'.vimls.setup{}

-- npm install -g yaml-language-server
require'lspconfig'.yamlls.setup{}
