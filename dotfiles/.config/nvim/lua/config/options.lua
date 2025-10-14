-- call plug#begin(s:plug_dir)
-- Plug 'neovim/nvim-lspconfig'
-- Plug 'hrsh7th/cmp-nvim-lsp'
-- Plug 'hrsh7th/cmp-buffer'
-- Plug 'hrsh7th/cmp-path'
-- Plug 'hrsh7th/cmp-cmdline'
-- Plug 'hrsh7th/nvim-cmp'

local o = vim.opt

-- Habilitar Word Wrap
o.wrap = true
o.linebreak = true -- Quebra as linhas de forma inteligente

-- Definir o cursor como linha vertical
-- vim.cmd([[ set guicursor= ]])
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

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

-- vim.lsp.inline_completion.enable(true)

-- o.autocomplete = true
--
-- vim.cmd("set completeopt+=noselect")
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client ~= nil and client:supports_method("textDocument/completion") then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })
--
-- vim.g.lazyvim_cmp = "nvim-cmp"
