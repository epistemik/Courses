
unit a3unit;

{ This unit contains a sample solution to assignment 2 which has been expanded
  to allow AVL tree insertion.  The insert procedure has been modified to call
  a private procedure named "rebalance" that restores the AVL property.  This
  procedure updates the balance fields from the new node upwards and performs
  rotations if necessary.  The rotations are performed using the procedures
  "RotateClockwise" and "RotateCounterClockwise".

  Your job is to write the "Rebalance" procedure.
  See the code below for more details.

UPDATED: June 6, 1999 to fix the rebalancing in the rotation procedures }

interface

uses btadt;

{ ******************* TYPE DEFINITIONS ******************* }

type

{ Since we are using the BinaryTree ADT, all we have to do here is relate the
  main types for collections to the main types for binary trees. }

    collection_element = TreeElement;
    collection = BinaryTree;

procedure Create(var C:collection);
procedure Destroy(var C:collection);
function Size(C: collection): integer;
function Is_Empty(C:collection): boolean;
procedure Insert(var C:collection; V:collection_element);
procedure Delete (var C:collection; V: collection_element);
procedure Join(var C1: collection; var C2: collection);
procedure Print(C: collection);
function MemCheck: boolean;

implementation

{ ********************* Memory Management Stuff ******************** }

{Note that since all the memory management is done by BinTrADT, we
 just have to call the MemCheck_BT function here}

Function MemCheck;
begin
   MemCheck := MemCheck_BT
end;

{ ******************** COLLECTION IMPLEMENTATIONS ********************* }

{ Create(C)
     preconditions: C is undefined
     postconditions: C is the empty collection with storage allocated as needed. }
procedure Create(var C:collection);
{ Constant Time O(1) }
begin
   Create_Empty_BT(C);
end;

