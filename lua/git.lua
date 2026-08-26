local gh = require('git-helper').gh

do
  vim.pack.add { { src = gh 'akinsho/git-conflict.nvim' } }
  require('git-conflict').setup {}
end
