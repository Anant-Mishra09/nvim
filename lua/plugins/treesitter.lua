return {  
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
	local configs = require("nvim-treesitter.config")
	configs.setup({
	    highlight = {enable = true},
	    indent = {enable = true},
	    ensure_installed = {"lua","cpp","cuda","c","zig","python","rust"},
	    auto_install = false,
	})
    end 
}
