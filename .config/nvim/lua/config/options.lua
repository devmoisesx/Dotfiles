-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local o = vim.opt

-- Cursor em formato de linha
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Word wrap
o.wrap = true

o.number = true -- Print the line number in front of each line
o.relativenumber = false -- Show the line number relative to the line with the cursor in front of each line.
o.syntax = "on" -- When this option is set, the syntax with this name is loaded.
o.autoindent = true -- Copy indent from current line when starting a new line.
o.cursorline = true -- Highlight the screen line of the cursor with CursorLine.
o.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
o.encoding = "UTF-8" -- Sets the character encoding used inside Vim.
o.mouse = "a" -- Enable the use of the mouse. "a" you can use on all modes
o.showcmd = true -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
o.showmatch = true -- When a bracket is inserted, briefly jump to the matching one.
o.termguicolors = true
