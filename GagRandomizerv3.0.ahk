CoordMode, ToolTip, Screen
#Include lib\Calibrationv2.0.ahk
#Include lib\FindClick.ahk
#Include lib\Gag.ahk
#Include lib\Coordinate.ahk
#Include lib\Initialization.ahk
#Include lib\GagPicker.ahk
#Include lib\TargetPicker.ahk
#Include lib\Globals.ahk

init()

;DEBUG
^Q::
    chooseOneGag(1,1)
    chooseOneTarget(1)
    return

^W::
    cycleGags(1)
    return

;Stop repeating    
^E::
    RUNNING := 0
    return

;Force recalibrate
^R::
    recalibrate()
    

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return

StopCycling:
    SetTimer, StopCycling, Off
    RUNNING := 0
    return