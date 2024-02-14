--
-- SWBF2 2005 Lua script
-- created by MileHighGuy from Gametoast.com

-- Ingame screen to capture key presses
-- v 1.0
-- to see the entry point of the code, search for "ifs_ingame_keys = NewIFShellScreen"

-- Singleplayer only for now.
-- if you want to make it work in multiplayer,
-- you at least have to change the events
-- which push the screen in addInGameKeyScreen
-- I don't know if that is enough

-- TO INSTALL
--
--paste this at the top of your mission script
--
--
--IGK_originalDoFile = ScriptCB_DoFile
--ScriptCB_DoFile = function(filename)
--    if(filename == "ifs_pausemenu") then
--
--        IGK_originalDoFile("ifs_ingame_keys")
--        IGK_originalDoFile("ifs_pausemenu")
--    end
--end
--
--paste this in your mission ScriptInit() function, after it loads the ReadDataFile("ingame.lvl")
--
--addInGameKeyScreen()
--
-- also add ifs_ingame_keys to the mission.req
--
--that's all!


--TODO get gamepad controls (if possible)

-- this table is populated by C code callback ScriptCB_GetKeyBoardCmds()
-- default commands with English names
ifs_opt_pckeyboard_listbox_contents = {}

-- it will have the contents below depending on control mode
-- changed with these functions ScriptCB_SetControlMode(0) ScriptCB_GetControlMode()

-- control mode 0 solider ===============
--Primary Attack:  Mouse Button 1
--Primary Switch:  1, Mouse Wheel Down
--Secondary Attack:  Mouse Button 2
--Secondary Switch:  2, Mouse Wheel Up
--Lock Target:  Q, Mouse Button 4
--Sprint:  SHIFT, RIGHT SHIFT
--Jump:  SPACE, NUM 0
--Crouch:  C, RIGHT CTRL
--Roll:  ALT, NUM 1
--Zoom:  Z, Mouse Button 3
--View:  V, END
--Reload:  R, DELETE
--Enter/Use:  E, ENTER
--Move Right/Left Axis:  << None >>
--Move Forward/Back Axis:  << None >>
--Look Right/Left Axis:  Mouse X Axis
--Look Up/Down Axis:  Mouse Y Axis
--Move Right:  D, RIGHT
--Move Left:  A, LEFT
--Move Forward:  W, UP
--Move Back:  S, DOWN
--Look Right:  << None >>
--Look Left:  << None >>
--Look Up:  << None >>
--Look Down:  << None >>
--Accept:  PAGE UP, F1
--Decline:  PAGE DOWN, F2
--Player List:  TAB, \
--Chat:  T
--Team Chat:  Y
--Squad Commands:  F4, NUM 4
--Communications - Spotted:  F5
--Communications - Medic:  F6
--Communications - Repair:  F7
--Communications - Ammo:  F8
--Communications - Pickup:  F9
--Communications - Backup:  F10
--Communications - Attack:  F11
--Communications - Defend:  F12
--Show Map:  M

-- control mode 1 vehicle =========
--Primary Attack:  Mouse Button 1
--Secondary Attack:  Mouse Button 2
--Lock Target:  Q, Mouse Button 4
--Boost:  SHIFT, RIGHT SHIFT
--Jump:  SPACE, NUM 0
--Droideka Deploy:  C, RIGHT CTRL
--Zoom:  Z, Mouse Button 3
--Droideka View:  V, END
--Reload:  R, DELETE
--Exit Vehicle:  E, ENTER
--Next Position:  1, Mouse Wheel Up
--Previous Position:  2, Mouse Wheel Down
--Move Right/Left Axis:  << None >>
--Move Forward/Back Axis:  << None >>
--Look Right/Left Axis:  Mouse X Axis
--Look Up/Down Axis:  Mouse Y Axis
--Move Right:  D, RIGHT
--Move Left:  A, LEFT
--Move Forward:  W, UP
--Move Back:  S, DOWN
--Look Right:  << None >>
--Look Left:  << None >>
--Look Up:  << None >>
--Look Down:  << None >>
--Accept:  PAGE UP, F1
--Decline:  PAGE DOWN, F2
--Player List:  TAB, \
--Chat:  T
--Team Chat:  Y
--Squad Commands:  F4, NUM 4
--Communications - Spotted:  F5
--Communications - Medic:  F6
--Communications - Repair:  F7
--Communications - Ammo:  F8
--Communications - Pickup:  F9
--Communications - Backup:  F10
--Communications - Attack:  F11
--Communications - Defend:  F12
--Show Map:  M

