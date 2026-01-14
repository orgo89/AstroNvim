-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
  },
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
  },
  {
    "baliestri/aura-theme",
    name = "aura",
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  {
    "savq/melange-nvim",
    name = "melange",
  },
  {
    "luisiacc/gruvbox-baby",
    name = "gruvbox-baby",
  },
  {
    "Biscuit-Theme/nvim",
    name = "Biscuit-Theme",
  },
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    lazy = false,
    -- priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd.colorscheme("gruvbox-material")
      vim.o.background = 'dark'
      vim.o.termguicolors = true
    end
  },
  {
    "maxmx03/solarized.nvim",
    name = "solarized",
    lazy = false,
    opts = {
      variant = 'summer'
    },
    config = function (_, opts)
      vim.o.termguicolors = true
      vim.o.background = 'light'
      require('solarized').setup(opts)
      vim.cmd.colorscheme 'solarized'
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.everforest_enable_italic = true
    vim.cmd.colorscheme('everforest')
    end
  }
}
