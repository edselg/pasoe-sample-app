/* ABL Procedure for exercising ABL List  Collections API */

// Definitions
VAR PROGRESS.Collections.List<myClass> myClassList.
VAR Progress.Collections.IIterator<myClass> myIterator.

VAR myClass obj1 = NEW myClass("one"),
obj2 = NEW myClass("two"),
obj3 = NEW myClass("three"),
obj4 = NEW myClass("four").

// Create an instance with some initial capacity
myClassList = NEW PROGRESS.Collections.List<myClass>(INPUT 10).

// Add couple of elements to the list
myClassList:ADD(obj1).
myClassList:ADD(obj2).
myClassList:ADD(obj3).
myClassList:ADD(obj4).

MESSAGE "Is the List Empty? " myClassList:isEmpty.
MESSAGE "Number of elements in the list: " myClassList:COUNT SKIP. 

// Clearing the list
myclassList:CLEAR().

MESSAGE "Is the List Empty after performing Clear operation? " myClassList:isEmpty.
MESSAGE "Number of elements in the list: " myClassList:COUNT SKIP. 

// Add couple of elements to the list
myClassList:ADD(obj1).
myClassList:ADD(obj2).
myClassList:ADD(obj3).

// Removing an element located at position 3
myClassList:RemoveAt(3).

// Again add an element
myClassList:ADD(obj4).

MESSAGE "Is the List Empty after adding few elements? " myClassList:isEmpty.
MESSAGE "Number of elements in the list: " myClassList:COUNT SKIP. 

// Get all items in the list with an iterator
myIterator = myClassList:getIterator().

DO WHILE myIterator:movenext():
	MESSAGE "myIterator:CURRENT: " myIterator:CURRENT:MakeNoise().
END. 
