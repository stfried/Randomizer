Gui, Add, Text, x2 y349 w300 h20 +Center, A Runic Sweller 2017
Gui, Add, Picture, x2 y-1 w300 h50 , bin\img\logo.png
Gui, Add, Text, x2 y49 w300 h20 +Center, Version 3.0
Gui, Add, Tab, x2 y69 w300 h280 , Actions|Config|Help
Gui, Add, Button, x2 y99 w130 h30, Single Roulette (Ctrl+Q)
Gui, Add, Button, x2 y129 w130 h30, Gag Cycle (Ctrl+W)
Gui, Add, Button, x172 y99 w130 h30, Re-Calibrate
Gui, Add, Button, x172 y129 w130 h30, Re-Config
Gui, Add, Button, x172 y159 w130 h30, Reload
Gui, Add, Button, x2 y159 w130 h30, Force Stop Cycle (Ctrl+E)
Gui, Tab, Config
Gui, Add, Text, x2 y99 w100 h20 , Minimum Gag Level
Gui, Add, Edit, x102 y99 w40 h20 , 
Gui, Add, UpDown, x122 y99 w20 h20 Range1-7 vMinGagLevel, 1
Gui, Add, Text, x2 y119 w100 h20 , Max Gag Level
Gui, Add, Edit, x102 y119 w40 h20 , 
Gui, Add, UpDown, x122 y119 w20 h20 Range1-7 vMaxGagLevel, 6
Gui, Add, ListBox, x2 y159 w100 h100 +Multi vGagTracks, Toonup||Trap||Lure||Sound||Throw||Squirt||Drop||
Gui, Add, Text, x2 y139 w100 h20 , Gag Tracks
Gui, Add, Text, x102 y139 w100 h20 , Whitelisted Gags
Gui, Add, DropDownList, x102 y159 w100 h140 gReset, Toonup||Trap|Lure|Sound|Throw|Squirt|Drop
g1 := isChecked(1,1)
Gui, Add, CheckBox, x102 y179 w20 h20 gCheck vGag1 %g1%
Gui, Add, CheckBox, x122 y179 w20 h20 gCheck vGag2 Checked
Gui, Add, CheckBox, x142 y179 w20 h20 gCheck vGag3 Checked
Gui, Add, CheckBox, x162 y179 w20 h20 gCheck vGag4 Checked
Gui, Add, CheckBox, x182 y179 w20 h20 gCheck vGag5 Checked
Gui, Add, CheckBox, x202 y179 w20 h20 gCheck vGag6 Checked
Gui, Add, CheckBox, x222 y179 w20 h20 gCheck vGag7 Checked
Gui, Show, x125 y87 h373 w308, New GUI Window
return


isChecked(track, level)
{
    if (Gags[track, level].isWhitelisted())
        return "Checked"
    return ""
}