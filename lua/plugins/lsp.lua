return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            -- 1. Initialize Mason
            require("mason").setup()

            -- 2. Handle downloads via Mason
            local servers = { "lua_ls", "rust_analyzer", "zls", "clangd", "pylsp", "arduino_language_server" }
            require("mason-lspconfig").setup({
                ensure_installed = servers,
            })

            -- 3. MODERN WAY: Initialize servers and optimize lua_ls for Neovim globals
            for _, server_name in ipairs(servers) do
                local config = { root_dir = vim.fn.getcwd() }
                if server_name == "lua_ls" then
                    config.settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        }
                    }
                end
                vim.lsp.config(server_name, config) 
                vim.lsp.enable(server_name)     
            end

            -- 4. Start with all visual noise completely silent and hidden
            local errors_visible = false
            vim.diagnostic.config({
                underline = false,
                virtual_text = false,
                signs = false,
            })

            -- =================================================================
            -- 5. KEYMAPS: Navigation, On-Demand Reading & Code Actions
            -- =================================================================
            vim.keymap.set("n", "<leader>e", function()
                errors_visible = not errors_visible
                if errors_visible then
                    vim.diagnostic.config({ underline = true, virtual_text = true, signs = true })
                else
                    vim.diagnostic.config({ underline = false, virtual_text = false, signs = false })
                end
            end, { desc = "Toggle inline error visibility" })

            -- Definition & Quick-Fix Actions
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Go to Definition (Ctrl+t to go back)" })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action / Quick Fix" })
            vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, { desc = "LSP Hover Documentation" })
        end,
    }


}