-- control mode 2 starfighter ===========
--Primary Attack:  Mouse Button 1
--Secondary Attack:  Mouse Button 2
--Lock Target:  Q, Mouse Button 4
--Boost:  SHIFT, RIGHT SHIFT
--Land/Takeoff:  SPACE, NUM 0
--Trick:  ALT, RIGHT CTRL
--Immelmann:  C, NUM 1
--Roll Lock:  CTRL, Mouse Button 3
--View:  V, END
--Reload:  R, DELETE
--Exit Starfighter:  E, ENTER
--Next Position:  1, Mouse Wheel Up
--Previous Position:  2, Mouse Wheel Down
--Roll Axis:  << None >>
--Throttle Increase/Decrease Axis:  << None >>
--Turn Right/Left Axis:  Mouse X Axis
--Pitch Up/Down Axis:  Mouse Y Axis
--Roll Clockwise:  D, RIGHT
--Roll Counterclockwise:  A, LEFT
--Increase Throttle:  W, UP
--Decrease Throttle:  S, DOWN
--Turn Right:  << None >>
--Turn Left:  << None >>
--Pitch Up:  << None >>
--Pitch Down:  << None >>
--Accept:  PAGE UP, F1
--Decline:  PAGE DOWN, F2
--Player List:  TAB, \
--Chat:  T
--Team Chat:  Y
--Squad Commands:  F4, NUM 4
--Communications - Spotted:  F5
--Communications - Medic:  F6
--Communications - Repair:  F7
--Communications - Ammo:  F8
--Communications - Pickup:  F9
--Communications - Backup:  F10
--Communications - Attack:  F11
--Communications - Defend:  F12
--Show Map:  M

-- control mode 3 Jedi (or anyone with a melee weapon) ==========
--Lightsaber Attack:  Mouse Button 1
--Lightsaber Block:  F, Mouse Button 3
--Use Force Power:  Mouse Button 2
--Switch Force Power:  1, Mouse Wheel Up
--Lock Target:  Q, Mouse Button 4
--Jedi Sprint:  SHIFT, RIGHT SHIFT
--Force Jump:  SPACE, NUM 0
--Crouch:  C, RIGHT CTRL
--Roll:  ALT, NUM 1
--Enter/Use:  E, ENTER
--Move Right/Left Axis:  << None >>
--Move Forward/Back Axis:  << None >>
--Look Right/Left Axis:  Mouse X Axis
--Look Up/Down Axis:  Mouse Y Axis
--Move Right:  D, RIGHT
--Move Left:  A, LEFT
--Move Forward:  W, UP
--Move Back:  S, DOWN
--Look Right:  << None >>
--Look Left:  << None >>
--Look Up:  << None >>
--Look Down:  << None >>
--Accept:  PAGE UP, F1
--Decline:  PAGE DOWN, F2
--Player List:  TAB, \
--Chat:  T
--Team Chat:  Y
--Squad Commands:  F4, NUM 4
--Communications - Spotted:  F5
--Communications - Medic:  F6
--Communications - Repair:  F7
--Communications - Ammo:  F8
--Communications - Pickup:  F9
--Communications - Backup:  F10
--Communications - Attack:  F11
--Communications - Defend:  F12
--Show Map:  M

-- controlMode 4 turret =========
--Attack:  Mouse Button 1
--Lock Target:  Q, Mouse Button 4
--Zoom:  Z, Mouse Button 3
--Zoom In/Out Axis:  << None >>
--Zoom In:  W, UP
--Zoom Out:  S, DOWN
--Exit Turret:  E, ENTER
--Next Position:  1, Mouse Wheel Up
--Previous Position:  2, Mouse Wheel Down
--Look Right/Left Axis:  Mouse X Axis
--Look Up/Down Axis:  Mouse Y Axis
--Look Right:  D, RIGHT
--Look Left:  A, LEFT
--Look Up:  << None >>
--Look Down:  << None >>
--Accept:  PAGE UP, F1
--Decline:  PAGE DOWN, F2
--Player List:  TAB, \
--Chat:  T
--Team Chat:  Y
--Squad Commands:  F4, NUM 4
--Communications - Spotted:  F5
--Communications - Medic:  F6
--Communications - Repair:  F7
--Communications - Ammo:  F8
--Communications - Pickup:  F9
--Communications - Backup:  F10
--Communications - Attack:  F11
--Communications - Defend:  F12

