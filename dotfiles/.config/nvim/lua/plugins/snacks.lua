return {
  "folke/snacks.nvim",
  opts = {
    -- show hidden files in snacks.explorer
    picker = {
      sources = {
        explorer = {
          -- show hidden files like .env
          hidden = true,
          -- show files ignored by git like node_modules
          ignored = true,
        },
      },
    },
  },
}
