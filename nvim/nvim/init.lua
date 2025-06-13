
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true

vim.opt.incsearch  = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true

vim.opt.clipboard = 'unnamedplus'

vim.keymap.set('i', 'jk', '<Esc>')

vim.opt.wrap = false           -- Do not wrap lines
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true       -- Expand tabs to spaces
vim.opt.smarttab = false       -- Disable smart tab
vim.opt.formatoptions:append("n") -- Support for numbered/bullet lists
vim.opt.textwidth = 72         -- Wrap at 72 chars by default
vim.opt.colorcolumn = "72"     -- Highlight column 72
vim.opt.virtualedit = "block"  -- Allow virtual edit in visual block 

vim.cmd('autocmd BufRead,BufNewFile *.ci set filetype=seaeye')

-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0

-- vim.cmd [[filetype plugin indent on]]

-- Auto-install packer if not exists
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neoclide/coc.nvim'      -- Intellisense engine
  use 'scrooloose/nerdtree'    -- File explorer
  use 'junegunn/fzf'           -- Fuzzy finder
  use 'tpope/vim-fugitive'     -- Git integration
  use 'morhetz/gruvbox'        -- Colorscheme
end)

