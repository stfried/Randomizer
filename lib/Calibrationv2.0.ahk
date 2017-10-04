setup()
{
    Input := Object()
    assignCoordinates(Input)  
}

parseCoords(ByRef Contents)
{
    ;Read the coordinates.ini
    Lines := Object()
    Loop, parse, Contents, `n
    {
        Lines[A_Index] := A_LoopField
    }
    line := 2
    readCoordinates(Lines, TOONUP, 1, line)
    readCoordinates(Lines, TRAP, 1, line)
    readCoordinates(Lines, LURE, 1, line)
    readCoordinates(Lines, SOUND, 1, line)
    readCoordinates(Lines, THROW, 1, line)
    readCoordinates(Lines, SQUIRT, 1, line)
    readCoordinates(Lines, DROP, 1, line)
    readCoordinates(Lines, THROW, 2, line)
    readCoordinates(Lines, THROW, 3, line)
    readCoordinates(Lines, THROW, 4, line)
    readCoordinates(Lines, THROW, 5, line)
    readCoordinates(Lines, THROW, 6, line)
    readCoordinates(Lines, THROW, 7, line)
    readCoordinates(Lines, EXTRA, 1, line)
    readCoordinates(Lines, EXTRA, 2, line)
    readCoordinates(Lines, EXTRA, 3, line)
    readCoordinates(Lines, TGETS, 1, line)
    readCoordinates(Lines, TGETS, 2, line)
    readCoordinates(Lines, TGETS, 3, line)
    
    Loop, 9
    {
        readCoordinates(Lines, SOS, A_Index, line)
    }

}

readCoordinates(ByRef Lines, track, level, ByRef line)
{
    ;Given the line number with the coordinates, assigns the x and y coords of a gag from file
    ;Coords[track, level] := Lines[line]
    getCoords(X, Y, Lines[line])
    temp := new Gag
    temp.coord.setX(X)
    temp.coord.setY(Y)
    temp.setTrack(track)
    temp.setLevel(level)
    Gags[track, level] := temp    
    line++
}

assignCoordinates(ByRef Input)
{
    ;Get user to calibrate positions
    ToolTip, Press control over the right side of the feather button.,0,0
    inputCoordinates(Input, TU, 0)
    ToolTip, Press control over the right side of the banana peel button.,0,0
    inputCoordinates(Input, TRAP, 0)
    ToolTip, Press control over the right side of the dollar bill button.,0,0
    inputCoordinates(Input, LURE, 0)
    ToolTip, Press control over the right side of the bike horn button.,0,0
    inputCoordinates(Input, SOUND, 0)
    ToolTip, Press control over the right side of the cupcake button.,0,0
    inputCoordinates(Input, THROW, 0)
    ToolTip, Press control over the right side of the squirting flower button.,0,0
    inputCoordinates(Input, SQUIRT, 0)
    ToolTip, Press control over the right side of the flower pot button.,0,0
    inputCoordinates(Input, DROP, 0)
    ToolTip, Press control over the right side of the fruit pie slice button.,0,0
    inputCoordinates(Input, THROW, 1)
    ToolTip, Press control over the right side of the cream pie slice button.,0,0
    inputCoordinates(Input, THROW, 2)
    ToolTip, Press control over the right side of the whole fruit pie button.,0,0
    inputCoordinates(Input, THROW, 3)
    ToolTip, Press control over the right side of the whole cream pie button.,0,0
    inputCoordinates(Input, THROW, 4)
    ToolTip, Press control over the right side of the birthday cake button.,0,0
    inputCoordinates(Input, THROW, 5)
    ToolTip, Press control over the right side of the wedding cake button.,0,0
    inputCoordinates(Input, THROW, 6)
    ToolTip, Press control over the fire button.,0,0
    inputCoordinates(Input, EXTRA, 0)
    ToolTip, Press control over the pass button.,0,0
    inputCoordinates(Input, EXTRA, 1)
    ToolTip, Press control over the SOS button.,0,0
    inputCoordinates(Input, EXTRA, 2)
    ToolTip, Press control over the top left corner of the red targeting menu.,0,0
    inputCoordinates(Input, TGETS, 0)
    ToolTip, Press control over the bottom right corner of the red targeting menu.,0,0
    inputCoordinates(Input, TGETS, 1)
    ToolTip, Press control over the back arrow that appears AFTER you have selected a target (if any).,0,0
    inputCoordinates(Input, TGETS, 2)
    ToolTip, Press control over the 1st SOS card on the TOP row's CALL button.,0,0
    inputCoordinates(Input, SOS, 1)
    ToolTip, Press control over the 2nd SOS card on the TOP row's CALL button.,0,0
    inputCoordinates(Input, SOS, 2)
    ToolTip, Press control over the 3rd SOS card on the TOP row's CALL button.,0,0
    inputCoordinates(Input, SOS, 3)
    ToolTip, Press control over the 4th SOS card on the TOP row's CALL button.,0,0
    inputCoordinates(Input, SOS, 4)
    ToolTip, Press control over the 1st SOS card on the BOTTOM row's CALL button.,0,0
    inputCoordinates(Input, SOS, 5)
    ToolTip, Press control over the down arrow.,0,0
    inputCoordinates(Input, SOS, 6)
    ToolTip, Press control over your doodle's name.,0,0
    inputCoordinates(Input, SOS, 7)
    ToolTip, Press control over the jump.,0,0
    inputCoordinates(Input, SOS, 8)
    ToolTip, Press control over the last trick your doodle has.,0,0
    inputCoordinates(Input, SOS, 9)
    CoordToFile(Input)
}

coordToFile(ByRef Input)
{
    ;Write to file
    FileDelete, bin\coordinates.ini
    FileAppend, #Base Coordinate`n, bin\coordinates.ini
    FileAppend, % Input[TU,0,0]","Input[TU,0,1]"`n", bin\coordinates.ini
    FileAppend, % Input[TRAP,0,0]","Input[TRAP,0,1]"`n", bin\coordinates.ini
    FileAppend, % Input[LURE,0,0]","Input[LURE,0,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SOUND,0,0]","Input[SOUND,0,1]"`n", bin\coordinates.ini
    FileAppend, % Input[THROW,0,0]","Input[THROW,0,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SQUIRT,0,0]","Input[SQUIRT,0,1]"`n", bin\coordinates.ini
    FileAppend, % Input[DROP,0,0]","Input[DROP,0,1]"`n", bin\coordinates.ini
    FileAppend, % Input[THROW,1,0]","Input[THROW,1,1]"`n", bin\coordinates.ini
    FileAppend, % Input[THROW,2,0]","Input[THROW,2,1]"`n", bin\coordinates.ini
    FileAppend, % Input[THROW,3,0]","Input[THROW,3,1]"`n", bin\coordinates.ini
    FileAppend, % Input[THROW,4,0]","Input[THROW,4,1]"`n", bin\coordinates.ini
    FileAppend, % Input[THROW,5,0]","Input[THROW,5,1]"`n", bin\coordinates.ini
    FileAppend, % Input[THROW,6,0]","Input[THROW,6,1]"`n", bin\coordinates.ini
    FileAppend, % Input[EXTRA,0,0]","Input[EXTRA,0,1]"`n", bin\coordinates.ini
    FileAppend, % Input[EXTRA,1,0]","Input[EXTRA,1,1]"`n", bin\coordinates.ini
    FileAppend, % Input[EXTRA,2,0]","Input[EXTRA,2,1]"`n", bin\coordinates.ini
    FileAppend, % Input[TGETS,0,0]","Input[TGETS,0,1]"`n", bin\coordinates.ini
    FileAppend, % Input[TGETS,1,0]","Input[TGETS,1,1]"`n", bin\coordinates.ini
    FileAppend, % Input[TGETS,2,0]","Input[TGETS,2,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SOS,1,0]","Input[SOS,1,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SOS,2,0]","Input[SOS,2,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SOS,3,0]","Input[SOS,3,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SOS,4,0]","Input[SOS,4,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SOS,5,0]","Input[SOS,5,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SOS,6,0]","Input[SOS,6,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SOS,7,0]","Input[SOS,7,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SOS,8,0]","Input[SOS,8,1]"`n", bin\coordinates.ini
    FileAppend, % Input[SOS,9,0]","Input[SOS,9,1]"`n", bin\coordinates.ini
}

