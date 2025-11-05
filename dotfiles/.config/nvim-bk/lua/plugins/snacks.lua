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
          cwd = vim.fn.getcwd(),
          git_status = true,
        },
      },
    },
    keys = {
      {
        -- O atalho que você quer usar.
        -- <leader>so = "Snacks Open (local)"
        "<leader>e",
        -- A função que será executada
        function()
          -- Muda o diretório para o do arquivo atual
          vim.cmd(vim.fn.getcwd())
          -- Abre o Snacks
          require("snacks").open()
        end,
        -- Descrição que aparecerá no WhichKey
        desc = "Open Snacks (Local Dir)",
      },
    },
  },
}
