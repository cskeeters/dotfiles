return {
    enabled = false,
    'ThePrimeagen/git-worktree.nvim',
    lazy = false,
    keys = {
        { "<leader>n", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", desc = "Switch Worktrees" },
    }
}
