class Queue extends DLinkedList
{
	enqueue(data)
	{
		this.addLast(data)
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
	
}