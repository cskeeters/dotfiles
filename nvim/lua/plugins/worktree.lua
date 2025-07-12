function CreateWorkspace()
    local folder = vim.fn.input("Folder Name: ", "")

    local branch_default = "main"
    if os.execute([[git for-each-ref --format='%(refname:short)' refs/heads | grep main]]) then
        branch_default = "master"
    end
    local branch = vim.fn.input("Branch Branch: ", branch_default)

    -- upstream is nil
    require("git-worktree").create_worktree(folder, branch_default, nil)
end

return {
    enabled = true,
    'ThePrimeagen/git-worktree.nvim',
    lazy = false,
    keys = {
        { "<leader>fw", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", desc = "Switch Worktrees" },
        { "<leader>fc", CreateWorkspace, desc = "Create Worktree" },

        -- deletes to an existing worktree.  Requires the path name
        -- :lua require("git-worktree").delete_worktree("feat-69")
    },
    config = function()
        require('git-worktree').setup({
            -- The vim command used to change to the new worktree directory. Set this to tcd if you want to only change the pwd for the current vim Tab.
            change_directory_command = "tcd", -- default: "cd",

            -- Updates the current buffer to point to the new work tree if the file is found in the new project. Otherwise, the following command will be run.
            update_on_change = true, -- default: true,

            -- The vim command to run during the update_on_change event. Note, that this command will only be run when the current file is not found in the new worktree. This option defaults to e . which opens the root directory of the new worktree.
            update_on_change_command = "e .", -- default: "e .",

            -- Every time you switch branches, your jumplist will be cleared so that you don't accidentally go backward to a different branch and edit the wrong files.
            clearjumps_on_change = true, -- default: true,

            -- When creating a new worktree, it will push the branch to the upstream then perform a git rebase
            autopush = false, -- default: false,
        })
    end
}
