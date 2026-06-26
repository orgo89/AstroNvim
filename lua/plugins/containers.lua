if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "emrearmagan/dockyard.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "akinsho/toggleterm.nvim", -- optional
  },
  cmd = { "Dockyard", "DockyardFloat" },
  lazy = true,
  config = function()
    require("dockyard").setup({
      display = {
        views = { "containers", "compose", "images", "networks", "volumes" }
      }
    })
  end,
}

