class Stack extends DLinkedList
{
	enqueue(data)
	{
		this.addFirst(data)
	}
	
	dequeue()
	{
		this.removeFirst()
	}
	
	isEmpty()
	{
		if this.length = 0 
			return true
		else
			return false
	}
    
    pprint()
    {
        res := ""
        Loop, % this.length
            res := res . this.get(A_index) ", "
        return res
    }
	
}