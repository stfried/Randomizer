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

^Q::
    chooseOneGag(1,1)
    return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return