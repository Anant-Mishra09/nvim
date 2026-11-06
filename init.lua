require("config.options")
require("config.keybinds")
require("config.lazy")
vim.opt.clipboard = "unnamedplus"

--change color of variables to blue
vim.api.nvim_set_hl(0, "@lsp.typemod.variable.fileScope.cuda", { link = "Identifier" })

--  change color of functions to green
vim.api.nvim_set_hl(0, "@lsp.typemod.variable.globalScope.cuda", { link = "Function" })
