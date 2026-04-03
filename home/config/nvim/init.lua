-- Source ~/.vimrc
local vim_dir = vim.fn.expand("~/.vim")
vim.opt.rtp:prepend(vim_dir)

local plug_path = vim_dir .. "/autoload/plug.vim"
if vim.fn.filereadable(plug_path) == 1 then
    vim.cmd("source " .. plug_path)
end

vim.cmd("source " .. vim.fn.expand("~/.vimrc"))

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load non-plugin settings
require("config.options")
require("config.keymaps")

-- Setup lazy.nvim (Looks for plugins in lua/plugins/)
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = true },
})
