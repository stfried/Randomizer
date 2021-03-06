GoTo __main__


CreateGUI:
Gui +AlwaysOnTop
Gui, Add, Text, x2 y349 w250 h20 +Center, A Runic Sweller 2017
Gui, Add, Picture, x2 y-1 w250 h50 , bin\img\logo-full.png
Gui, Add, Text, x2 y49 w250 h20 +Center, Version 3.2.0
Gui, Add, Tab, x2 y69 w250 h280 , Actions|Config|Gag Whitelist|
Gui, Add, Button, x2 y99 w110 h30 gSingleRoulette, Single Gag (Ctrl+Q)
Gui, Add, Button, x132 y99 w110 h30 gAnimatedRoulette, Roulette (Ctrl+R)
Gui, Add, Button, x2 y129 w110 h30 gGagCycle, Gag Cycle (Ctrl+W)
Gui, Add, Button, x132 y129 w110 h30 gStopCycling, Stop Cycle (Ctrl+E)
Gui, Add, Button, x2 y159 w110 h30 gSayMadlib, Random Chat (Ctrl+Y)
Gui, Add, Button, x132 y159 w110 h30 gSayRandom, Madlibs (Ctrl+M)
Gui, Add, Button, x2 y279 w110 h30 gReCalibrate, Re-Calibrate
Gui, Add, Button, x132 y279 w110 h30 gReConfig, Re-Config
Gui, Add, Button, x2 y309 w110 h30 gReload, Reload
Gui, Add, Button, x132 y309 w110 h30 gGuiClose, Exit


Gui, Tab, Config
Gui, Add, Text, x2 y99 w100 h20 , Minimum Gag Level
Gui, Add, Edit, x102 y99 w40 h20 +ReadOnly, 
Gui, Add, UpDown, x122 y99 w20 h20 Range1-7 gMinLButton vMIN_LEVEL, %MIN_LEVEL%
Gui, Add, Text, x2 y119 w100 h20 , Max Gag Level
Gui, Add, Edit, x102 y119 w40 h20 +ReadOnly, 
Gui, Add, UpDown, x122 y119 w20 h20 Range1-7 gMaxLButton vMAX_LEVEL, %MAX_LEVEL%
Gui, Add, Text, x2 y139 w100 h20 , Fire Chance
Gui, Add, Edit, x102 y139 w40 h20 +ReadOnly, 
Gui, Add, UpDown, x122 y139 w20 h20 Range-1-100 gChanceButtons vFIRE_CHANCE, %FIRE_CHANCE%
Gui, Add, Text, x2 y159 w100 h20 , Pass Chance
Gui, Add, Edit, x102 y159 w40 h20 +ReadOnly, 
Gui, Add, UpDown, x122 y159 w20 h20 Range-1-100 gChanceButtons vPASS_CHANCE, %PASS_CHANCE%
Gui, Add, Text, x2 y179 w100 h20 , SOS Chance
Gui, Add, Edit, x102 y179 w40 h20 +ReadOnly, 
Gui, Add, UpDown, x122 y179 w20 h20 Range-1-100 gChanceButtons vSOS_CHANCE, %SOS_CHANCE%
Gui, Add, Text, x2 y199 w100 h20 , Doodle Chance
Gui, Add, Edit, x102 y199 w40 h20 +ReadOnly, 
Gui, Add, UpDown, x122 y199 w20 h20 Range-1-100 gChanceButtons vDOODLE_CHANCE, %DOODLE_CHANCE%
Gui, Add, Text, x2 y219 w100 h20 , Gag Chat
checked := ""
if (GAG_CHAT)
    checked := "Checked"
Gui, Add, CheckBox, x55 y214 w20 h20 gChatCheck vGAG_CHAT %checked%,
Gui, Add, Button, x72 y309 w110 h30 gSave vSave1, Save


Gui, Tab, Gag Whitelist
tracks := buildWhitelistedTracks()
Gui, Add, ListBox, x2 y119 w100 h100 +Multi +AltSubmit gUpdateTracks vGagTracks, %tracks%
Gui, Add, Text, x2 y99 w100 h20 , Gag Tracks
Gui, Add, Text, x102 y99 w100 h20 , Whitelisted Gags
Gui, Add, DropDownList, x102 y119 w100 h140 +AltSubmit gSetBoxes vDropTrack, Toonup||Trap|Lure|Sound|Throw|Squirt|Drop

