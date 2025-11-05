-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.options")

vim.lsp.enable("pyright")
vim.lsp.enable("omnisharp")