{ Destroy(C)
     preconditions: C is a defined collection
     postconditions: C' is undefined. All dynamically allocated memory }
procedure Destroy(var C:collection);
{ Linear Time O(n) }
begin
   Destroy_BT(C);
end;

{ Is_Empty(C)
     preconditions: C is a defined collection.
     postconditions: returns true if C is empty, false otherwise. }
function Is_Empty(C:collection): boolean;
{ Constant Time O(1) }
begin
   Is_Empty := Is_Empty_BT(C);
end;

{ Size(C)
     preconditions: C is a defined collection.
     postconditions: returns the number of elements in C. }
function Size(C: collection): integer;
{ Linear Time O(n) }
begin
   If Is_Empty(C) then
      Size := 0
   else
      Size := 1 + Size(LeftChild_BT(C))+ Size(RightChild_BT(C));
end;

{ PRIVATE Procedure RotateClockWise(Root)
   Pre: Root is the root of a subtree tree to be rotated
   Post: A single clockwise rotation has been performed using the Root as a pivot.
         If Root had a parent then the parent's child pointer is updated.
         If Root had no parent, then Root now points to the rotator.
         The Balance fields of the Pivot and Rotator are updated accordingly. }
Procedure RotateClockWise(var Root:BinaryTree);
var Pivot, PivotsParent, InsideSubtree, Rotator: BinaryTree;
    HasParent: Boolean;
    PivotSide: Direction;
begin
   Pivot := Root;
   Rotator := LeftChild_BT(Pivot);
   If Is_Empty_BT(Rotator) then
      writeln('ERROR - tried to rotate clockwise with no rotator')
   else begin

      { IDENTIFY THE RELEVANT NODES AND SUBTREES }
      PivotsParent := Parent_BT(Pivot);
      HasParent := not Is_Empty_BT(PivotsParent); { Remember whether or not the pivot had a parent}
      If HasParent then
         PivotSide := Which_Side_BT(Pivot); { Remember which side the pivot was on}

      InsideSubtree := RightChild_BT(Rotator);

      { STEPS 1 to 3 - PRUNE PIVOT, ROTATOR, and INSIDE SUBTREE }
      If HasParent then
         Prune_BT(Pivot);
      Prune_BT(Rotator);
      if not Is_Empty_BT(InsideSubtree) then
         Prune_BT(InsideSubtree);

      { STEPS 4 to 6 - REATTACH }
      if HasParent then
         Attach_BT(Rotator,PivotsParent,PivotSide)
      else
         Root := Rotator;  { If root had no parent, update the pointer instead }
      Attach_BT(InsideSubtree,Pivot,left);
      Attach_BT(Pivot,Rotator,right)
   end;

   { UPDATE BALANCE FIELDS OF PIVOT AND ROTATOR
    - this can be done based on the previous value of the rotator's balance field.
    The possible values are 1, 0, -1, and -2.  If the Rotator did have a balance
    of -2, then this must be the second rotation of a double rotation.
IMPORTANT - These rebalancing operations are not totally independent.
            I am assuming you are always doing the correct rotations.}
   If Get_Balance_Field_BT(Rotator) = -1 then begin
      If Get_Balance_Field_BT(Pivot) = -2 then begin  { NEW STUFF HERE }
         Set_Balance_Field_BT(Rotator,0);
         Set_Balance_Field_BT(Pivot,0)
      end else begin
         Set_Balance_Field_BT(Rotator,1);
         Set_Balance_Field_BT(Pivot,1);               { END NEW STUFF }
      end
   end else if Get_Balance_Field_BT(Rotator) = 1 then begin
      Set_Balance_Field_BT(Rotator,2);
      Set_Balance_Field_BT(Pivot,0)
   end else if Get_Balance_field_BT(Rotator) = 0 then begin
      if Get_Balance_Field_BT(Pivot) = 2 then begin     { NEW STUFF HERE }
         Set_Balance_Field_BT(Rotator,1);
         Set_Balance_Field_BT(Pivot,-1)
      end else begin
         Set_Balance_Field_BT(Rotator,1);
         Set_Balance_Field_BT(Pivot,0);                { END NEW STUFF }
      end
   end else begin { Must be the second of a double rotation }
      Set_Balance_Field_BT(Rotator,0);
      Set_Balance_Field_BT(Pivot,1);
   end
end;

{ PRIVATE Procedure RotateCounterClockwise(Root)
   Pre: Root is the root of a subtree tree to be rotated
   Post: A single counter-clockwise rotation has been performed using the Root
         as a pivot. If Root had a parent then the parent's child pointer is updated.
         If Root had no parent, then Root now points to the rotator.
         The Balance fields of the Pivot and Rotator are updated accordingly. }
Procedure RotateCounterClockWise(var Root:BinaryTree);
var Pivot, PivotsParent, InsideSubtree, Rotator: BinaryTree;
    HasParent: Boolean;
    PivotSide: Direction;
begin
   Pivot := Root;
   Rotator := RightChild_BT(Pivot);
   If Is_Empty_BT(Rotator) then
      writeln('ERROR - tried to rotate counter-clockwise with no rotator')
   else begin

      { IDENTIFY THE RELEVANT NODES AND SUBTREES }
      PivotsParent := Parent_BT(Pivot);
      HasParent := not Is_Empty_BT(PivotsParent); { Remember whether or not the pivot had a parent}
      If HasParent then
         PivotSide := Which_Side_BT(Pivot); { Remember which side the pivot was on}

      InsideSubtree := LeftChild_BT(Rotator);

      { STEPS 1 to 3 - PRUNE PIVOT, ROTATOR, and INSIDE SUBTREE }
      If HasParent then
         Prune_BT(Pivot);
      Prune_BT(Rotator);
      if not Is_Empty_BT(InsideSubtree) then
         Prune_BT(InsideSubtree);

      { STEPS 4 to 6 - REATTACH }
      if HasParent then
         Attach_BT(Rotator,PivotsParent,PivotSide)
      else
         Root := Rotator; { If root had no parent, update the pointer instead }
      Attach_BT(InsideSubtree,Pivot,right);
      Attach_BT(Pivot,Rotator,left)
   end;

   { UPDATE BALANCE FIELDS OF PIVOT AND ROTATOR
    - this can be done based on the previous value of the rotator's balance field.
    The possible values are 1, 0, -1, and 2.  If the Rotator did have a balance
    of 2, then this must be the second rotation of a double rotation.
IMPORTANT - These rebalancing operations are not totally independent.
            I am assuming you are always doing the correct rotations.}
   If Get_Balance_Field_BT(Rotator) = 1 then begin
      If Get_Balance_Field_BT(Pivot)=2 then begin  { NEW STUFF HERE }
         Set_Balance_Field_BT(Rotator,0);
         Set_Balance_Field_BT(Pivot,0)
      end else begin
         Set_Balance_Field_BT(Rotator,-1);
         Set_Balance_Field_BT(Pivot,-1)            { END NEW STUFF }
      end
   end else if Get_Balance_Field_BT(Rotator) = -1 then begin
      Set_Balance_Field_BT(Rotator,-2);
      Set_Balance_Field_BT(Pivot,0)
   end else if Get_Balance_Field_BT(Rotator) = 0 then begin
      if Get_Balance_Field_BT(Pivot) = 2 then begin  { NEW STUFF HERE }
         Set_Balance_Field_BT(Rotator,-1);
         Set_Balance_Field_BT(Pivot,1)
      end else begin
         Set_Balance_Field_BT(Rotator,-1);
         Set_Balance_Field_BT(Pivot,0);               { END NEW STUFF }
      end
   end else begin { Must be the second of a double rotation }
      Set_Balance_Field_BT(Rotator,0);
      Set_Balance_Field_BT(Pivot,-1);
   end
end;

{ PRIVATE Procedure Rebalance(NewNode, Root)
   pre: NewNode is a new leaf node just added to the tree.
        Root is the root of the entire tree.
   post: The tree is rebalanced as an AVL tree, and all the balance fields of
         the nodes are updated appropriately.
         Root points to the new root of the tree.
NOTE: To give you some ideas, I have included the comments and local variables
      from my implementation.  But you are free to use your own variables
      and/or algorithm if you want. }

Procedure Rebalance(NewNode:BinaryTree; var Root:BinaryTree);

var
	Finished,	    { Indicates whether loop is finished }
	Rotate,		    { Indicates whether a rotation should be performed }
	HasNoParent: Boolean; { Indicates whether pivot has a parent }

	Pivot,                { Pivot for main rotation }
	Rotator,              { Rotator for main rotation }
	Parent: BinaryTree;   { Parent of current node in while loop }

	ParentBalance: integer ;

begin
   {	STEP 1: Update the balance fields
    Method:
       a.  Set NewNode's Balance field to 0
       b.  Traverse the parent pointers, updating the balance fields as you go
           (e.g. if NewNode was the left child of its parent, you should
           subtract one from the parents balance field.
       c.  If a node (other than NewNode) becomes perfectly balanced, then stop.
           No rotation is necessary.
       d.  If you reach the top of the tree without any nodes becoming
           unbalanced, then stop.  No rotation is necessary.
       e.  If a node becomes unbalanced (balance field set to 2 or -2, then stop.
           Rotations must be performed in the next step.  In this case, remember
           the node that became unbalanced - it will be the pivot for the main rotation.}

   { **** STEP 1 CODE GOES HERE **** }

	Set_Balance_Field_BT(NewNode, 0);
	Finished := false ;
	while not Finished do
	BEGIN
      	Parent := Parent_BT(NewNode) ;
      	if which_side_BT(NewNode) = left then
           Set_Balance_Field_BT(Parent, (Get_Balance_Field_BT(Parent) - 1))
	else
      	   Set_Balance_Field_BT(Parent, (Get_Balance_Field_BT(Parent) + 1));
      	ParentBalance := Get_Balance_Field_BT(Parent) ;
      	if abs(ParentBalance) = 0 then
	   BEGIN
	   Rotate := false ;
	   Finished := true
	   END
	else if abs(ParentBalance) = 2 then
	    BEGIN
	    Rotate := true ;
	    Finished := true
	    END
	   else { ParentBalance = +-1 }
	      BEGIN
	      Rotate := false ;
	      if is_empty(Parent_BT(parent)) then
	         finished := true
	      END;
	NewNode := Parent
	END; { while }

   { STEP 2: Perform rotation if necessary
    Method:
       a. Check to see if the pivot has a parent.  IF not, you will have to
          change the root value after the rotations.
       b. If the pivot got the value -2, then the rotator will be the left child.
          If the rotator is right heavy, then a double rotation is necessary
          - first counter-clockwise, then clockwise.  If not, then a single
          clockwise rotation will do.  Call the given procedures to do the
          rotations.  They will update the balance fields for you.
          Don't forget to update the root of the tree if necessary - the value
          it gets will depend on whether you do a single or double rotation.
       c. If the pivot got the value 2, do the mirror image of part b.}

    { **** STEP 2 CODE GOES HERE *** }

	if Rotate then
           BEGIN
	   Pivot := NewNode ;
	   if is_empty(Parent_BT(Pivot)) then
	      HasNoParent := true
	   else
	      HasNoParent := false ;
	   if Get_Balance_Field_BT(Pivot) = -2 then
	      BEGIN
	      Rotator := LeftChild_BT(Pivot) ;
	      if Get_Balance_Field_BT(Rotator) = 1 then
	         RotateCounterClockwise(Rotator) ;
	      RotateClockwise(Pivot)
	      END { if }
	   else  { Pivot balance = 2 }
	      BEGIN
	      Rotator := RightChild_BT(Pivot) ;
	      if Get_Balance_Field_BT(Rotator) = -1 then
	         RotateClockwise(Rotator) ;
	      RotateCounterClockwise(Pivot)
	      END; { else }
	   if HasNoParent then
	      Root := Pivot
	   END { Step 2 }

end; { proc Rebalance }


{ Insert(C,V)
     preconditions: C is a defined collection, V is a collection element.
     postconditions: C has value V added. Storage is allocated as needed.
                     If V already occurs in C an additional copy is added.
NOTE: This procedure contains the non-recursive insertion routine from the
      assignment 2 solution, but it has been modified to call the tree
      rebalancing routines when necessary.

     IN THIS IMPLEMENTATION, DUPLICATES GO INTO THE LEFT SUBTREE }

procedure Insert(var C:collection; V:collection_element);
var TempTree, NewTree {UnbalancedTree} : BinaryTree;
    done: boolean;
    {HeavySide: Direction;}
begin
   If Is_Empty(C) then begin            { Check the empty case first }
      Create_Singleton_BT(C);
      Set_Root_Value_BT(C, V);
      Set_Balance_Field_BT(C,0);        {NEW: SET BALANCE FIELD }
   end else begin
      TempTree := C;                    { Otherwise start the tree traversal }
      done := false;
      repeat
         if Get_Root_Value_BT(TempTree) < V then begin   { If root < V, go right }
            if Is_Empty(RightChild_BT(TempTree)) then begin  { If no right tree, insert here }
               Create_Singleton_BT(NewTree);
               Set_Root_Value_BT(NewTree,V);
               Attach_BT(NewTree,TempTree,Right);
               Rebalance(NewTree,C);              { NEW: REBALANCE TREE }
               done := true
            end else begin                { Otherwise, traverse the right tree }
               TempTree := RightChild_BT(TempTree)
            end
         end else begin
             if Is_Empty(LeftChild_BT(TempTree)) then begin  { If root >= V, go left }
               Create_Singleton_BT(NewTree);    { If no left tree, insert here }
               Set_Root_Value_BT(NewTree,V);
               Attach_BT(NewTree,TempTree,Left);
               Rebalance(NewTree,C);             { NEW: REBALANCE TREE }
               done := true
            end else begin                 { Otherwise, traverse the left tree }
               TempTree := LeftChild_BT(TempTree)
            end
         end
      until done;
   end
end; {insert}


{ Delete(C,V)
     preconditions: C is a defined collection, V is a collection element
     postconditions: C has the value V removed. If V occurs more than once,
                     only one occurrence is removed. If V does not occur in C,
                     no change is made.
NOTE: This procedure has been disabled.
      If you want to try to write an AVL delete, then go for it! }
procedure Delete (var C:collection; V: collection_element);
begin
   Writeln('*** AVL Deletion Not Implemented')
end;

{ Join(C1,C2)
     preconditions: C1 and C2 are two different defined collections.
     postconditions: C1 is the union of the two collections (i.e. it contains
                     all the elements originally in C1 and C2). C2 is undefined. }
procedure Join(var C1: collection; var C2: collection);
{ O(m log n) where m is size of C2, n is size of C1 }
var LTree, RTree: BinaryTree;
begin
   if not Is_Empty(C2) then begin       {If C2 is empty, do nothing}
      If Is_Empty(C1) then begin        {If C1 is empty, just point it to C2}
         C1 := C2;
      end else begin
         Insert(C1, Get_Root_Value_BT(C2));  {Insert the root value of C2 into C1}
         LTree := LeftChild_BT(C2);        {Prune off the left and right subtrees of C2}
         RTree := RightChild_BT(C2);
         Prune_BT(LTree);
         Prune_BT(RTree);
         Destroy_Singleton_BT(C2);      { Destroy the root node of C2 }
         Join(C1, Ltree);               { Recursively join C1 to the left }
         Join(C1, Rtree);               { and right subtrees of C2 }
      end;
   end
end;

{ Print(C1)
     preconditions: C1 is a defined collection.
     postconditions: The elements in C1 are printed to the screen in any order.
                     If C1 is empty, the message "EMPTY COLLECTION" is printed
                     to the screen.
NOTE: The print could be done in any order, but to help you out, it prints in
      alphabetical order using an InOrder traversal.  It also makes use of a
      nested subprocedure (Print_Rec).
      This subprocedure is hidden from all other parts of the program. }
procedure Print(C: Collection);
{ Linear time O(n) }

	procedure Print_Rec(C: Collection);
	BEGIN
	if not Is_Empty(C) then begin
	   Print_Rec(LeftChild_BT(C));
	   Writeln(Get_Root_Value_BT(C));
	   PRint_Rec(RightChild_BT(C))
	   end
	END;

begin
   if Is_Empty(C) then
      writeln('Empty Collection')
   else
      Print_Rec(C)
end;

{ ************************** IDENTIFICATION ************************ }

{ Change this procedure to identify yourself }
procedure IdentifyMyself;
begin
    writeln;
    writeln('***** Student Name:    Mark Sattolo');
    writeln('***** Student Number:  428500');
    writeln('***** Professor Name:   Sam Scott');
    writeln('***** Course Number:   CSI-2114D');
    writeln('***** T.A. Name:        Adam Murray');
    writeln('***** Tutorial Number:   D-1');
  writeln;
end;

{ ****************** INITIALIZATION CODE ******************** }
{ this must be placed at the end of the TPU file.  If you want to initialize
  other globals, you may do so by adding code to this section }
Begin
   IdentifyMyself;
end.

