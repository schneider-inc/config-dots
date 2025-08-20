return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "emmylua_ls",
                    "rust_analyzer", 
                    "clangd", 
                    "basedpyright", 
                    "arduino_language_server",
                    "elmls",
                    "nil_ls",
                    "ts_ls",
                    "hyprls",
                },
            })
        end
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable('emmylua_ls')
            vim.lsp.enable('rust_analyzer')
            vim.lsp.enable('clangd')
            vim.lsp.enable('basedpyright')
            vim.lsp.enable('arduino_language_server')
            vim.lsp.enable('elmls')
            vim.lsp.enable('nil_ls')
            vim.lsp.enable('ts_ls')
            vim.lsp.enable('hyprls')

            vim.lsp.config('clangd', {
                cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
                init_options = {
                    fallbackFlags = { '-std=c++17' },
                },
            })
            -- vim.lsp.config('

            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
              vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
              vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
              vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
              -- Use LspAttach autocommand to only map the following keys
              -- after the language server attaches to the current buffer
              vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                  -- Enable completion triggered by <c-x><c-o>
                  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                  -- Buffer local mappings.
                  -- See `:help vim.lsp.*` for documentation on any of the below functions
                  local opts = { buffer = ev.buf }
                  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                  vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                  end, opts)
                  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                  vim.keymap.set('n', '<space>f', function()

                  vim.lsp.buf.format { async = true }
                  end, opts)
                end,
            })
        end
    },

    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local cmp_select = {behavior = cmp.SelectBehavior.Select}

            cmp.setup({
                sources = {
                    {name = "path"},
                    {name = "nvim_lsp"},
                    {name = "nvim_lua"},
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true}),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
            })
        end,
    },
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip"
}
