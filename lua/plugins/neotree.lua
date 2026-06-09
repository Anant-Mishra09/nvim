return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    -- Lazy loads the plugin safely so netrw can handle "nvim ."
    keys = {
      -- Uses Ctrl + b to cleanly toggle the right sidebar without netrw conflicts
      { "<C-b>", "<cmd>Neotree toggle right<cr>", desc = "Toggle Neo-tree Sidebar" },
    },
    config = function()
      require("neo-tree").setup({
        hijack_netrw_behavior = "disabled", 
        filesystem = {
          hijack_netrw = false,
        },
        window = {
          position = "right",
          width = 30,
        },
      })
    end
  }
}

