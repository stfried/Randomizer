fillSOS()
{
    xVals := []
    yVals := []
    Loop, 4
    {
        xVals.Insert(Gags[SOS, A_Index].coord.getX())
    }
    yVals.Insert(Gags[SOS,1].coord.getY())
    yVals.Insert(Gags[SOS,5].coord.getY())
    y_index := 1
    while y_index <= 2
    {
        x_index := 1
        while x_index <= 4
        {
            temp := new Coordinate
            temp.setAll(xVals[x_index], yVals[y_index])
            SosCards.Insert(temp)
            x_index++
        }
        y_index++
    }
}

pickSOS()
{
    if (DOODLE_CHANCE != 0)
    {
        dc := 0
        if (DOODLE_CHANCE = -1)
            dc := 11
        else if (DOODLE_CHANCE > 0)
            dc := DOODLE_CHANCE 
            Random, chance, 1, 100
            if (chance <= dc)
            {
                doodleTrick()
                return "DOODLE"
            }
    }
    Random, presses, 0, 4
    MouseClick,, Gags[SOS,6].coord.getX(), Gags[SOS,6].coord.getY(), presses, MOUSE_SPEED
    Sleep 50
    Random, card, 1, 8
    while not isCardValid(SosCards[card])
    {
        card--
        if (card = 0)
        {
            doodleTrick()
            return
        }
    }
    MouseClick,, SosCards[card].getX(), SosCards[card].getY(),,MOUSE_SPEED
    return "SOS"
}

isCardValid(coord)
{
    PixelSearch Px, Py, coord.getX()-5, coord.getY()-5, coord.getX()+5, coord.getY()+5, RED, 20, FAST|RGB
    if ErrorLevel
        return 0
    return 1
}

testSOSCards()
{
    Loop, 8
    {
        if (isCardValid(SosCards[A_Index]))
            MouseMove, SosCards[A_Index].getX(), SosCards[A_Index].getY()
    }
}

doodleTrick()
{
    MouseClick,, Gags[SOS,7].coord.getX(), Gags[SOS,7].coord.getY()
    Sleep 50
    Random, y_c, Gags[SOS,8].coord.getY(), Gags[SOS,9].coord.getY()
    Sleep 50
    MouseClick,, Gags[SOS,8].coord.getX(), y_c,,MOUSE_SPEED
}