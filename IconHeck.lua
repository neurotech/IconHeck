ICONHECK_ACTIVE = false
ICONHECK_CURRENT_TARGET = ""

local ICONHECK_LOG_PREFIX = "|cffffad6a[|r|cffFFD783Icon|r|cffff2068Heck|r|cffffad6a]|r "

local ICONHECK_ICON_LIST = { 1, 2, 3, 4, 5, 6, 7, 8 }
local ICONHECK_ACTIVE_ICON_INDEX = 1

local function UnitIsInPartyOrRaid(unit)
  if (unit == UnitName("player")) then
    return true
  end

  if (UnitInParty(unit)) then
    return true
  end

  if (UnitInRaid(unit)) then
    return true
  end

  return false
end

local function SetIcon(unit)
  if ICONHECK_ACTIVE and UnitExists(unit) and UnitIsPlayer(unit) and UnitIsInPartyOrRaid(unit) then
    C_Timer.After(0.25, function()
      SetRaidTarget(unit, ICONHECK_ICON_LIST[ICONHECK_ACTIVE_ICON_INDEX])

      if ICONHECK_ACTIVE_ICON_INDEX >= #ICONHECK_ICON_LIST then
        ICONHECK_ACTIVE_ICON_INDEX = 1
      else
        ICONHECK_ACTIVE_ICON_INDEX = ICONHECK_ACTIVE_ICON_INDEX + 1
      end

      SetIcon(unit)
    end)
  end
end

local function ToggleIconHeck()
  if ICONHECK_ACTIVE then
    if UnitExists("target") then
      if UnitIsPlayer("target") and UnitIsInPartyOrRaid(GetUnitName("target", true)) then
        ICONHECK_CURRENT_TARGET = GetUnitName("target", true)
        print(ICONHECK_LOG_PREFIX .. 'Now |cff0eff7dactive|r!')

        SetRaidTarget(ICONHECK_CURRENT_TARGET, ICONHECK_ICON_LIST[ICONHECK_ACTIVE_ICON_INDEX])
        ICONHECK_ACTIVE_ICON_INDEX = ICONHECK_ACTIVE_ICON_INDEX + 1
        SetIcon(ICONHECK_CURRENT_TARGET)
      else
        print(ICONHECK_LOG_PREFIX .. "Not activating because you are not targeting another player in your party or raid.")
        ICONHECK_ACTIVE = false
      end
    else
      print(ICONHECK_LOG_PREFIX .. "Not activating because you do not have a target.")
      ICONHECK_ACTIVE = false
    end
  else
    print(ICONHECK_LOG_PREFIX .. 'Now |cffff0e40inactive|r.')
    C_Timer.After(1, function()
      SetRaidTarget(ICONHECK_CURRENT_TARGET, -1)
      ICONHECK_CURRENT_TARGET = ""
    end)
  end
end

SLASH_ICONHECK_TOGGLE1 = "/iconheck"

SlashCmdList["ICONHECK_TOGGLE"] = function(msg, editBox)
  ICONHECK_ACTIVE = not ICONHECK_ACTIVE
  ToggleIconHeck()
end