-- need to "un-unicode" strings, and put them in this table
-- trim white space and split by comma
local pckeyboard_controls_cleaned = {}
-- it will look like this
-- 0 is the controlMode for soldier
-- pckeyboard_controls_cleaned[0] = {
--    ["Sprint"] = {"SHIFT", "RIGHT SHIFT" },
--    ["Jump"] = { "SPACE", "NUM 0"},
--    ["Crouch"] = { keyStr = "C", "RIGHT CTRL" }
-- }


-- Mapping of common PC game control keys to key enums
-- TODO only for English now
-- for another language be my guest x)
-- eventually can fix with: gLangStr,gLangEnum = ScriptCB_GetLanguage()
--
-- KNOWN BUG the numpad have the same key as the number row.
-- But they are different inputs. in default bindings, "NUM 0" is Jump but "0" is not
-- This does not handle mouse clicks
local keyEnumMapping = {
    --["MOUSE BUTTON 1"] = 1, -- mouse is not captured this way
    --["MOUSE BUTTON 2"] = 2,
    --["MOUSE BUTTON 3"] = 3,
    --["MOUSE BUTTON 4"] = 4,
    --["MOUSE BUTTON 5"] = 5,
    --["MOUSE WHEEL UP"] = 6,
    --["MOUSE WHEEL DOWN"] = 7,
    ["BACKSPACE"] = 8,
    ["TAB"] = 9,
    ["ENTER"] = 13,
    ["PAUSE"] = 19,
    ["CAPS LOCK"] = -58,
    ["ESCAPE"] = 27,
    ["SPACE"] = 32,
    ["PAGE UP"] = 33,
    ["PAGE DOWN"] = 34,
    ["END"] = 35,
    ["HOME"] = 36,
    ["LEFT"] = -203,
    ["UP"] = -200,
    ["RIGHT"] = -205,
    ["DOWN"] = -208,
    ["DELETE"] = -211,
    ["0"] = 48,
    ["1"] = 49,
    ["2"] = 50,
    ["3"] = 51,
    ["4"] = 52,
    ["5"] = 53,
    ["6"] = 54,
    ["7"] = 55,
    ["8"] = 56,
    ["9"] = 57,
    ["A"] = 65,
    ["B"] = 66,
    ["C"] = 67,
    ["D"] = 68,
    ["E"] = 69,
    ["F"] = 70,
    ["G"] = 71,
    ["H"] = 72,
    ["I"] = 73,
    ["J"] = 74,
    ["K"] = 75,
    ["L"] = 76,
    ["M"] = 77,
    ["N"] = 78,
    ["O"] = 79,
    ["P"] = 80,
    ["Q"] = 81,
    ["R"] = 82,
    ["S"] = 83,
    ["T"] = 84,
    ["U"] = 85,
    ["V"] = 86,
    ["W"] = 87,
    ["X"] = 88,
    ["Y"] = 89,
    ["Z"] = 90,
    ["a"] = 97,
    ["b"] = 98,
    ["c"] = 99,
    ["d"] = 100,
    ["e"] = 101,
    ["f"] = 102,
    ["g"] = 103,
    ["h"] = 104,
    ["i"] = 105,
    ["j"] = 106,
    ["k"] = 107,
    ["l"] = 108,
    ["m"] = 109,
    ["n"] = 110,
    ["o"] = 111,
    ["p"] = 112,
    ["q"] = 113,
    ["r"] = 114,
    ["s"] = 115,
    ["t"] = 116,
    ["u"] = 117,
    ["v"] = 118,
    ["w"] = 119,
    ["x"] = 120,
    ["y"] = 121,
    ["z"] = 122,
    ["NUM 0"] = 48,
    ["NUM 1"] = 49,
    ["NUM 2"] = 50,
    ["NUM 3"] = 51,
    ["NUM 4"] = 52,
    ["NUM 5"] = 53,
    ["NUM 6"] = 54,
    ["NUM 7"] = 55,
    ["NUM 8"] = 56,
    ["NUM 9"] = 57,
    ["NUM LOCK"] = 144,
    ["SCROLL LOCK"] = 145,
    ["SHIFT"] = -42,
    ["RIGHT SHIFT"] = -54,
    ["CTRL"] = -29,
    ["STRG"] = -29, --german
    ["RIGHT CTRL"] = -157,
    ["ALT"] = -56,
    ["RIGHT ALT"] = -184,
    ["ALT GR"] = -184, --german
    ["-"] = 45,
    ["="] = 61,
    ["_"] = 95,
    ["["] = 91,
    ["]"] = 93,
    [";"] = 59,
    ["'"] = 39,
    ["/"] = 47,
    [","] = 44,
    ["."] = 46,
    ["!"] = 33,
    ["\""] = 34,
    ["#"] = 35,
    ["$"] = 36,
    [""] = 37,
    ["&"] = 38,
    ["'"] = 39,
    ["("] = 40,
    [")"] = 41,
    ["*"] = 42,
    ["+"] = 43,
    [","] = 44,
    ["."] = 46,
    ["/"] = 47,
    [":"] = 58,
    ["<"] = 60,
    ["="] = 61,
    [">"] = 62,
    ["?"] = 63,
    ["@"] = 64,
    ["["] = 91,
    ["\\"] = 92,
    ["]"] = 93,
    ["^"] = 94,
    ["`"] = 96,
    ["{"] = 123,
    ["|"] = 124,
    ["}"] = 125,
    ["~"] = 126
}