inputCoordinates(ByRef Input, track, level)
{
    ;Record user input positions
    KeyWait, Control
    KeyWait, Control, D
    MouseGetPos, xpos, ypos
    Input[track, level, 0] := xpos
    Input[track, level, 1] := ypos
    ToolTip
}

parseConfig(Contents)
{
    Lines := Object()
    Loop, parse, Contents, `n
    {
        Lines[A_Index] := A_LoopField
    }
    readVals(MIN_LEVEL, Lines[2])
    readVals(MAX_LEVEL, Lines[3])
    readVals(tracks, Lines[5], "False")
    getTracks(tracks)
    readVals(BLACKLISTED_GAGS, Lines[9], "False")
    StringReplace, BLACKLISTED_GAGS, BLACKLISTED_GAGS, `r
    readVals(FIRE_CHANCE, Lines[11])
    readVals(SOS_CHANCE, Lines[13])
    readVals(PASS_CHANCE, Lines[15])
    f_c := 0
    p_c := 0
    s_c := 0
    
    if (FIRE_CHANCE > 0)
        f_c += FIRE_CHANCE
    p_c := f_c
    if (PASS_CHANCE > 0)
        p_c += PASS_CHANCE
    s_c := p_c
    if (SOS_CHANCE > 0)
        s_c += SOS_CHANCE 
    if (s_c > 100)
    {
        MsgBox ERROR: PASS, FIRE, AND SOS EXCEED 100`%`n PLEASE FIX YOUR CONFIG.
    }
    readVals(DOODLE_CHANCE, Lines[17])
}

