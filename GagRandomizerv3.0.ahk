CoordMode, ToolTip, Screen
#Include lib\Globals.ahk
#Include lib\Calibrationv2.0.ahk
#Include lib\FindClick.ahk
#Include lib\Gag.ahk
#Include lib\Coordinate.ahk
#Include lib\Initialization.ahk
#Include lib\GagPicker.ahk
#Include lib\TargetPicker.ahk
#Include lib\Menu.ahk

AfterMenu:
#Include lib\Gui.ahk

__main__:

init()
blacklistGags()
createMenu()
buildWhitelistedTracks()
Gosub, CreateGUI

;DEBUG
^Q::
    Gosub SingleRoulette
    return

^W::
    Gosub GagCycle
    return

;Stop repeating    
^E::
    Gosub StopCycling
    return

;Bring up menu
^M::
    Menu, MainMenu, Show
    

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

SingleRoulette:
chooseOneGag(1,1)
chooseOneTarget(1)
return

GagCycle:
cycleGags()
return

StopCycling:
SetTimer, StopCycling, Off
RUNNING := 0
return

ReCalibrate:
recalibrate()
return

ReConfig:
reconfig()
return

Reload:
attemptReload()
return