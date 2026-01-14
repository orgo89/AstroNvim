-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
      signature_help = true,
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        -- allow_filetypes = { -- enable format on save for specified filetypes only
        --   -- "go",
        -- },
        -- ignore_filetypes = { -- disable format on save for specified filetypes
        --   -- "python",
        -- },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      -- timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    -- servers = {
    --   -- "pyright"
    -- },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    -- config = {
    --   -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    -- },
    -- customize how language servers are attached
    -- handlers = {
    --   -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
    --   -- function(server, opts) require("lspconfig")[server].setup(opts) end
    --
    --   -- the key is the server that is being setup with `lspconfig`
    --   -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
    --   -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    -- },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
        gpd = {
          function() require("goto-preview").goto_preview_definition() end,
          desc = "Preview definition",
          cond = "textDocument/declaration",
        },
        gpt = {
          function() require("goto-preview").goto_preview_type_definition(
            { focus_on_open = true, dismiss_on_move = false }) end,
          desc = "Preview type definition",
          cond = "textDocument/declaration",
        },
        gpi = {
          function() require("goto-preview").goto_preview_implementation({ focus_on_open = true, dismiss_on_move = false }) end,
          desc = "Preview implementation",
          cond = "textDocument/declaration",
        },
        gpD = {
          function() require("goto-preview").goto_preview_declaration({ focus_on_open = true, dismiss_on_move = false }) end,
          desc = "Preview declaration",
          cond = "textDocument/declaration",
        },
        gP = {
          function() require("goto-preview").close_all_win({}) end,
          desc = "Close all preview windows"
        },
        gpr = {
          function() require("goto-preview").goto_preview_references({ focus_on_open = true, dismiss_on_move = false }) end,
          desc = "Preview references"
        },
        ["<Leader>dn"] = {
          function() require("jdtls").test_nearest_method() end,
          desc = "Run/Debug the nearest test method"
        },
        ["<Leader>df"] = {
          function() require("jdtls").test_class() end,
          desc = "Run/Debug the current test class"
        },
        ["<Leader>da"] = {
          function() require("jdtls").pick_test() end,
          desc = "Prompt to pick a test"
        },
        ["<Leader>lj"] = {
          function() require("jdtls").jshell() end,
          desc = "Run Jshell with classpath based on current project"
        },
        ["<Leader>lt"] = {
          function() require("jdtls.tests").generate() end,
          desc = "Generate tests for current class"
        },
        ["<Leader>lg"] = {
          function() require("jdtls.tests").goto_subjects() end,
          desc = "Goto subjects: test class, class tested or generate tests"
        }
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