-- what if you hold a button while sprinting?
-- or have caps lock? it will get shifted
local unshiftKeys = {
    ["!"] = "1",
    ["@"] = "2",
    ["#"] = "3",
    ["$"] = "4",
    ["%"] = "5",
    ["^"] = "6",
    ["&"] = "7",
    ["*"] = "8",
    ["("] = "9",
    [")"] = "0",
    ["_"] = "-",
    ["+"] = "=",
    ["{"] = "[",
    ["}"] = "]",
    [":"] = ";",
    ["\""] = "'",
    ["<"] = ",",
    [">"] = ".",
    ["?"] = "/",
    ["|"] = "\\",
    ["~"] = "`",
    ["A"] = "a",
    ["B"] = "b",
    ["C"] = "c",
    ["D"] = "d",
    ["E"] = "e",
    ["F"] = "f",
    ["G"] = "g",
    ["H"] = "h",
    ["I"] = "i",
    ["J"] = "j",
    ["K"] = "k",
    ["L"] = "l",
    ["M"] = "m",
    ["N"] = "n",
    ["O"] = "o",
    ["P"] = "p",
    ["Q"] = "q",
    ["R"] = "r",
    ["S"] = "s",
    ["T"] = "t",
    ["U"] = "u",
    ["V"] = "v",
    ["W"] = "w",
    ["X"] = "x",
    ["Y"] = "y",
    ["Z"] = "z"
}

-- check if a given key corresponds to a specific action
-- For now this only works in English
-- for actionStr, look at the table at the top of this file
-- examples: "Jump" "Crouch" "Sprint" "Enter/Use"
local isActionKey = function(keyPressed, actionStr)

    -- solider, vehicle, flyer, jedi, turret
    --TODO, can we check this less often? maybe in the Update function
    local controlMode = ScriptCB_GetControlMode()

    if controlMode then
        -- Find the entry corresponding to the provided action string
        local keys = pckeyboard_controls_cleaned[controlMode][actionStr]

        -- check if the key you are pressing matches one of the keys for that action
        if keys then
            for num, keyName in keys do

                --print("for action " .. tostring(actionStr))
                --print("keyPressed '" .. tostring(keyPressed) ..
                --		"' mapped Key '" .. tostring(keyEnumMapping[keyName]) .. "' keyName '" .. tostring(keyName) .. "'" )
                if keyEnumMapping[keyName] ~= nil and
                        (keyEnumMapping[keyName] == keyPressed
                                -- if you are holding down shift or have caps lock
                                or keyEnumMapping[unshiftKeys[keyName]] == keyPressed) then
                    --print("matched " .. tostring(actionStr))
                    return true
                end
            end
        end
    end

    return false
