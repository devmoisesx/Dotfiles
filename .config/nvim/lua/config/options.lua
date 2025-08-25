local o = vim.opt

-- Habilitar Word Wrap
o.wrap = true
o.linebreak = true -- Quebra as linhas de forma inteligente

-- Definir o cursor como linha vertical
-- vim.cmd([[ set guicursor= ]])
-- o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Mostrar números de linha absolutos
o.number = true

-- Mostrar números relativos ao cursor
o.relativenumber = false

-- Auto-identação
o.smartindent = true -- Auto-indenta baseado no contexto
o.autoindent = true -- Continuar a indentação da linha anterior
o.tabstop = 4 -- Quantidade de espaços para um "tab"
o.shiftwidth = 4 -- Tamanho da indentação ao usar o `>` ou `<`
o.expandtab = true -- Usar espaços ao invés de tabs

-- Ativar completions automáticas
o.completeopt = { "menuone", "noselect" }

-- o.spell = true
o.spelllang = { "pt_br" }
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.title = true
