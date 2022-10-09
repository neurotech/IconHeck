ICONHECK_ACTIVE = false

local ICONHECK_ICON_LIST = { 1, 2, 3, 4, 5, 6, 7, 8 }
local ICONHECK_ACTIVE_ICON_INDEX = 1

local function SetIcon()
  if ICONHECK_ACTIVE then
    C_Timer.After(0.5, function()
      SetRaidTarget("target", ICONHECK_ICON_LIST[ICONHECK_ACTIVE_ICON_INDEX])

      if ICONHECK_ACTIVE_ICON_INDEX >= #ICONHECK_ICON_LIST then
        ICONHECK_ACTIVE_ICON_INDEX = 1
      else
        ICONHECK_ACTIVE_ICON_INDEX = ICONHECK_ACTIVE_ICON_INDEX + 1
      end

      SetIcon()
    end)
  end
end

local function ToggleIconHeck()
  if ICONHECK_ACTIVE then
    print('IconHeck is now |cff0eff7dactive|r')
    SetRaidTarget("target", ICONHECK_ICON_LIST[ICONHECK_ACTIVE_ICON_INDEX])
    ICONHECK_ACTIVE_ICON_INDEX = ICONHECK_ACTIVE_ICON_INDEX + 1
    SetIcon()
  else
    print('IconHeck is now |cffff0e40inactive|r')
  end
end

SLASH_ICONHECK_TOGGLE1 = "/iconheck"

SlashCmdList["ICONHECK_TOGGLE"] = function(msg, editBox)
  ICONHECK_ACTIVE = not ICONHECK_ACTIVE
  ToggleIconHeck()
end
