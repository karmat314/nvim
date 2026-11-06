do
  vim.loader.enable()

  vim.g.netrw_banner = 0

  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  vim.g.have_nerd_font = true

  vim.o.number = true
  vim.o.relativenumber = true

  -- Don't show the mode, since it's already in the status line
  vim.o.showmode = false

  -- Only yanks go to the macOS clipboard. 'unnamedplus' also sent deletes and
  -- plugin register writes (e.g. netrw restoring @@ on every listing).
  -- Paste from macOS clipboard with <D-v> or "+p.
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Copy yanks to the system clipboard',
    group = vim.api.nvim_create_augroup('yank-to-clipboard', { clear = true }),
    callback = function()
      -- Skip yanks into named registers ("ayy) so they don't clobber the clipboard.
      if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
        vim.fn.setreg('+', vim.fn.getreg('"'), vim.fn.getregtype('"'))
      end
    end,
  })

  -- Enable break indent
  vim.opt.wrap = false
  vim.opt.smartindent = true

  vim.opt.swapfile = false
  vim.opt.backup = false

  -- Enable undo/redo changes even after closing and reopening a file
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.o.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.o.inccommand = 'split'

  -- Show which line your cursor is on
  vim.o.cursorline = true
  vim.opt.startofline = false

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.scrolloff = 10

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  vim.o.confirm = true
end
