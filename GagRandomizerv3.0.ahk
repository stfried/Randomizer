CoordMode, ToolTip, Screen
#Include lib\Calibrationv2.0.ahk
#Include lib\FindClick.ahk
#Include lib\Gag.ahk
#Include lib\Coordinate.ahk
#Include lib\Initialization.ahk
#Include lib\GagPicker.ahk
#Include lib\TargetPicker.ahk
#Include lib\Globals.ahk

Menu, ActionMenu, Add, SingleRoulette, MenuHandler
Menu, ActionMenu, Add, GagCycle, MenuHandler
Menu, ActionMenu, Icon, SingleRoulette, bin\ico\cupcake.ico,, 0
Menu, ActionMenu, Icon, GagCycle, bin\ico\flower.ico,, 0
Menu, DebugMenu, Add, TestGags, MenuHandler
Menu, DebugMenu, Icon, TestGags, bin\ico\feather.ico,, 0
Menu, DebugMenu, Add, TestTargets, MenuHandler
Menu, DebugMenu, Icon, TestTargets, bin\ico\horn.ico,, 0
Menu, MainMenu, Add, Actions, :ActionMenu
Menu, MainMenu, Icon, Actions, bin\ico\banana.ico,, 0
Menu, MainMenu, Add, Debug, :DebugMenu
Menu, MainMenu, Icon, Debug, bin\ico\cog.ico,, 0
Menu, MainMenu, Add
Menu, MainMenu, Add, Recalibrate, MenuHandler
Menu, MainMenu, Icon, Recalibrate, bin\ico\tom.ico,, 0
Menu, MainMenu, Add, Reconfig, MenuHandler
Menu, MainMenu, Icon, Reconfig, bin\ico\coach.ico,, 0
Menu, MainMenu, Add, Reload, MenuHandler
Menu, MainMenu, Icon, Reload, bin\ico\gun.ico,, 0
Menu, MainMenu, Add
Menu, MainMenu, Add, Exit, MenuHandler
Menu, MainMenu, Icon, Exit, bin\ico\sad.ico,, 0

init()

;DEBUG
^Q::
    chooseOneGag(1,1)
    chooseOneTarget(1)
    return

^W::
    cycleGags()
    return

;Stop repeating    
^E::
    RUNNING := 0
    return

;Bring up menu
^M::
    Menu, MainMenu, Show
    

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

StopCycling:
SetTimer, StopCycling, Off
RUNNING := 0
return
    
MenuHandler:
if (A_ThisMenuItem = "SingleRoulette")
{
    chooseOneGag(0,1)
    chooseOneTarget(1)
    return
}
if (A_ThisMenuItem = "GagCycle")
{
    cycleGags()
    return
}
if (A_ThisMenuItem = "TestGags")
{
    useable := countUseableGags()
    testGags(useable)
}
if (A_ThisMenuItem = "TestTargets")
{
    targets := findTargets()
    testTargets(targets, 1)
}
if (A_ThisMenuItem = "Reload")
{
    attemptReload()
}
if (A_ThisMenuItem = "Recalibrate")
{
    MsgBox, 4, Recalibrate, Are you sure you want to recalibrate your coordinates?
    IfMsgBox Yes
        recalibrate()
}
if (A_ThisMenuItem = "Reconfig")
{
    MsgBox, 4, Reconfig, Are you sure you want to reset your config file?
    IfMsgBox Yes
        reconfig()
}
if (A_ThisMenuItem = "Exit")
{
    ExitApp
}


return