readVals(ByRef val, line, is_num="True")
{
    C := []
    Loop, Parse, line, :,
    {
        C.Insert(A_LoopField)
    }
    val := C[2]
    if (is_num = "True")
        val += 0
}

getTracks(raw_text)
{
    IfInString, raw_text, TU
        ALLOWED_TRACKS.Insert(TOONUP)
    IfInString, raw_text, TR
        ALLOWED_TRACKS.Insert(TRAP)
    IfInString, raw_text, LU
        ALLOWED_TRACKS.Insert(LURE)
    IfInString, raw_text, SO
        ALLOWED_TRACKS.Insert(SOUND)
    IfInString, raw_text, TH
        ALLOWED_TRACKS.Insert(THROW)
    IfInString, raw_text, SQ
        ALLOWED_TRACKS.Insert(SQUIRT)
    IfInString, raw_text, DR
        ALLOWED_TRACKS.Insert(DROP)
}

config()
{
    FileDelete, config.ini
    FileAppend,
    (
#Gag levels are inclusive, eg. min and max levels will be used.
MIN_GAG_LEVEL: 1
MAX_GAG_LEVEL: 6
#Keep separated by pipelines. Format like TU|TR|LU|SO|TH|SQ|DR|
ALLOWED_TRACKS: TU|TR|LU|SO|TH|SQ|DR|
#Blacklisted gags. Provide coordinate pairs separated by commas and spaces, eg.
# 1,1 5,2 3,7
#This effectively blacklists feather, fruit pie slice, and presentation.
BLACKLISTED_GAGS: 
#Likelihood to fire instead of use a gag. Number between 0 and 100. -1 to be treated like a gag.
FIRE: 0
#Likelihood to SOS instead of use a gag. Number between 0 and 100. -1 to be treated like a gag.
SOS: 0
#Likelihood to pass instead of use a gag. Number between 0 and 100. -1 to be treated like a gag.
PASS: 0
#Likelihood to use your doodle instead of an SOS card. Number between 0 and 100. -1 to be treated equally with SOS cards.
Doodle: 100
    ), config.ini
}

config_to_file()
{
    tracks := ["TU", "TR", "LU", "SO", "TH", "SQ", "DR"]
    formatted := ""
    for idx, val in ALLOWED_TRACKS
    {
        formatted := formatted . tracks[val] "|"
    }

    FileDelete, config.ini
    FileAppend,
    (
#Gag levels are inclusive, eg. min and max levels will be used.
MIN_GAG_LEVEL: %MIN_LEVEL%
MAX_GAG_LEVEL: %MAX_LEVEL%
#Keep separated by pipelines. Format like TU|TR|LU|SO|TH|SQ|DR|
ALLOWED_TRACKS: %formatted%
#Blacklisted gags. Provide coordinate pairs separated by commas and spaces, eg.
# 1,1 5,2 3,7
#This effectively blacklists feather, fruit pie slice, and presentation.
BLACKLISTED_GAGS:%BLACKLISTED_GAGS%
#Likelihood to fire instead of use a gag. Number between 0 and 100. -1 to be treated like a gag.
FIRE: %FIRE_CHANCE%
#Likelihood to SOS instead of use a gag. Number between 0 and 100. -1 to be treated like a gag.
SOS: %SOS_CHANCE%
#Likelihood to pass instead of use a gag. Number between 0 and 100. -1 to be treated like a gag.
PASS: %PASS_CHANCE%
#Likelihood to use your doodle instead of an SOS card. Number between 0 and 100. -1 to be treated equally with SOS cards.
Doodle: %DOODLE_CHANCE%
    ), config.ini
}