-- This spoon enables the removal of formatting from text in the clipboard.
-- This watches the clipboard and when new data is copied to the clipboard it
-- will mutate the text based on the current mode.  The modes are as follows:
--  * 
--

local obj = {
}

-- Metadata
obj.name = "CleanClip"
obj.version = "1.0"
obj.author = "Chad Skeeters"
obj.homepage = "https://github.com/cskeeters/hammerspoon-CleanClip"
obj.license = "https://github.com/cskeeters/hammerspoon-CleanClip"

local watcher = nil

obj.OFF = 0
obj.TEXT_ONLY = 1
obj.TEXT_EXCEL = 2

obj.mode = 0

function obj:setMode(m)
    obj.mode = m

    if obj.mode == obj.OFF then
        hs.alert.show("CleanClip Mode: Off")
    end
    if obj.mode == obj.TEXT_ONLY then
        hs.alert.show("CleanClip Mode: Text Only")
    end
    if obj.mode == obj.TEXT_EXCEL then
        hs.alert.show("CleanClip Mode: Text / Excel")
    end
end

function obj:changeMode()
    local m = obj.mode + 1
    if (m > obj.TEXT_EXCEL) then
        m = obj.OFF
    end

    obj:setMode(m)
end

local function split(str, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for part in string.gmatch(str..sep, "([^"..sep.."]*)"..sep) do
    table.insert(t, part)
  end
  return t
end

local function trim(s)
  return s:match"^%s*(.*)":match"(.-)%s*$"
end

local function tofloat(s)
  local number = s:match("^[$%s]*(.*)"):match("(.-)%s*$")
  return number:gsub(",", "")
end

local function cleanExcel(data)
    local lines = split(data, "\n")

    local mlines = {}
    for _, line in ipairs(lines) do
        local mcells = {}
        local cells = split(line, "	")

        for _, value in ipairs(cells) do
            local float = tofloat(value)
            local n = tonumber(float)
            if n ~= nil then
                table.insert(mcells, n)
            else
                table.insert(mcells, trim(value))
            end
        end
        table.insert(mlines, table.concat(mcells, "	"))
    end
    return table.concat(mlines, "\n")
end

function obj:clipboardCallback()
    if obj.mode == obj.OFF then
        return
    end

    local clipboard = hs.pasteboard.getContents()

    if obj.mode == obj.TEXT_EXCEL then
        clipboard = cleanExcel(clipboard)
    end

    if hs.pasteboard.setContents(clipboard) ~= true then
        hs.alert.show("Error setting clipboard")
    end
    -- print("Modified clipboard to: "..clipboard)
end

-- Binds global hotkeys
function obj:init()
    hs.hotkey.bind({ 'shift', 'cmd' }, "0", function() obj:changeMode() end)


    -- I use QMK and kb_reg for this.  https://github.com/cskeeters/kb_reg
    -- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

    watcher = hs.pasteboard.watcher.new(function() obj:clipboardCallback() end)
    watcher:start()
end

return obj
