local o = vim.opt

-- Habilitar Word Wrap
o.wrap = true
o.linebreak = true -- Quebra as linhas de forma inteligente

-- Definir o cursor como linha vertical
o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20,sm:block"

-- Mostrar números de linha absolutos
o.number = true

-- Mostrar números relativos ao cursor
o.relativenumber = true

-- Auto-identação
o.smartindent = true -- Auto-indenta baseado no contexto
o.autoindent = true -- Continuar a indentação da linha anterior
o.tabstop = 4 -- Quantidade de espaços para um "tab"
o.shiftwidth = 4 -- Tamanho da indentação ao usar o `>` ou `<`
o.expandtab = true -- Usar espaços ao invés de tabs

-- Ativar completions automáticas
o.completeopt = { "menuone", "noselect" }

-- ~/.config/nvim/lua/plugins/neotree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      -- Esta é a linha principal: desabilita o filtro de arquivos ocultos
      filtered_items = {
        hide_dotfiles = false,
      },
    },
  },
}
