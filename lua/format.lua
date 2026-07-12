local gh = require('git-helper').gh

do
  -- [[ Formatting ]]
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- You can specify filetypes to autoformat on save here:
      local enabled_filetypes = {
        ruby = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return {
          timeout_ms = 3000, -- Fix 1: Raised from 500ms to 3000ms so RuboCop has time to process
          lsp_format = 'never', -- Fix 2: Never fall back to crashing ruby_lsp version mismatches
        }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      ruby = { 'rubocop' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
end
