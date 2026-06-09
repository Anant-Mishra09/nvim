return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            -- Keep track of whether completion is enabled or disabled globally
            local cmp_enabled = false

            cmp.setup({
                -- Tells Neovim whether or not to allow the popup menu to open
                enabled = function()
                    return cmp_enabled
                end,

                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.snippet.active({ direction = 1 }) then
                            vim.snippet.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.snippet.active({ direction = -1 }) then
                            vim.snippet.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })

            -- =================================================================
            -- TOGGLE KEYMAP: Press <leader>S to turn autocomplete on/off
            -- =================================================================
            vim.keymap.set("n", "<leader>S", function()
                cmp_enabled = not cmp_enabled
                if cmp_enabled then
                    print("Autocomplete ENABLED")
                else
                    cmp.abort() -- Instantly shut any open popup window down
                    print("Autocomplete DISABLED")
                end
            end, { desc = "Toggle Autocomplete menu on/off" })
        end,
    }
}

