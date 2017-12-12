CoordMode, ToolTip, Screen
#Include lib\Globals.ahk
#Include lib\Calibrationv2.0.ahk
#Include lib\FindClick.ahk
#Include lib\Gag.ahk
#Include lib\Coordinate.ahk
#Include lib\Initialization.ahk
#Include lib\GagPicker.ahk
#Include lib\TargetPicker.ahk
#Include lib\SOS.ahk
#Include lib\Roulette.ahk
#Include lib\Chatter.ahk
#Include lib\Menu.ahk

AfterMenu:
#Include lib\Gui.ahk

__main__:

init()

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
;^M::
;    Menu, MainMenu, Show
;    return

^T::
    Gosub SayRandom
    return

^G::
	useable := countUseableGags()
	testGags(useable)
	return

^R::
    GoSub AnimatedRoulette
    return

^M::
    GoSub SayMadlib
    return
    

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

SingleRoulette:
IfWinExist, Toontown Rewritten
    WinActivate
chooseOneGag()
return

AnimatedRoulette:
IfWinExist, Toontown Rewritten
    WinActivate
chooseOneGag(1)
return

GagCycle:
IfWinExist, Toontown Rewritten
    WinActivate ;
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

SayRandom:
IfWinExist, Toontown Rewritten
    WinActivate
string := buildString()
Send % string
Sleep 100
Send {ENTER}
return

SayMadlib:
IfWinExist, Toontown Rewritten
    WinActivate
string := makeTemplate()
SendRaw % string
Sleep 100
;Send {ENTER}
return