
unit QueueADT;

{ This unit implements a Queue ADT as a linked list.  Sam Scott, 1999 }

INTERFACE

{*************************** TYPE DEFINITIONS ***********************}

type
     Element = integer;
     NodePointer = ^QueueNode;
     QueueNode = record
		   Contents: Element;
		   Next: NodePointer;
		 end;
     Queue = record
	       First: NodePointer;
	       Last: NodePointer;
	     end;

 var
    MemCount: integer ;

{************** FORWARD DECLARATIONS ****************}

procedure CreateQ(var Q: Queue);
procedure DestroyQ(var Q: Queue);
function IsEmpty(Q: Queue):boolean;
function IsFull(Q: Queue):boolean;
procedure Enq(var Q: Queue; E: Element);
function Deq(var Q: Queue): Element;
procedure PrintQ(Q: Queue) ;
function memcheck: boolean;


IMPLEMENTATION

{*********** MEMORY MANAGEMENT ROUTINES - DO NOT CHANGE *************}

{ Use GetNode instead of "new" }
procedure GetNode(var Q: NodePointer);
begin
     new(Q);
     MemCount := MemCount + 1;
end;

{ Use ReturnNode instead of "dispose" }
procedure ReturnNode(var Q: NodePointer);
begin
     dispose(Q);
     MemCount := MemCount - 1;
end;

function MemCheck: boolean;
begin
     MemCheck := (MemCount = 0);
end;

{**************** BASIC QUEUE PROCESSING PROCEDURES *****************}

{ Procedure Create(Q)
 * Givens: Q is Queue header with both pointers (First, Last) uninitialized.
 * Modified: Q becomes the empty Queue. }

procedure CreateQ(var Q: Queue);
begin
     Q.First := NIL;
     Q.Last := NIL;
end;

{ Procedure Destroy(Q)
 * Givens: Q is the empty queue.
 * Modified: Q is destroyed.  }

procedure DestroyQ(var Q: Queue);
begin
end;

{ Function IsEmpty(Q)
 * Givens: Q is Queue header with both pointers (First, Last).
 * Returns: TRUE if Q is empty, FALSE otherwise }

function IsEmpty(Q: Queue):boolean;
begin
     IsEmpty := ((Q.First = NIL) AND (Q.Last = NIL));
end;

{ Function IsFull(Q)
 * Givens: Q is Queue header with both pointers (First, Last).
 * Returns: TRUE if Q is full, FALSE otherwise }

function IsFull(Q: Queue):boolean;
begin
     IsFull := FALSE ;
end;

{ procedure Enqueue(var Q: Queue; E: Element);
 * Givens: Q is a Queue (could be empty), E is the new Queue element to add.
 * Modified: a new node containing the E the new Queue element and is inserted into Q at the end.
 }
procedure Enq(var Q: Queue; E: Element);
var newnode: NodePointer;
begin
   GetNode(newnode) ;
   newnode^.Contents := E;
   newnode^.Next  := nil;
   if IsEmpty(Q) then
      Q.First := newnode
   else
      Q.Last^.Next := newnode;
   Q.Last  := newnode;
end ;

{ procedure Dequeue(var Q: Queue; var E: Element);
 * Givens: Q is a Queue (could be empty),
 * Modified: returns the first element of the Queue.
 *           Q no longer contains the first element in it,  Q also may become empty.
 }
function Deq(var Q: Queue): Element;
var
   tmpPointer : NodePointer;
begin
    if NOT(IsEmpty(Q)) then
       begin
       tmpPointer := Q.First;
       Q.First := Q.First^.Next;
       if Q.First = NIL then
          Q.Last := NIL;
       Deq := tmpPointer^.Contents;
       ReturnNode(tmpPointer);
       end
    else
       writeln('ERROR - dequeue from empty queue');
end;

procedure PrintQ(Q: Queue) ;
var
   temp : NodePointer ;
begin
     temp := Q.first ;
     while temp <> Nil do
     	BEGIN
     	write( temp^.contents, ' ' ) ;
     	temp := temp^.next
     	END; { while }
     writeln
end; { proc PrintQ }

{********************** INITIALIZATION CODE **********************}
begin
     memcount := 0
end.
