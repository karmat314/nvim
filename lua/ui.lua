local gh = require('git-helper').gh

do
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
  }

  -- Useful plugin to show you pending keybinds.
  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
      { '<leader>g', group = '[G]it' },
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  }

  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  -- vim.pack.add { gh 'folke/tokyonight.nvim' }
  --
  -- require('tokyonight').setup {
  --   style = 'night',
  --   transparent = true,
  --   terminal_colors = true,
  --   styles = {
  --     comments = { italic = false },
  --     keywords = {},
  --     sidebars = 'transparent',
  --     floats = 'transparent',
  --   },
  --
  --   on_colors = function(c)
  --     c.comment = '#8b96c4' -- was #565f89
  --     c.fg = '#d5dbf5'
  --     c.fg_dark = '#b6bee0'
  --     c.fg_gutter = '#4a5480' -- indent guides, inactive numbers
  --     c.dark3 = '#6b74a3'
  --     c.dark5 = '#8a94c2'
  --     c.border = '#7aa2f7'
  --   end,
  --
  --   on_highlights = function(hl, c)
  --     hl.Comment = { fg = c.comment, italic = false }
  --     hl.LineNr = { fg = '#7c86b8' }
  --     hl.CursorLineNr = { fg = '#ffc777', bold = true }
  --     hl.Visual = { bg = '#3d59a1' }
  --     hl.WinSeparator = { fg = '#7aa2f7', bold = true }
  --     hl.NonText = { fg = '#565f89' }
  --   end,
  -- }
  --
  -- vim.cmd.colorscheme 'tokyonight-night'
  -- Highlight todo, notes, etc in comments

  -- vim.pack.add { gh 'wtfox/luna.nvim' }
  -- require('luna').setup {
  --   transparent = true,
  --   terminal_colors = true,
  --   styles = {
  --     comments = { italic = false },
  --     keywords = {},
  --     sidebars = 'transparent',
  --     floats = 'transparent',
  --   },
  -- }
  -- vim.cmd.colorscheme 'luna'

  vim.pack.add { gh 'bluz71/vim-moonfly-colors' }
  vim.g.moonflyTransparent = true
  vim.cmd [[colorscheme moonfly]]

  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  -- Animated cursor trail
  -- vim.pack.add { gh 'sphamba/smear-cursor.nvim' }
  -- require('smear_cursor').setup {
  --   stiffness = 0.8,
  --   trailing_stiffness = 0.2,
  --   stiffness_insert_mode = 0.7,
  --   damping = 0.95,
  --   distance_stop_animating = 0.5,
  -- }

  vim.pack.add { gh 'karb94/neoscroll.nvim' }
  require('neoscroll').setup {}

  -- [[ mini.nvim ]]
  --  A collection of various small independent plugins/modules
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- If a nerd font is available, load the icons module for pretty icons in various plugins.
  if vim.g.have_nerd_font then
    require('mini.icons').setup()
    -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
    MiniIcons.mock_nvim_web_devicons()
  end

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  require('mini.indentscope').setup()

  local statusline = require 'mini.statusline'
  -- Set `use_icons` to true if you have a Nerd Font
  statusline.setup { use_icons = vim.g.have_nerd_font }

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end
end
