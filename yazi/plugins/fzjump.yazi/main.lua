-- Requires autojump

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
    entry = function(_, args)

        local value, event = ya.input {
            title = "autojump:",
            position = { "top-center", y = 3, w = 40 },
        }

        if event == 1 then
            local path = os.capture("autojump " .. value, false)
            if path ~= '' then
                ya.mgr_emit("cd", { path })
            end
        end
    end,
}

-- sel=$(autojump --complete "$ARG" | sed -nre 's/.*__.__(.*)/\1/p' | fzf)
