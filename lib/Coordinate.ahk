class Coordinate
{
    xC := 0
    yC := 0
    
    getX()
    {
        return this.xC
    }
    
    getY()
    {
        return this.yC
    }
    
    setX(val)
    {
        this.xC := val
        this.xC += 0
    }
    
    setY(val)
    {
        this.yC := val
        this.yC += 0
    
    }
    
    setAll(x_in, y_in)
    {
        this.setX(x_in)
        this.setY(y_in)
    }

}