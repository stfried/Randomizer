GoTo __main__


CreateGUI:
Gui +AlwaysOnTop
Gui, Add, Text, x2 y349 w250 h20 +Center, A Runic Sweller 2017
Gui, Add, Picture, x2 y-1 w250 h50 , bin\img\logo.png
Gui, Add, Text, x2 y49 w250 h20 +Center, Version 3.0
Gui, Add, Tab, x2 y69 w250 h280 , Actions|Config
Gui, Add, Button, x2 y99 w130 h30 gSingleRoulette, Single Roulette (Ctrl+Q)
Gui, Add, Button, x2 y129 w130 h30 gGagCycle, Gag Cycle (Ctrl+W)
Gui, Add, Button, x2 y249 w130 h30 gReCalibrate, Re-Calibrate
Gui, Add, Button, x2 y279 w130 h30 gReConfig, Re-Config
Gui, Add, Button, x2 y309 w130 h30 gReload, Reload
Gui, Add, Button, x2 y159 w130 h30 gStopCycling, Force Stop Cycle (Ctrl+E)
Gui, Tab, Config
Gui, Add, Text, x2 y99 w100 h20 , Minimum Gag Level
Gui, Add, Edit, x102 y99 w40 h20 , 
Gui, Add, UpDown, x122 y99 w20 h20 Range1-7 gMinLButton vMIN_LEVEL, %MIN_LEVEL%
Gui, Add, Text, x2 y119 w100 h20 , Max Gag Level
Gui, Add, Edit, x102 y119 w40 h20 , 
Gui, Add, UpDown, x122 y119 w20 h20 Range1-7 gMaxLButton vMAX_LEVEL, %MAX_LEVEL%
tracks := buildWhitelistedTracks()
Gui, Add, ListBox, x2 y159 w100 h100 +Multi +AltSubmit gUpdateTracks vGagTracks, %tracks%
Gui, Add, Text, x2 y139 w100 h20 , Gag Tracks
Gui, Add, Text, x102 y139 w100 h20 , Whitelisted Gags
Gui, Add, DropDownList, x102 y159 w100 h140 +AltSubmit gSetBoxes vDropTrack, Toonup||Trap|Lure|Sound|Throw|Squirt|Drop
g1 := isChecked(1,1)
g2 := isChecked(1,2)
g3 := isChecked(1,3)
g4 := isChecked(1,4)
g5 := isChecked(1,5)
g6 := isChecked(1,6)
g7 := isChecked(1,7)
Gui, Add, Text, x102 y199 w13 h10 +Center, 1
Gui, Add, Text, x122 y199 w13 h10 +Center, 2
Gui, Add, Text, x142 y199 w13 h10 +Center, 3
Gui, Add, Text, x162 y199 w13 h10 +Center, 4
Gui, Add, Text, x182 y199 w13 h10 +Center, 5
Gui, Add, Text, x202 y199 w13 h10 +Center, 6
Gui, Add, Text, x222 y199 w13 h10 +Center, 7
Gui, Add, CheckBox, x102 y179 w20 h20 gCheck vGag1 %g1%
Gui, Add, CheckBox, x122 y179 w20 h20 gCheck vGag2 %g2%
Gui, Add, CheckBox, x142 y179 w20 h20 gCheck vGag3 %g3%
Gui, Add, CheckBox, x162 y179 w20 h20 gCheck vGag4 %g4%
Gui, Add, CheckBox, x182 y179 w20 h20 gCheck vGag5 %g5%
Gui, Add, CheckBox, x202 y179 w20 h20 gCheck vGag6 %g6%
Gui, Add, CheckBox, x222 y179 w20 h20 gCheck vGag7 %g7%
Gui, Add, Button, x72 y309 w100 h30 gSave, Save
Gui, Add, Button, x102 y219 w70 h20 gWhitelistAll, Whitelist All
Gui, Add, Button, x172 y219 w70 h20 gBlacklistAll, Blacklist All
; Generated using SmartGUI Creator 4.0
Gui, Show, x0 y0 h373 w254, Gag Randomizer v3.0
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
return

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
    MsgBox % BLACKLISTED_GAGS
}