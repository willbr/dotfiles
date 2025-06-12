hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
  end)



  hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
  end)

  hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f)
  end)

local function closeFrontmostWindow()
    local win = hs.window.focusedWindow()
    if win then
        --win:close()
    end
end

local function closeTabInSafari()
    local app = hs.application.frontmostApplication()
    local appname = app:name()
    

    if appname ~= "Safari" then
        print(appname)
        return
    end

    local script = [[
      tell application "Safari"
        activate
        tell application "System Events" to keystroke "w" using command down
      end tell
    ]]
  
    hs.osascript.applescript(script)
  end

hs.hotkey.bind({"ctrl"}, "w", closeTabInSafari)


local function handleEvent(event)
    local keyboardTypes = {
        laptop  = 0x5c,    -- Replace with your laptop's actual type ID
        desktop = 0x28
    }
    -- print(hs.inspect(keyboardTypes))

    local kbdType = event:getProperty(hs.eventtap.event.properties.keyboardEventKeyboardType)
    -- print(string.format("kbdType: %x", kbdType))
    local keycode = event:getKeyCode()
    -- print(string.format("keycode: %x", keycode))
    local f = event:rawFlags()
    -- print(string.format("Raw flags: %x", f))

    -- Raw modifier flags
    local right_alt = f & hs.eventtap.event.rawFlagMasks.deviceRightAlternate
    local right_cmd = f & hs.eventtap.event.rawFlagMasks.deviceRightCommand
    -- print(string.format("right_alt: %x", right_alt))
    -- print(string.format("right_cmd: %x", right_cmd))

    -- Application mapping
    local appKeys = {
        [hs.keycodes.map.i] = "VimR",
        [hs.keycodes.map.o] = "Ghostty",
        [hs.keycodes.map.p] = "Strongbox"
    }
    -- print(hs.inspect(appKeys))

    -- Desktop keyboard (using Right Alt)
    if kbdType == keyboardTypes.desktop and right_alt ~= 0 then
        -- print(string.format("keycode: %x", keycode))
        local app = appKeys[keycode]
        if app then
            hs.application.launchOrFocus(app)
            return true
        end

    -- Laptop keyboard (using Right Cmd)
    elseif kbdType == keyboardTypes.laptop and right_cmd ~= 0 then
        -- print(string.format("keycode: %x", keycode))
        local app = appKeys[keycode]
        if app then
            hs.application.launchOrFocus(app)
            return true
        end
    elseif right_alt ~= 0 or right_cmd ~= 0 then
        print("skip")
        print(string.format("kbdType: %x", kbdType))
        print(string.format("desktop: %x", keyboardTypes.desktop))
        print(string.format("desktop eq: %s", kbdType == keyboardTypes.desktop))
        print(string.format("keycode: %x", keycode))
        print(hs.inspect(keyboardTypes))
        -- print(string.format("keycode: %x", hs.keycodes.map.i))
        -- print(string.format("keycode: %x", hs.keycodes.map.o))
        -- print(string.format("keycode: %x", hs.keycodes.map.p))
        print()
        -- print(string.format("right_alt: %x", right_alt))
        -- print(string.format("right_cmd: %x", right_cmd))
        -- do nothing
    else
        -- print(string.format("kbdType: %x", kbdType))
    end
    
    return false
end

tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, handleEvent)
tap:start()
