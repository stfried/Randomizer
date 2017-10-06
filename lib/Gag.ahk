class Gag
{
    coord := new Coordinate
    track := 0
    level := 0
    whitelisted := 1
    singleTarget := 0
    
    getTrack()
    {
        return this.track
    }
    
    setTrack(val)
    {
        this.track := val
        this.track += 0
    }
    
    getLevel()
    {
        return this.level
    }
    
    setLevel(val)
    {
        this.level := val
        this.level += 0
    }
    
    isSingleTarget()
    {
        return this.singleTarget
    }
    
    setAll(t_in, l_in, x_in, y_in)
    {
        this.track := t_in
        this.level := l_in
        this.coord.setX(x_in)
        this.coord.setY(y_in)
        this.singleTarget := gagIsSingleTarget(this)
    }
    
    blacklist()
    {
        this.whitelisted := 0
    }
    
    whitelist()
    {
        this.whitelisted := 1
    }
    
    isWhitelisted()
    {
        return this.whitelisted
    }
    
    toggle()
    {
        this.whitelisted := not this.isWhitelisted()
        return this.whitelisted
    }
    
    pprint()
    {
        return % this.track " " this.level " " this.coord.getX() " " this.coord.getY() " " this.whitelisted
    }
    
    

}

gagIsSingleTarget(gag)
{
    if (gag.getTrack() != SOUND)
    {
        if (gag.getLevel() != 7)
        {
            if (gag.getTrack() = TOONUP or gag.getTrack() = LURE)
            {
                ;Is TU or Lure
                if (gag.getLevel() != 2 and gag.getLevel() != 4 and gag.getLevel() != 6)
                {
                    ;Is single target TU or Lure
                    return 1
                }
                ;Is multi-target TU or Lure
                return 0
            }
            else if (gag.getTrack() = EXTRA and gag.getLevel() = 2)
                return 0
            else
                return 1
        }
    }
    return 0
}

GAGS_TESTING()
{
    a := new Gag
    a.setTrack(5)
    a.setLevel(7)
    a.coord.setX(100)
    a.coord.setY(500)

    b := new Gag
    b.setTrack(2)
    b.setLevel(4)
    b.coord.setX(250)
    b.coord.setY(70)

    MsgBox % a.getTrack() " " a.getLevel() " " a.coord.getX() " " a.coord.getY()
    MsgBox % b.getTrack() " " b.getLevel() " " b.coord.getX() " " b.coord.getY()

    array := []
    array.Insert(a)
    array.Insert(b)

    for k, v in array
    {
        MsgBox % v.getTrack() " " v.getLevel() " " v.coord.getX() " " v.coord.getY()
    }



    m_array := []
    track := 1
    while track <= 7
    {
        level := 1
        while level <= 7
        {
            temp := new Gag
            temp.setAll(track, level, track+level, track-level)
            m_array[track, level] := temp
            level++
        }
        track++
    }

    track := 1
    while track <= 7
    {
        level := 1
        while level <= 7
        {
            MsgBox % m_array[track, level].pprint()
            level++
        }
        track++
    }

}
