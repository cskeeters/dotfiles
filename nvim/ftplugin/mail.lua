local function khard_interactive()
    local line = vim.api.nvim_get_current_line()
    local escaped_line = vim.fn.shellescape(line)
    local cmd = "echo " .. escaped_line .. " | khard add-email"

    -- 1. Create a split for the interaction
    vim.cmd("split")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(buf)

    -- 2. Start the job in a terminal
    -- We use 'term' as the first argument to jobstart to wrap it in a terminal
    vim.fn.jobstart(cmd, {
        term = true,
        on_exit = function(_, exit_code)
            if exit_code == 0 then
                print("Contact processed successfully")
            end
            -- Close the buffer after a short delay so you can see any final messages
            vim.defer_fn(function()
                if vim.api.nvim_buf_is_valid(buf) then
                    vim.api.nvim_buf_delete(buf, { force = true })
                end
            end, 500)
        end
    })

    -- 3. Immediate focus so you can type your choice (yes/create/etc)
    vim.cmd("startinsert")
end

vim.keymap.set('n', '<leader>ka', khard_interactive, { desc = 'Interactive khard with jobstart' })
