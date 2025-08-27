if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This is not working yet
return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function ()
    
    jdtls = require("jdtls")

    jdtls.start_or_attach({
      cmd = {
        vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
        ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar')
      },
      bundles = vim.split(vim.fn.glob('$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar', true), '\n'),
    })

  end
}
