-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "rmagatti/goto-preview",
  -- lazy = false,
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  config = true
}
