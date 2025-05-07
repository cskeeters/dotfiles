-- Requires autojump
-- Requires fzf


-- Check if archive command is available
local function is_command_available(cmd)
    local stat_cmd

    if ya.target_family() == "windows" then
        stat_cmd = string.format("where %s > nul 2>&1", cmd)
    else
        stat_cmd = string.format("command -v %s >/dev/null 2>&1", cmd)
    end

    local cmd_exists = os.execute(stat_cmd)
    if cmd_exists then
        return true
    else
        return false
    end
end

function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end

return {
    entry = function(_, job)

        if not is_command_available("autojump") then
            ya.notify("autojump not installed")
            return
        end

        ya.notify({
            title = "autojump",
            content = "autojump is installed!",
            timeout = 6.5,
            level = "error",
        })

        local value, event = ya.input {
            title = "autojump:",
            position = { "top-center", y = 3, w = 40 },
        }

        if event == 1 then

            local path = ''

            if #job.args >= 1 then
                -- Return multiple and search with fzf
                if not is_command_available("fzf") then
                    ya.notify("autojump not installed")
                    return
                end

                local permit = ya.hide()
                -- path = os.capture(string.format("autojump --complete \"%s\" | sed -nre 's/.*__.__(.*)/\\1/p' | fzf --preview-window='top,50%,border-bottom:hidden' ", value), false)
                path = os.capture(string.format("autojump --complete \"%s\" | sed -nre 's/.*__.__(.*)/\\1/p' | fzf --preview-window='top,border-bottom' ", value), false)
                permit:drop()
            else
                path = os.capture("autojump " .. value, false)
            end

            if path ~= '' then
                ya.mgr_emit("cd", { path })
            end
        end
    end,
}
