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
    local mods = event:getFlags()
    -- print(mods)
    local keycode = event:getKeyCode()

    local f = event:rawFlags()
    -- print(string.format("Raw flags: %x", f))

    -- Assuming "L" and "R" are the keys you want to use in combination with Cmd
    local keyI = hs.keycodes.map['i']
    local keyO = hs.keycodes.map['o']
    local keyP = hs.keycodes.map['p']

    local NX_DEVICELCMDKEYMASK = 0x00000008
    local NX_DEVICERCMDKEYMASK = 0x00000010

    left_cmd  = f & NX_DEVICELCMDKEYMASK
    right_cmd = f & NX_DEVICERCMDKEYMASK

    -- print(string.format("left: %x", left_cmd))
    -- print(string.format("right: %x", right_cmd))

    if mods.cmd then -- If any Cmd key is pressed
        if keycode == keyI and right_cmd then
            print('i')
            -- hs.alert.show("Left Cmd + I")
	    hs.application.launchOrFocus("VimR")
            -- Place your action for Left Cmd + L here
	    return true
        elseif keycode == keyO and right_cmd then
            print('o')
            -- hs.alert.show("Right Cmd + O")
	    hs.application.launchOrFocus("Ghostty")
            -- Place your action for Right Cmd + R here
	    return true
        elseif keycode == keyP and right_cmd then
            print('p')
            -- hs.alert.show("Right Cmd + P")
	    hs.application.launchOrFocus("Strongbox")
            -- Place your action for Right Cmd + R here
	    return true
        end
    end
end

tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, handleEvent)
tap:start()
