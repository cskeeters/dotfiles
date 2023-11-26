--- Manages windows and positions in MacOS.

local obj = {
}

-- Metadata
obj.name = "MoveIt"
obj.version = "1.0"
obj.author = "Chad Skeeters"
obj.homepage = "https://github.com/cskeeters/hammerspoon-MoveIt"
obj.license = "https://github.com/cskeeters/hammerspoon-MoveIt"

-- mash and keys can be overridden before init for custom bindings
obj.mash = { 'ctrl', 'alt' }

obj.leftKey  = 'j'
obj.leftKey2 = 'left'
obj.rightKey = 'l'
obj.rightKey2 = 'right'
obj.upKey = 'i'
obj.upKey2 = 'up'
obj.downKey = ','
obj.downKey2 = 'down'
obj.centerKey = 'k'

obj.upLeftKey = 'u'
obj.upRightKey = 'o'
obj.downLeftKey = 'm'
obj.downRightKey = '.'

obj.fullscreenKey = 'return'

obj.nextScreenKey = 'n'
obj.prevScreenKey = 'p'

-- This keeps track of the details of the last action so that actions can have states
-- such as cycling between half screen and 2/3rds screen
local latestAction = {
  windowId = -1,
  action = '',
  state = 0
}

-- Helper function for incrementing state if the window and action are the same as the last
local updateState = function(action, stateCount)
    local focusedWindowId = hs.window.focusedWindow():id()
    if latestAction.windowId ~= focusedWindowId then
        latestAction.windowId = focusedWindowId
        latestAction.action = action
        latestAction.state = 0
    else
        if latestAction.action ~= action then
            latestAction.action = action
            latestAction.state = 0
        else
            latestAction.state = (latestAction.state + 1) % stateCount
        end
    end
    print('Running Action:'..action..' with state: '..tostring(latestAction.state))
    return latestAction.state
end

-- Utility for actually moving the window
function obj:move(unit) hs.window.focusedWindow():move(unit, nil, true, 0) end

-- Moves window to the left half or the left 2/3rds
function obj:left()
    local state = updateState('left', 2)

    hs.window.focusedWindow():setFullScreen(false)
    if state == 0 then
        local screen = hs.window.focusedWindow():screen():frame()
        self:move({ x = screen.x, y = screen.y, w = screen.w/2, h = screen.h })
    end
    if state == 1 then
        local screen = hs.window.focusedWindow():screen():frame()
        self:move({ x = screen.x, y = screen.y, w = screen.w*(2/3), h = screen.h })
    end
end

-- Moves window to the right half or the left 2/3rds
function obj:right()
    local state = updateState('right', 2)

    hs.window.focusedWindow():setFullScreen(false)
    if state == 0 then
        local screen = hs.window.focusedWindow():screen():frame()
        self:move({ x = screen.x + screen.w/2, y = screen.y, w = screen.w/2, h = screen.h })
    end
    if state == 1 then
        local screen = hs.window.focusedWindow():screen():frame()
        self:move({ x = screen.x + screen.w/3, y = screen.y, w = screen.w*(2/3), h = screen.h })
    end
end

-- Moves window to the center with a 2/3rds width or full width
function obj:center()
    local state = updateState('center', 2)

    hs.window.focusedWindow():setFullScreen(false)
    if state == 0 then
        local screen = hs.window.focusedWindow():screen():frame()
        self:move({ x = screen.x + screen.w/6, y = screen.y, w = screen.w*(2/3), h = screen.h })
    end

    if state == 1 then
        local screen = hs.window.focusedWindow():screen():frame()
        self:move({ x = screen.x, y = screen.y, w = screen.w, h = screen.h })
    end
end

-- Moves window to the top half or 2/3rds
function obj:up()
    local state = updateState('up', 2)

    hs.window.focusedWindow():setFullScreen(false)
    if state == 0 then
        local screen = hs.window.focusedWindow():screen():frame()
        self:move({ x = screen.x, y = screen.y, w = screen.w, h = screen.h/2 })
    end

    if state == 1 then
        local screen = hs.window.focusedWindow():screen():frame()
        self:move({ x = screen.x, y = screen.y, w = screen.w, h = screen.h*(2/3) })
    end
end