Gui, Add, Picture, x106 y143 w15 h15 vgImg1, bin\img\gags\1,1.png
Gui, Add, Picture, x126 y143 w15 h15 vgImg2, bin\img\gags\1,2.png
Gui, Add, Picture, x146 y143 w15 h15 vgImg3, bin\img\gags\1,3.png
Gui, Add, Picture, x166 y143 w15 h15 vgImg4, bin\img\gags\1,4.png
Gui, Add, Picture, x186 y143 w15 h15 vgImg5, bin\img\gags\1,5.png
Gui, Add, Picture, x206 y143 w15 h15 vgImg6, bin\img\gags\1,6.png
Gui, Add, Picture, x226 y143 w15 h15 vgImg7, bin\img\gags\1,7.png

g1 := isChecked(1,1)
g2 := isChecked(1,2)
g3 := isChecked(1,3)
g4 := isChecked(1,4)
g5 := isChecked(1,5)
g6 := isChecked(1,6)
g7 := isChecked(1,7)
Gui, Add, CheckBox, x107 y159 w20 h20 gCheck vGag1 %g1%, 
Gui, Add, CheckBox, x127 y159 w20 h20 gCheck vGag2 %g2%, 
Gui, Add, CheckBox, x147 y159 w20 h20 gCheck vGag3 %g3%, 
Gui, Add, CheckBox, x167 y159 w20 h20 gCheck vGag4 %g4%, 
Gui, Add, CheckBox, x187 y159 w20 h20 gCheck vGag5 %g5%, 
Gui, Add, CheckBox, x207 y159 w20 h20 gCheck vGag6 %g6%, 
Gui, Add, CheckBox, x227 y159 w20 h20 gCheck vGag7 %g7%, 
Gui, Add, Text, x107 y177 w13 h10 +Center, 1
Gui, Add, Text, x127 y177 w13 h10 +Center, 2
Gui, Add, Text, x147 y177 w13 h10 +Center, 3
Gui, Add, Text, x167 y177 w13 h10 +Center, 4
Gui, Add, Text, x187 y177 w13 h10 +Center, 5
Gui, Add, Text, x207 y177 w13 h10 +Center, 6
Gui, Add, Text, x227 y177 w13 h10 +Center, 7
Gui, Add, Button, x102 y189 w70 h20 gWhitelistAll, Whitelist All
Gui, Add, Button, x172 y189 w70 h20 gBlacklistAll, Blacklist All
Gui, Add, Button, x72 y309 w110 h30 gSave vSave2, Save


; Generated using SmartGUI Creator 4.0
Gui, Show, x0 y0 h373 w254, Gag Randomizer v3.0

watchwin = Gag Randomizer ; window title to watch.

coordmode, mouse, screen
GUI, Show, noactivate w254 h373, %watchwin%
increment := 90
winset, transparent, %increment%, %watchwin%
settimer, watchmouse, 10

return

ChatCheck:
Gui, Submit, NoHide
return

Check:
Gui, Submit, NoHide
if (A_GuiControl = "Gag1")
    checkBox(DropTrack, 1)
if (A_GuiControl = "Gag2")
    checkBox(DropTrack, 2)
if (A_GuiControl = "Gag3")
    checkBox(DropTrack, 3)
if (A_GuiControl = "Gag4")
    checkBox(DropTrack, 4)
if (A_GuiControl = "Gag5")
    checkBox(DropTrack, 5)
if (A_GuiControl = "Gag6")
    checkBox(DropTrack, 6)
if (A_GuiControl = "Gag7")
    checkBox(DropTrack, 7)
return

SetBoxes:
Gui, Submit, NoHide
g1 := Gags[DropTrack, 1].isWhitelisted()
g2 := Gags[DropTrack, 2].isWhitelisted()
g3 := Gags[DropTrack, 3].isWhitelisted()
g4 := Gags[DropTrack, 4].isWhitelisted()
g5 := Gags[DropTrack, 5].isWhitelisted()
g6 := Gags[DropTrack, 6].isWhitelisted()
g7 := Gags[DropTrack, 7].isWhitelisted()
GuiControl,,Gag1,%g1%
GuiControl,,Gag2,%g2%
GuiControl,,Gag3,%g3%
GuiControl,,Gag4,%g4%
GuiControl,,Gag5,%g5%
GuiControl,,Gag6,%g6%
GuiControl,,Gag7,%g7%
GuiControl,,gImg1, bin\img\gags\%DropTrack%,1.png
GuiControl,,gImg2, bin\img\gags\%DropTrack%,2.png
GuiControl,,gImg3, bin\img\gags\%DropTrack%,3.png
GuiControl,,gImg4, bin\img\gags\%DropTrack%,4.png
GuiControl,,gImg5, bin\img\gags\%DropTrack%,5.png
GuiControl,,gImg6, bin\img\gags\%DropTrack%,6.png
GuiControl,,gImg7, bin\img\gags\%DropTrack%,7.png
return

