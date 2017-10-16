goTo AfterMenu

MenuHandler:
menuHelper(A_ThisMenuItem)
return

createMenu()
{
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
}

menuHelper(menuitem)
{
    if (menuitem = "SingleRoulette")
    {
        chooseOneGag(0)
        return
    }
    if (menuitem = "GagCycle")
    {
        cycleGags()
        return
    }
    if (menuitem = "TestGags")
    {
        useable := countUseableGags()
        testGags(useable)
    }
    if (menuitem = "TestTargets")
    {
        targets := findTargets()
        testTargets(targets, 1)
    }
    if (menuitem = "Reload")
    {
        attemptReload()
    }
    if (menuitem = "Recalibrate")
    {
        MsgBox, 4, Recalibrate, Are you sure you want to recalibrate your coordinates?
        IfMsgBox Yes
            recalibrate()
    }
    if (menuitem = "Reconfig")
    {
        MsgBox, 4, Reconfig, Are you sure you want to reset your config file?
        IfMsgBox Yes
            reconfig()
    }
    if (menuitem = "Exit")
    {
        ExitApp
    }
}