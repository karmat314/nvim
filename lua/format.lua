local gh = require('git-helper').gh
do
  -- [[ Formatting ]]
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = true,
    formatters_by_ft = {
      ruby = { 'rubocop' },
    },
    format_on_save = {
      timeout_ms = 5000,
      lsp_format = 'fallback',
    },
    formatters = {
      rubocop = {
        command = 'bundle',
        prepend_args = { 'exec', 'rubocop' },
      },
    },
  }
  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
end
