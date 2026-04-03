-- Source ~/.vimrc
vim.cmd("source " .. vim.fn.expand("~/.vimrc"))

-- Load non-plugin settings
require("config.options")
require("config.keymaps")
