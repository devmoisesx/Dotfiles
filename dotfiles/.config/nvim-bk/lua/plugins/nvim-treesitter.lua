-- Exemplo de como deve ficar
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- Sua lista de 'ensure_installed'
    ensure_installed = {
      "lua",
      "python",
      "json",
      "jsonc", -- Garanta que os que faltam estão aqui
      "jsx",
      "tsx",
      -- etc...
    },

    -- Suas outras opções (highlight, indent, etc.)
    highlight = {
      enable = true,
    },

    -- ADICIONE ESTA PARTE
    install = {
      prefer_git = true,
    },
  },
}
