class Gag
{
    coord := new Coordinate
    track := 0
    level := 0
    whitelisted := 1
    
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
    
    setAll(t_in, l_in, x_in, y_in)
    {
        this.track := t_in
        this.level := l_in
        this.coord.setX(x_in)
        this.coord.setY(y_in)
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