UpdateTracks:
Gui, Submit, NoHide
ALLOWED_TRACKS := []
Loop, parse, GagTracks, |
{
    val := A_LoopField
    val += 0
    ALLOWED_TRACKS.Insert(val)
}
return

MinLButton:
if (MIN_LEVEL > MAX_LEVEL)
    MIN_LEVEL := MAX_LEVEL
GuiControl,,MIN_LEVEL,%MIN_LEVEL%
return

MaxLButton:
if (MAX_LEVEL < MIN_LEVEL)
    MAX_LEVEL := MIN_LEVEL
GuiControl,,MAX_LEVEL,%MAX_LEVEL%
return

WhitelistAll:
whitelistAll()
Gosub, SetBoxes
return

BlacklistAll:
blacklistAll()
Gosub, SetBoxes
return

Save:
config_to_file()
if (A_GuiControl = "Save1")
{
    GuiControl,, Save1, Saved!
    SetTimer, Save1Timer, 3000
}
else
{
    GuiControl,, Save2, Saved!
    SetTimer, Save2Timer, 3000
}
return

Save1Timer:
SetTimer, Save1Timer, Off
GuiControl,, Save1, Save
return

Save2Timer:
SetTimer, Save2Timer, Off
GuiControl,, Save2, Save
return

GuiClose:
ExitApp

isChecked(track, level)
{
    if (Gags[track, level].isWhitelisted())
        return "Checked"
    return ""
}

buildWhitelistedTracks()
{
    tracks := ["Toonup|", "Trap|", "Lure|", "Sound|", "Throw|", "Squirt|", "Drop|"]
    result := ""
    for idx, val in ALLOWED_TRACKS
    {
        tracks[val] := tracks[val] "|"
    }
    for idx, val in tracks
    {
        result := result . val
    }
    return result
}

checkBox(track, level)
{
    formatted := track "," level
    if (Gags[track, level].toggle())
    {
        ;Whitelisted, need to remove blacklist from file
        StringReplace, BLACKLISTED_GAGS, BLACKLISTED_GAGS, %formatted%
    }
    else
    {
        ;Blacklisted, need to add to blacklist
        BLACKLISTED_GAGS := BLACKLISTED_GAGS " " formatted
    }
    ;MsgBox % BLACKLISTED_GAGS
}

watchmouse:
	winget, winhwd, id, %watchwin%
	mousegetpos,,, mposhwd,, 1

	if (mposhwd = winhwd)
	   goto, fadein
	else
	   goto, fadeout
return

fadein:
   while, increment < 256
    {
      winset, transparent, %increment%, %watchwin%
      increment+=15
      sleep, 1
    }
return

fadeout:
   while, increment > 125
    {
      winset, transparent, %increment%, %watchwin%
      increment-=5
      sleep, 1
    }
return

ChanceButtons:
    f_c := 0
    p_c := 0
    s_c := 0
    
    if (FIRE_CHANCE > 0)
        f_c := FIRE_CHANCE
    if (PASS_CHANCE > 0)
        p_c := PASS_CHANCE
    if (SOS_CHANCE > 0)
        s_c := SOS_CHANCE
    ;MsgBox % f_c + p_c + s_c
    if (f_c + p_c + s_c > 100)
    {
        if (A_GuiControl = "FIRE_CHANCE")
        {
            FIRE_CHANCE := 100 - p_c - s_c
            GuiControl,, FIRE_CHANCE, %FIRE_CHANCE%
        }
        else if (A_GuiControl = "PASS_CHANCE")
        {
            PASS_CHANCE := 100 - f_c - s_c
            GuiControl,, PASS_CHANCE, %PASS_CHANCE%
        }
        else if (A_GuiControl = "SOS_CHANCE")
        {
            SOS_CHANCE := 100 - f_c - p_c
            GuiControl,, SOS_CHANCE, %SOS_CHANCE%
        }
    }
    return