-- Moves window to the bottom half or 2/3rds
function obj:down()
    local state = updateState('down', 2)

    hs.window.focusedWindow():setFullScreen(false)
    if state == 0 then
        local screen = hs.window.focusedWindow():screen():frame()
        self:move({ x = screen.x, y = screen.y + screen.h/2, w = screen.w, h = screen.h/2 })
    end

    if state == 1 then
        local screen = hs.window.focusedWindow():screen():frame()
        self:move({ x = screen.x, y = screen.y + screen.h/3, w = screen.w, h = screen.h*(2/3) })
    end
end

-- Moves window to the upper left quartile
function obj:upLeft()
    _ = updateState('upLeft', 1)
    hs.window.focusedWindow():setFullScreen(false)
    local screen = hs.window.focusedWindow():screen():frame()
    self:move({ x = screen.x, y = screen.y, w = screen.w/2, h = screen.h/2 })
end

-- Moves window to the upper right quartile
function obj:upRight()
    _ = updateState('upRight', 1)
    hs.window.focusedWindow():setFullScreen(false)
    local screen = hs.window.focusedWindow():screen():frame()
    self:move({ x = screen.x+screen.w/2, y = screen.y, w = screen.w/2, h = screen.h/2 })
end

-- Moves window to the lower left quartile
function obj:downLeft()
    _ = updateState('downLeft', 1)
    hs.window.focusedWindow():setFullScreen(false)
    local screen = hs.window.focusedWindow():screen():frame()
    self:move({ x = screen.x, y = screen.y + screen.h/2, w = screen.w/2, h = screen.h/2 })
end

-- Moves window to the lower right quartile
function obj:downRight()
    _ = updateState('upright', 1)
    hs.window.focusedWindow():setFullScreen(false)
    local screen = hs.window.focusedWindow():screen():frame()
    self:move({ x = screen.x+screen.w/2, y = screen.y + screen.h/2, w = screen.w/2, h = screen.h/2 })
end

-- Toggles fullscreen
function obj:fullscreen()
    _ = updateState('fullscreen', 2)
    hs.window.focusedWindow():toggleFullScreen()
end

-- Moves window to the next monitor
function obj:nextScreen()
    hs.window.focusedWindow():moveToScreen(hs.window.focusedWindow():screen():next(), false, true, 0)
end

-- Moves window to the previous monitor
function obj:prevScreen()
    hs.window.focusedWindow():moveToScreen(hs.window.focusedWindow():screen():previous(), false, true, 0)
end

-- Binds global hotkeys
function obj:init()
    if self.leftKey   then hs.hotkey.bind(self.mash, self.leftKey,       function() obj:left() end) end
    if self.leftKey2  then hs.hotkey.bind(self.mash, self.leftKey2,      function() obj:left() end) end
    if self.rightKey  then hs.hotkey.bind(self.mash, self.rightKey,      function() obj:right() end) end
    if self.rightKey2 then hs.hotkey.bind(self.mash, self.rightKey2,     function() obj:right() end) end
    if self.upKey     then hs.hotkey.bind(self.mash, self.upKey,         function() obj:up() end) end
    if self.upKey2    then hs.hotkey.bind(self.mash, self.upKey2,        function() obj:up() end) end
    if self.downKey   then hs.hotkey.bind(self.mash, self.downKey,       function() obj:down() end) end
    if self.downKey2  then hs.hotkey.bind(self.mash, self.downKey2,      function() obj:down() end) end

    hs.hotkey.bind(self.mash, self.centerKey,     function() obj:center() end)

    hs.hotkey.bind(self.mash, self.upLeftKey,     function() obj:upLeft() end)
    hs.hotkey.bind(self.mash, self.upRightKey,    function() obj:upRight() end)
    hs.hotkey.bind(self.mash, self.downLeftKey,   function() obj:downLeft() end)
    hs.hotkey.bind(self.mash, self.downRightKey,  function() obj:downRight() end)

    hs.hotkey.bind(self.mash, self.fullscreenKey, function() obj:fullscreen() end)

    hs.hotkey.bind(self.mash, self.nextScreenKey, function() obj:nextScreen() end)
    hs.hotkey.bind(self.mash, self.prevScreenKey, function() obj:prevScreen() end)
end

return obj
