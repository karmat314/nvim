do
  --  See `:help vim.keymap.set()`
  vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

  vim.keymap.set('x', 'p', [["_dP]], { desc = 'Paste over selection without losing yanked text' })
  vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })

  vim.keymap.set('i', '<C-c>', '<Esc>')
  vim.keymap.set('n', '<C-c>', ':nohl<CR>', { desc = 'Clear search highlighting', silent = true })

  vim.keymap.set('v', '<', '<gv', { desc = 'Unindent and keep selection' })
  vim.keymap.set('v', '>', '>gv', { desc = 'Indent and keep selection' })

  vim.keymap.set('n', '<leader>rw', function()
    local word = vim.fn.expand '<cword>'
    vim.cmd 'redraw' -- Clean command line
    vim.api.nvim_feedkeys(':%s/\\<' .. vim.fn.escape(word, '/\\') .. '\\>/' .. vim.fn.escape(word, '/\\') .. '/gc', 'n', false)
  end, { desc = 'Replace word under cursor (confirm)' })

  -- native undotree
  vim.keymap.set('n', '<leader>u', function()
    vim.cmd.packadd 'nvim.undotree'
    require('undotree').open()
  end, { desc = 'Toggle Builtin Undotree' })

  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- Disable arrow keys in normal mode
  vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end
