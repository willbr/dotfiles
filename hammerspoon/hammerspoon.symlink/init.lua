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

-- A helper function to send a CMD+[key] shortcut only to Brave Browser
local function send_brave_shortcut(key)
  -- Get the application that is currently in focus
  local frontmostApp = hs.application.frontmostApplication()

  -- Check if the focused application is Brave Browser
  if frontmostApp and frontmostApp:name() == "Brave Browser" then
    -- Post the key-down and key-up events separately with a small delay
    -- This is more reliable than hs.eventtap.keyStroke()
    hs.eventtap.event.newKeyEvent({'cmd'}, key, true):post()
    hs.timer.usleep(1000) -- 1-millisecond delay
    hs.eventtap.event.newKeyEvent({'cmd'}, key, false):post()
  end
end

-- Remap Ctrl+W to close the current tab (Cmd+W)
hs.hotkey.bind({'ctrl'}, 'w', function()
  send_brave_shortcut('w')
end)

-- Remap Ctrl+T to open a new tab (Cmd+T)
hs.hotkey.bind({'ctrl'}, 't', function()
  send_brave_shortcut('t')
end)

local function handleEvent(event)
    -- print(hs.inspect(keyboardTypes))

    -- print(string.format("kbdType: %x", kbdType))
    local keycode = event:getKeyCode()
    -- print(string.format("keycode: %x", keycode))
    local f = event:rawFlags()
    -- print(string.format("Raw flags: %x", f))

    -- Raw modifier flags
    -- local right_alt = f & hs.eventtap.event.rawFlagMasks.deviceRightAlternate
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
    if right_cmd ~= 0 then
        -- print(string.format("keycode: %x", keycode))
        local app = appKeys[keycode]
        if app then
            hs.application.launchOrFocus(app)
            return true
        end
    elseif right_cmd ~= 0 then
        -- print("skip")
        -- print(string.format("kbdType: %x", kbdType))
        -- print(string.format("desktop: %x", keyboardTypes.desktop))
        -- print(string.format("desktop eq: %s", kbdType == keyboardTypes.desktop))
        -- print(string.format("keycode: %x", keycode))
        -- print(hs.inspect(keyboardTypes))
        -- print(string.format("keycode: %x", hs.keycodes.map.i))
        -- print(string.format("keycode: %x", hs.keycodes.map.o))
        -- print(string.format("keycode: %x", hs.keycodes.map.p))
        -- print()
        -- print(string.format("right_alt: %x", right_alt))
        -- print(string.format("right_cmd: %x", right_cmd))
        -- do nothing
    else
        -- print(string.format("kbdType: %x", kbdType))
        -- print(string.format("desktop: %x", keyboardTypes.desktop))
        -- print(string.format("desktop eq: %s", kbdType == keyboardTypes.desktop))
        -- print(string.format("keycode: %x", keycode))
        -- print(string.format("kbdType: %x", kbdType))
    end
    
    return false
end


local desktopHostname = "William’s Mac mini"
local laptopHostname = "YourLaptopName"

local currentHost = hs.host.localizedName()

if currentHost == desktopHostname then
    hs.hotkey.bind({"alt"}, "i", function()
        hs.application.launchOrFocus("VimR")
    end)
    hs.hotkey.bind({"alt"}, "o", function()
        hs.application.launchOrFocus("Ghostty")
    end)
    hs.hotkey.bind({"alt"}, "p", function()
        hs.application.launchOrFocus("Strongbox")
    end)
elseif currentHost == laptopHostname then
    hs.alert.show("You are on your laptop!")
    tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, handleEvent)
    tap:start()
else
    print(string.format("Unknown device! %s", currentHost))
end