end

-- just tell if a key was pressed
local function isKey(keyPressed, keyName)

    -- upper case key string
    keyName = string.upper(keyName)

    if keyEnumMapping[keyName] == keyPressed
            --if holding shift
            or keyEnumMapping[unshiftKeys[keyName]] == keyPressed
    then
        return true
    end

    return false
end

-- just another way to do it. might be faster for some keys??
-- might not even be faster.... falls back on other function
local function isKeyFast(keyPressed, keyName)

    local success, keyChar = pcall(function()
        return string.char(keyPressed)
    end)
    -- will not succeed for SHIFT, CTRL, ALT
    if success then
        keyName = string.upper(keyName)
        keyChar = string.upper(keyChar)

        return keyName == keyChar or
            unshiftKeys[keyChar] == keyName
    else
        --could do this, but too lazy
        --local bShift, bCtrl = ScriptCB_GetKeyboardPCFlags()
        return isKey(keyPressed, keyName)
    end
end


-- split("a,b,c", ",") => {"a", "b", "c"}
local function splitString(input, delimiter)
    local result = {}
    local startIndex = 1
    local endIndex = 1

    while endIndex do
        startIndex, endIndex = string.find(input, delimiter, startIndex)

        if startIndex then
            local substr = string.sub(input, 1, startIndex - 1)
            table.insert(result, substr)
            input = string.sub(input, endIndex + 1)
            startIndex = 1
        else
            table.insert(result, input)
        end
    end

    return result
end

-- "Sprint: " -> "Sprint"
local function trimWhitespaceAndColon(input)
    local _, i = string.find(input, "^%s*")
    local _, j = string.find(input, "%s*$")
    local trimmed = string.sub(input, i + 1, j - 1)
    -- Trim trailing ":"
    if string.sub(trimmed, -1) == ":" then
        trimmed = string.sub(trimmed, 1, -2)
    end
    return trimmed
end

-- printControls(ifs_opt_pckeyboard_listbox_contents)
local function printControls(controlsTable)
    for k, v in controlsTable do
        print(ScriptCB_ununicode(v.actionStr) .. " " .. ScriptCB_ununicode(v.keyStr))
    end
end

-- when you enter this screen, generate a table of the controls from C,
-- then clean it up and put it into another table we can use
local function populateControlsTable()

    if table.getn(pckeyboard_controls_cleaned) == 0 then

        local startingControlMode = ScriptCB_GetControlMode()

        for controlMode = 0, 4 do

            pckeyboard_controls_cleaned[controlMode] = {}

            ScriptCB_SetControlMode(controlMode)
            ScriptCB_GetKeyBoardCmds()
            -- this populates ifs_opt_pckeyboard_listbox_contents
            -- with keyboard controls
            -- solider, vehicle, flyer, jedi, turret

            for num, entry in ifs_opt_pckeyboard_listbox_contents do

                local keysString = ScriptCB_ununicode(entry.keyStr)

                local keys = {}
                keys = splitString(keysString, ", ")

                local actionStr = ScriptCB_ununicode(entry.actionStr)
                --remove trailing spaces and ":" char
                actionStr = trimWhitespaceAndColon(actionStr)

                pckeyboard_controls_cleaned[controlMode][actionStr] = keys
            end

        end
        --give regular control back
        ScriptCB_SetControlMode(startingControlMode)
        --tprint(pckeyboard_controls_cleaned)
    end

end


ifs_mp_lobby_listbox_contents = {
    -- Filled in from C++ now. NM 8/7/03
    -- Stubbed to show the string.format it wants.
    --  { indexstr = "1", namestr = "Alpha"},
    --  { indexstr = "2", namestr = "Bravo"},
}

-- get the localized strings for the controls we want
-- check ifs_opt_controller_vehunit.lua for these strings

local enterUseControl = ScriptCB_ununicode(ScriptCB_getlocalizestr("ifs.controls.General.Enter"))
local landControl = ScriptCB_ununicode(ScriptCB_getlocalizestr("ifs.controls.General.Land_Takeoff"))
--local crouchControl = ScriptCB_ununicode(ScriptCB_getlocalizestr("ifs.controls.General.Crouch"))

