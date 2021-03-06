init(forceR=0, forceC=0)
{
    FileRead, Contents, bin\coordinates.ini
    if (ErrorLevel or forceR)
    {
        MsgBox Setup required. Please have a battle menu ready.
        setup()
        FileRead, Contents, bin\coordinates.ini
    }
    parseCoords(Contents)
    FileRead, Contents, config.ini
    if (ErrorLevel or forceC)
    {
        MsgBox User settings not found. Importing defaults.
        config()
        FileRead, Contents, config.ini
    }
    parseConfig(Contents)
    calculateCoords()
    fillSOS()
    blacklistGags()
    ;Read whitelist
	FileRead, content, bin\twhitelist.dat
	Loop, parse, content, `n
	{
		whitelist[A_Index] := A_LoopField
	}
    ;Init char widths
    charWidthInit()
    ;Read shopkeepers
    FileRead, content, bin\shopkeepers.txt
	Loop, parse, content, `n
	{
		shopkeepers[A_Index] := A_LoopField
	}
    ;Read templates
    FileRead, content, bin\wordlists\templates.txt
    Loop, parse, content, `n
    {
        template := A_LoopField
        StringReplace,template,template,`n,,A
        StringReplace,template,template,`r,,A
        if (template != "")
            templates[A_Index] := template
    }
    ;Read wordlists
    categories := ["adjective", "cog", "cog-plural", "cog_type", "cog_type-plural", "gag", "gag-plural", "gag_track", "name", "noun", "noun-plural", "number", "sos_card", "species", "species-plural", "staff", "verb", "verbed", "verbing", "boss", "activity", "location"]
    Loop, % categories.length()
    {
        ;Read from category
        category := categories[A_Index]
        filename := "bin\wordlists\" . category . ".txt"
        FileRead, content, %filename%
        Loop, parse, content, `n
        {
            word := A_LoopField
            StringReplace,word,word,`n,,A
            StringReplace,word,word,`r,,A
            if (word != "")
                wordlists[category, A_Index] := word
        }
    }
    ;Reset whitelisted tracks in GUI
    buildWhitelistedTracks()
    if (forceR = 0 and forceC = 0)
    {
        createMenu()
        Gosub, CreateGUI
    }
}

reInit()
{
    global MIN_LEVEL := 1
    global MAX_LEVEL := 6
    global ALLOWED_TRACKS := []
    global BLACKLISTED_GAGS := ""
    global FIRE_CHANCE := 0
    global SOS_CHANCE := 0
    global PASS_CHANCE := 0
    global DOODLE_CHANCE := 0
    global RUNNING := 0
}

recalibrate()
{
    reInit()
    init(1)
    attemptReload()
}

reconfig()
{
    reInit()
    init(0, 1)
    attemptReload()
}

calculateCoords()
{
    ;Calculate x and y coords of each given row and column
    xCoords := []
    yCoords := []
    level := 1
    while level <= 7
    {
        ;GetCoords(Xc, Yc, Gags[THROW, level])
        xCoords[level] := Gags[THROW, level].coord.getX()
        level++
    }
    track := 1
    while track <= DROP
    {
        ;GetCoords(Xc, Yc, Coords[track, 0])
        yCoords[track] := Gags[track, 1].coord.getY()
        track++
    }
    fillCoords(xCoords, yCoords)
}

fillCoords(ByRef xCoords, ByRef yCoords)
{
    ;Fill entire table of gag coords
    track := TOONUP
    while track <= DROP
    {
        level := 1
        while level <= 7
        {
            temp := new Gag
            temp.setAll(track, level, xCoords[level], yCoords[track])
            Gags[track, level] := temp
            ;MouseMove, Gags[track,level].coord.getX(), Gags[track,level].coord.getY()
            ;MsgBox % Gags[track,level].pprint()
            ;KeyWait, Control
            ;KeyWait, Control, D
            level += 1
        }
        track += 1
    }
    
}

testCoords()
{
    track := TOONUP
    while track <= DROP
    {
        level := 1
        while level <= 7
        {
            MouseMove, Gags[track,level].coord.getX(), Gags[track,level].coord.getY()
            MsgBox % Gags[track,level].pprint()
            level += 1
        }
        track += 1
    }
}

whitelistAll()
{
    BLACKLISTED_GAGS := ""
    track := TOONUP
    while track <= DROP
    {
        level := 1
        while level <= 7
        {
            Gags[track,level].whitelist()
            level += 1
        }
        track += 1
    }
}

blacklistAll()
{
    BLACKLISTED_GAGS := ""
    track := TOONUP
    while track <= DROP
    {
        level := 1
        while level <= 7
        {
            Gags[track,level].blacklist()
            BLACKLISTED_GAGS := BLACKLISTED_GAGS " " track "," level
            level += 1
        }
        track += 1
    }
}

blacklistGags()
{
    Loop, Parse, BLACKLISTED_GAGS, %A_Space% 
    {
        C := []
        Loop, Parse, A_LoopField, `,
        {
            val := A_LoopField
            val += 0
            C.Insert(val)
        }
        if (C.Length() = 2)
        {
            Gags[C[1],C[2]].blacklist()
        }
    }
}