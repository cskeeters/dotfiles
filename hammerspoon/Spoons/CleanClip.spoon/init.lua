-- This spoon enables the removal of formatting from text in the clipboard.
--
-- This watches the clipboard for changes.  If the clipboard changes because
-- this script modified it, the UTI saved in old_uti will have been set and
-- the change can be ignored.
--
-- When the data as no value for old_uti, it's fresh.  The data is saved into
-- current_all_data, is mutated according to mode, and written back to the
-- clipboard.
--
-- When the mode is changed, the data is remodified from the copy in 
-- current_all_data.  This prevents the user from having to re-copy the data if
-- it has been mutated undesirably.
--
-- The modes are:
--   OFF   - no modification takes place
--   TEXT  - formatting is stripped from text  (only the text_uti is included
--           in the mutated clipboard)
--   EXCEL - Text is trimmed, '$' and ','s are removed, good for accounting
--           cells to other cells where formatting should be retained.

local obj = {
}

-- Metadata
obj.name = "CleanClip"
obj.version = "1.0"
obj.author = "Chad Skeeters"
obj.homepage = "https://github.com/cskeeters/hammerspoon-CleanClip"
obj.license = "https://github.com/cskeeters/hammerspoon-CleanClip"

local watcher = nil
local current_all_data = nil
local text_uti = "public.utf8-plain-text"   -- UTI to mutate when mode is not OFF
local old_uti = "vnd.sqlite3"               -- Should be a valid UTI that is not commonly used

obj.OFF = 0
obj.TEXT_ONLY = 1
obj.TEXT_EXCEL = 2

obj.mode = 0

function obj:setMode(m)
    obj.mode = m

    if obj.mode == obj.OFF then
        hs.alert.show("CleanClip Mode: Off")
        SetRaw()
    end
    if obj.mode == obj.TEXT_ONLY then
        hs.alert.show("CleanClip Mode: Text Only")
        SetText()
    end
    if obj.mode == obj.TEXT_EXCEL then
        hs.alert.show("CleanClip Mode: Text / Excel")
        SetExcel()
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

-- Returns true when new data is detected and copied
function save_raw()
    -- In case we need to see what UTIs are being set
    -- local types = hs.pasteboard.contentTypes()
    -- print("types")
    -- for _,v in ipairs(types) do
        -- print(v)
    -- end

    local all_data = hs.pasteboard.readAllData()
    if all_data ~= nil then
        if all_data[old_uti] == nil then
            current_all_data = all_data
            -- print("Saving clipboard data")
            return true
        end
    end

    return false
end

function table.shallow_copy(t)
  local copy = {}
  for k,v in pairs(t) do
    copy[k] = v
  end
  return copy
end

function SetRaw()
    if current_all_data ~= nil then
        local copy = table.shallow_copy(current_all_data)
        copy[old_uti] = "1"
        if hs.pasteboard.writeAllData(copy) ~= true then
            hs.alert.show("Error setting clipboard")
        end
    end
end

function SetText()
    if current_all_data ~= nil then
        -- If the current data has no value for text_uti, leave the raw data in place
        if current_all_data[text_uti] ~= nil then
            local all_data = {}
            -- skip copying all other UTIs
            all_data[text_uti] = current_all_data[text_uti]
            all_data[old_uti] = "1"
            if hs.pasteboard.writeAllData(all_data) ~= true then
                hs.alert.show("Error setting clipboard")
            end
        end
    end
end

function SetExcel()
    if current_all_data ~= nil then
        -- If the current data has no value for text_uti, leave the raw data in place
        if current_all_data[text_uti] ~= nil then
            local all_data = {}
            -- skip copying all other UTIs
            all_data[text_uti] = cleanExcel(current_all_data[text_uti])
            all_data[old_uti] = "1"
            if hs.pasteboard.writeAllData(all_data) ~= true then
                hs.alert.show("Error setting clipboard")
            end
        end
    end
end

function obj:clipboardCallback()
    -- print("clipboardCallback")
    if save_raw() then
        -- we captured a change
        if obj.mode == obj.TEXT_ONLY then
            SetText()
        end
        if obj.mode == obj.TEXT_EXCEL then
            SetExcel()
        end
    end
end

-- Binds global hotkeys
function obj:init()
    hs.hotkey.bind({ 'shift', 'cmd' }, "0", function() obj:changeMode() end)


    -- I use QMK and kb_reg for this.  https://github.com/cskeeters/kb_reg
    -- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

    watcher = hs.pasteboard.watcher.new(function() obj:clipboardCallback() end)
    hs.pasteboard.watcher.interval(1.0/8)
    watcher:start()
end

return obj