local function printBtn(btnLocalizedString)
    print("button " .. tostring(btnLocalizedString) .. " " .. tostring(ScriptCB_ununicode(ScriptCB_getlocalizestr(btnLocalizedString))))
end

-- this is the "Entry Point" of the code
-- The invisible IF screen that will capture the key inputs
ifs_ingame_keys = NewIFShellScreen {
    version = 1.0,
    nologo = 1,
    bAcceptIsSelect = 0,
    movieIntro = nil, -- played before the screen is displayed
    movieBackground = nil, -- played while the screen is displayed
    bDimBackdrop = nil,
    bNohelptext_backPC = 1,

    --called when the screen starts
    Enter = function(this, bFwd)
        print("entered ingame key screen ============")
        --remove cursor
        ScriptCB_EnableCursor(nil)

        --get the current configured controls
        populateControlsTable()

        -- if they change the controls mid-way through the game, tough luck
        -- can fix if you really want to.. by overriding the opt_controls exit screen
    end,

    --called when the screen closes
    Exit = function(this, bFwd)
        print("exited ingame keys screen ===========")
        ScriptCB_EnableCursor(true)
    end,

    --called continuously, every tick
    Update = function(this, fDt)
        ScriptCB_EnableCursor(nil)
    end,

    playerIsAlive = nil,
    keyCache = {},
    delay = 0.5, -- minimum second delay between key presses

    --the function that captures every key press on the keyboard
    Input_KeyDown = function(this, iKey)

        -- can only press button while alive!
        -- without this you can press during the death animation
        if this.playerIsAlive then

            local currentTime = ScriptCB_GetMissionTime()

            -- prevent spamming the key too much
            -- Check if the key is already in the cache and if the delay has passed
            if this.keyCache[iKey] == nil or currentTime - this.keyCache[iKey] >= this.delay then

                -- Update the cache with the current time
                this.keyCache[iKey] = currentTime

                --print(iKey)

                --enterUseControl is the localized string for the control
                if isActionKey(iKey, enterUseControl) then
                    print("pressed Enter/Use key")

                    --example of custom event
                    --see below for callback
                    TriggerPressUse("test1", "test2")
                    --2 params max
                end

                if isActionKey(iKey, landControl) then
                    print("pressed Land/Takeoff key")
                    -- do cool stuff here
                end

                if isKey(iKey, "f") then
                    print("pressed f")
                end

                if isKeyFast(iKey, "g") then
                    print("pressed g")
                end

            end
        end
    end
}

AddIFScreen(ifs_ingame_keys, "ifs_ingame_keys")


function addInGameKeyScreen()
    local screenTimer = CreateTimer("screenTimer")
    --SetTimerValue(screenTimer, 0.1)

    -- if I just tried to push the screen OnCharacterSpawn, then it exits right away
    -- start it after a small timer it stays open
    local myTimerResponse = OnTimerElapse(
            function(timer)
                --print("pushing screen after timer ===============")
                ScriptCB_PushScreen("ifs_ingame_keys")
            end,
            screenTimer
    )

    -- checking if the player is alive
    -- only makes sense in singleplayer
    -- I doubt the other stuff works in multiplayer either

    local charSpawn = OnCharacterSpawn(function(character)
        if IsCharacterHuman(character)
        then
            --print("player spawned =============")
            SetTimerValue(screenTimer, 0.1)
            StartTimer(screenTimer)
            ifs_ingame_keys.playerIsAlive = true
        end
    end)

    local charDeath = OnCharacterDeath(function(character)
        if IsCharacterHuman(character) then
            ifs_ingame_keys.playerIsAlive = nil
        end
    end)

    --example of a custom callback function
    CreateUserEvent("PressUse")

    local onUse = OnPressUse(
            function(first, second)
                print("pressed use event")
                print("params: " .. tostring(first) .. " " .. tostring(second))
            end
    )

    local onUseMatch = OnPressUseMatch(
            function(first, second)
                print("pressed use event MATCH")
                print("params: " .. tostring(first) .. " " .. tostring(second))
            end,
            "test1" -- must match first param in TriggerPressUse
    )

end

