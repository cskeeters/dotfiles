-- local MicMute = hs.loadSpoon("MicMute")
local moveIt = hs.loadSpoon("MoveIt")
-- change keys here
-- moveIt.centerKey = 'c'
moveIt:init()

function SerializeTable(val, name, skipnewlines, depth)
    skipnewlines = skipnewlines or false
    depth = depth or 0

    local tmp = string.rep(" ", depth)

    if name then tmp = tmp .. name .. " = " end

    if type(val) == "table" then
        tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

        for k, v in pairs(val) do
            tmp =  tmp .. SerializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
        end

        tmp = tmp .. string.rep(" ", depth) .. "}"
    elseif type(val) == "number" then
        tmp = tmp .. tostring(val)
    elseif type(val) == "string" then
        tmp = tmp .. string.format("%q", val)
    elseif type(val) == "boolean" then
        tmp = tmp .. (val and "true" or "false")
    else
        tmp = tmp .. "\"[inserializeable datatype:" .. type(val) .. "]\""
    end

    return tmp
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
    hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()

    hs.alert.show("Ran")
    local currentAudio = hs.audiodevice.current()
    print(SerializeTable(currentAudio))

    -- MicMute:toggleMicMute()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    hs.reload()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
    local output, status, type, rc = hs.execute([[pbpaste | /usr/local/bin/kb_reg -r -k .]])
    if rc == 0 then
        hs.alert.show("Copied to KB")
    else
        hs.alert.show("Error occurred.  Check ~/.local/log/kb_reg.log")
    end
end)

hs.alert.show("Hammerspoon config loaded!")
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)
