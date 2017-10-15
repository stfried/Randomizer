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
#Include lib\Menu.ahk

AfterMenu:
#Include lib\Gui.ahk

__main__:

init()
blacklistGags()
charWidthInit()
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
    return

^A::
    Gosub SayRandom
    return
    

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

SingleRoulette:
IfWinExist, Toontown Rewritten
    WinActivate ;
chooseOneGag(1,1)
Sleep 50
chooseOneTarget(1)
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
    WinActivate ;
string := buildString()
Send %string%
Sleep 100
Send {ENTER}
return

charWidthInit()
{
    lowercase := [22, 24, 23, 24, 22, 18, 22, 24, 12, 12, 22, 10, 36, 22, 26, 24, 26, 16, 20, 18, 22, 24, 24, 22, 24, 22] ; abcdefghijklmnopqrstuvwxyz
    uppercase := [26, 28, 30, 28, 26, 24, 30, 30, 12, 18, 30, 20, 38, 28, 32, 28, 32, 28, 28, 24, 28, 26, 42, 26, 30, 24] ; ABCDEFGHIJKLMNOPQRSTUVWXYZ
    nums := [26, 14, 30, 28, 30, 28, 28, 24, 30, 30] ;  0123456789
    symbols1 := [20, 14, 14, 36, 20, 40, 10, 14, 14, 26, 38, 12, 20, 12, 22] ;    {SPACE}!"#$%'()*+,-./
    symbols2 := [16, 18, 34, 44, 34, 30, 44] ;    :{SEMICOLON}<=>?@
    symbols3 := [12, 20, 12, 32, 26, 14] ;    [/]^_`
    symbols4 := [20, 14, 20, 34] ;    {|}~
    
    ;In order, symbols1, nums, symbols2, uppercase, symbols3, lowercase, symbols4
    Loop, % symbols1.length()
    {
        CHAR_WIDTHS[Asc(" ") + A_Index - 1] := symbols1[A_Index]
    }
    Loop, % nums.length()
    {
        CHAR_WIDTHS[Asc("0") + A_Index - 1] := nums[A_Index]
    }
    Loop, % symbols2.length()
    {
        CHAR_WIDTHS[Asc(":") + A_Index - 1] := symbols2[A_Index]
    }
    Loop, % uppercase.length()
    {
        CHAR_WIDTHS[Asc("A") + A_Index - 1] := uppercase[A_Index]
    }
    Loop, % symbols3.length()
    {
        CHAR_WIDTHS[Asc("[") + A_Index - 1] := symbols3[A_Index]
    }
    Loop, % lowercase.length()
    {
        CHAR_WIDTHS[Asc("a") + A_Index - 1] := lowercase[A_Index]
    }
    Loop, % symbols4.length()
    {
        CHAR_WIDTHS[Asc("{") + A_Index - 1] := symbols4[A_Index]
    }
}

stringWidth(string)
{
    length := 0
    Loop, Parse, string
    {
        length += CHAR_WIDTHS[Asc(A_LoopField)]
    }
    return length
}

canAppend(ByRef length, ByRef lines, new_string)
{
    new_length := stringWidth(new_string)
    if (new_length > WINDOW_LEN)
        return -1
    if (length + new_length > WINDOW_LEN)
    {
        lines++
        length := new_length
        if (lines > 3)
            return 0
    }
    else
        length += new_length
    return 1
}

buildString()
{
    string := ""
    length := 0
    lines := 1
    Random, num_words, 1, 25
    Loop, % num_words
    {
        Random, line, 1, NUM_LINES
        FileReadLine, output, twhitelist.dat, %line%
        if ErrorLevel
            MsgBox ERROR
        output := output " "
        
        res := canAppend(length, lines, output)
        if (res = -1)
            continue
        else if (res = 0)
            break
        string := string . output
    }
    ; Try to append some punctuation
    string := RTrim(string)
    punct := " "
    Random, punct_chance, 1, 100
    if (punct_chance > 25 and punct_chance <= 50)
        punct := "."
    else if (punct_chance > 50 and punct_chance <= 75)
        punct := "!"
    else if (punct_chance > 75)
        punct := "?"
    string := string . punct
        
    return string
}