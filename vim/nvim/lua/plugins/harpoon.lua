return {
    enabled = true,
    'ThePrimeagen/harpoon',
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    },
    config = true,
    keys = {
        { "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
        { "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
        { "]h",         "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
        { "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous harpoon mark" },
        { "[h",         "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous harpoon mark" },
        { "<leader>he", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
        { "<leader>ha", "<cmd>Telescope harpoon marks<cr>", desc = "Show harpoon marks" },

        -- lua require("harpoon.ui").nav_file(3)
        -- lua require("harpoon.term").gotoTerminal(1)
        -- lua require("harpoon.term").sendCommand(1, "ls -La")
        -- :Telescope harpoon marks
    },
    init = function()
      require("telescope").load_extension('harpoon')
    end,
}
