vim.bo.commentstring = '# %s'
vim.opt_local.foldenable = false

function GenerateReports()
    vim.notify("Saving File", vim.log.levels.INFO)
    vim.cmd('update')

    local file_path = vim.fn.expand('%:p')   -- full path to "schedule.tjp"
    local file_dir  = vim.fn.expand('%:p:h') -- full path without "schedule.tjp"
    local file_name = vim.fn.expand('%:t:r') -- just "schedule.tjp, without ".tjp" extension

    local cmd = string.format(
        "cd %s && mkdir -p output && tj3 --no-color --output-dir output '%s'",
        vim.fn.shellescape(file_dir),
        file_path
    )

    vim.notify(string.format("Generating report with: %s", cmd), vim.log.levels.INFO)
    local output = vim.fn.system(cmd)

    if vim.v.shell_error ~= 0 then
        -- vim.notify("Error[".. vim.v.shell_error.."] running "..cmd.."\n"..output, vim.log.levels.ERROR)
        print("Error[".. vim.v.shell_error.."] running "..cmd.."\n"..output)
        return
    end


    local cmd = string.format(
        "cd %s && open 'output/%s.html'",
        vim.fn.shellescape(file_dir),
        file_name
    )

    vim.notify(string.format("Opening Report: %s", cmd), vim.log.levels.INFO)
    output = vim.fn.system(cmd)

    if vim.v.shell_error ~= 0 then
        -- vim.notify("Error[".. vim.v.shell_error.."] running "..cmd.."\n"..output, vim.log.levels.ERROR)
        print("Error[".. vim.v.shell_error.."] running "..cmd.."\n"..output)
        return
    end

end

function ToHeading(level)
    local line = vim.api.nvim_get_current_line()
    -- local cleaned = string.gsub(line, "^[= ]*(.-)[= ]*$", "%1")

    local space, text = string.match(line, "^( *)[= ]*(.-)[= ]*$")
    if space ~= nil then
        print(vim.inspect(space))

        local str = ""
        for i = 1, level do
            str = str.."="
        end

        vim.api.nvim_set_current_line(space..str.." "..text.." "..str)
    else
        print('No Match')
    end

end


vim.keymap.set('n', '<C-k>', GenerateReports, { buffer = true, desc = 'Generate Reports (Task Juggler)' })


-- Atx style Headers (I don't really need these)
-- vim.keymap.set('n', '<LocalLeader>1', [[<cmd>s/^\v\=* *([^=]+[^= ]) *\=*$/\1/<cr>]], { buffer=true, desc='= Heading 1' })
vim.keymap.set('n', '<LocalLeader>1', function() ToHeading(1) end, { buffer=true, desc='Heading 1' })
vim.keymap.set('n', '<LocalLeader>2', function() ToHeading(2) end, { buffer=true, desc='Heading 2' })
vim.keymap.set('n', '<LocalLeader>3', function() ToHeading(3) end, { buffer=true, desc='Heading 3' })
vim.keymap.set('n', '<LocalLeader>4', function() ToHeading(4) end, { buffer=true, desc='Heading 4' })
vim.keymap.set('n', '<LocalLeader>5', function() ToHeading(5) end, { buffer=true, desc='Heading 5' })
