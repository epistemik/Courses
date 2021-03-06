unit a2unit;

{ This unit contains an implementation of the collection ADT using binary search trees.
  It gets the type definitions and basic tree operations from another unit called
  BinTrADT.  Other than that, the forward declarations and main types are exactly the
  same as the collection ADT for assignment 1.  Your job is to write the missing
  functions and procedures.  You must write:

              Size(C),
              Insert(C,V), and
              Join(C1, C2).

  Make sure that both delete and join preserve the correct ordering of the Binary Search Tree.
 
  Also be sure not to use direct pointer references. 
  Call the operations from the Binary Tree ADT instead. }

interface

uses BinTrADT;

(********************* TYPE DEFINITIONS *********************)

type

(*Since we are using the BinaryTree ADT, all we have to do here is relate the main types 
	for collections to the main types for binary trees. *)

	collection_element = TreeElement;
	collection = BinaryTree;

{ The forward declarations are exactly the same as before.  Only the implementations have changed }

procedure Create(var C:collection);
procedure Destroy(var C:collection);
function Size(C: collection): integer;
function Is_Empty(C:collection): boolean;
procedure Insert(var C:collection; V:collection_element);
procedure Delete (var C:collection; V: collection_element);
procedure Join(var C1: collection; var C2: collection);
procedure Print(C: collection);
function MemCheck: boolean;
procedure IdentifyMyself ;

implementation

{********************** Memory Management Stuff *********************}

{Note that since all the memory management is done by BinTrADT, we
 just have to call the MemCheck_BT function here}

Function MemCheck;
begin
   MemCheck := MemCheck_BT
end;

(********************** COLLECTION IMPLEMENTATIONS ***********************)

(* Create(C)
     preconditions: C is undefined
     postconditions: C is the empty collection with storage allocated as needed. *)
procedure Create(var C:collection);
begin
   Create_Empty_BT(C);
end;


(* Destroy(C)
     preconditions: C is a defined collection
     postconditions: C' is undefined. All dynamically allocated memory is disposed*)
procedure Destroy(var C:collection);
begin
   Destroy_BT(C);
end;


(* Is_Empty(C)
     preconditions: C is a defined collection.
     postconditions: returns true if C is empty, false otherwise. *)
function Is_Empty(C:collection): boolean;
begin
   Is_Empty := Is_Empty_BT(C);
end;


 { Size(C)
     preconditions: C is a defined collection.
     postconditions: returns the number of elements in C. }
function Size(C: collection): integer;
var
	L_size, R_size: integer ;
BEGIN
	{ Base case:  if C is empty, then the number of elements in C is 0. }
	if ( Is_empty(C) ) then
		Size := 0
	else
	{ General case:  Size will be the size of the left subtree, plus the size of the right subtree,  
						plus 1 -- for the non-empty root node.  Sizes of the left and right subtrees  
						are obtained from the recursive call of Size on the left and right children. }
		BEGIN
		L_size := Size(LeftChild_BT(C)) ;
		R_size := Size(RightChild_BT(C)) ;
		Size := L_size + R_size + 1
		END
END;  { fxn Size }


 { Insert(C, V)
     preconditions: C is a defined collection, V is a collection element.
     postconditions: C has value V added. Storage is allocated as needed.
     If V already occurs in C an additional copy is added.
     NOTE: You may do this recursively or iteratively (in a loop).
     NOTE: The collection should be able to hold multiple copies of a single element.
     This is easy to do.  Just pick a side where the duplicates will go.  So your binary
     search tree will be one of two types: either leftchild/rightchild are < and >= the
     root or they are <= and > the root. }
procedure Insert(var C:collection; V:collection_element);

	{ add_node(K, E, D) 
		preconditions:  K is a defined collection with an empty child on the side indicated by D.
							E is a collection_element.  D is a direction (left or right).
		postconditions:  a new node is allocated with value E, and attached to K as the D child.  }
	procedure add_node(var K: collection; E: collection_element; D: direction) ;
	var
		T: collection ;
	BEGIN
			Create_Singleton_BT(T) ;			{ allocate the new node }
			Set_Root_Value_BT(T, E) ;		{ set the value to E }
			Attach_BT(T, K, D) ;				{ attach the node to K at D }
	END;  { proc add_node }

	{ Insert_rec(C, V) 
		preconditions:  C is a non-empty collection, V is a collection element.
		postconditions:  a new collection_element with value V is added to C in the proper position
							to preserve the 'binary tree' property of C.  }
	procedure Insert_rec(var C: collection; V: collection_element) ;
      var
      	leftC, rightC: collection;
	BEGIN
		{ Go left if V is  <=  the root value.  This choice is optional, and means that duplicate values
			will go to the left of the matching value's node. }
		if ( V <= Get_Root_Value_BT(C) ) then
                    BEGIN
                    leftC := LeftChild_BT(C) ;
                    { if the left child is empty, attach the new node there }
			if ( Is_Empty(leftC) ) then
				add_node(C, V, Left)
		    else
		    		{ otherwise, call Insert_rec on the existing left child to find the proper insert position }
                        Insert_rec(leftC, V)
                    END  { if }
		else
			  { if V is greater than the root value, the search will proceed to the right }
                    BEGIN
                    rightC := RightChild_BT(C) ;
                    { if the right child is empty, attach the new node there }
 		    if ( Is_Empty(RightChild_BT(C)) ) then
			add_node(C, V, Right)
		    else
		    		{ otherwise, call Insert_rec again on the existing right child to find the insert position }
                        Insert_rec(rightC, V)
                    END  { else }
	END;  { proc Insert_rec }

BEGIN
	if ( Is_Empty(C) ) then
		{ if C is empty, create a new node for C and set the value to V }
		BEGIN
		Create_Singleton_BT(C) ;
		Set_Root_Value_BT(C, V) ;
		END  { if }
	else
		{ otherwise, call Insert_rec to compare the root value of C with V, and either insert V as left or
			right child, or proceed recursively through C searching for the proper position to insert V }
		Insert_rec(C, V) ;
END;  { fxn Insert }


 { Delete(C,V)
     preconditions: C is a defined collection, V is a collection element
     postconditions: C has the value V removed. If V occurs more than once,
     only one occurrence is removed. If V does not occur in C, no change is made.  }
procedure Delete (var C:collection; V: collection_element);
var RTree, LTree, Largest, LargestLeftChild, LargestParent: BinaryTree;
begin
   if not Is_Empty(C) then begin
      {First look for V in the root}
      if Get_Root_value_BT(C) = V then begin
         {Found.  Delete it.}
         if Is_Empty(LeftChild_BT(C)) then begin
            {There is no left child, so just make the right child the new tree}
            RTree := RightChild_BT(C);
            prune_BT(RTree);
            Destroy_Singleton_BT(C);
            C := RTree;
         end else begin
            {There is a left child, so find the largest element in it and replace
            the root node with this element}
            LTree := LeftChild_BT(C);       {First prune off the left and right trees}
            Prune_BT(LTree);
            RTree := RightChild_BT(C);
            Prune_BT(RTree);
            Destroy_Singleton_BT(C);        {Now destroy the original root node}

            Largest := LTree;                 {Now search for the largest node in the left tree}
            While not Is_Empty_BT(RightChild_BT(Largest)) do
               Largest := RightChild_BT(Largest);

            LargestParent:= Parent_BT(Largest); {Get the parent of the largest node}

            if Is_Empty_BT(LargestParent) then begin  {If there is no parent, then just move }
               attach_BT(Rtree, Largest, Right);         {the entire subtree to the root position }
               C := Largest
            end else begin                                  {If there is a parent...}
               LargestLeftChild:= LeftChild_BT(Largest);      {get the left subtree of the largest}
               Prune_BT(Largest);                             {prune the largest}
               Prune_BT(LargestLeftChild);                    {prune the left subtree of the largest}
               Attach_BT(LargestLeftChild,LargestParent,Right);{move up the left subtree}
               Attach_BT(LTree,Largest,Left);                  {Make the largest the new root by }
               Attach_BT(RTree,Largest,Right);                 {attaching the appropriate subtrees }
               C := Largest
            end
         end
      end else begin
            {Root element was not V.  We have to keep searching.}
         if Get_Root_Value_BT(C) > V then begin  {Search left}
            LTree := LeftChild_BT(C);
            if not IS_Empty_BT(LTree) then begin  {If no left tree, stop}
               Prune_BT(LTree);
               Delete(LTree, V);
               Attach_BT(LTree, C, Left)
            end
         end else begin                       {Search Right}
            RTree := RightChild_BT(C);
            if not Is_Empty_BT(RTree) then begin  {If no right tree, stop}
               Prune_BT(RTree);
               Delete(RTree,V);
               Attach_BT(RTree, C, Right);
            end
         end
      end
   end
end;


(* Join(C1,C2)
     preconditions: C1 and C2 are two different defined collections.
     postconditions: C1 is the union of the two collections (i.e. it contains all the
     elements originally in C1 and C2).  C2 is undefined. *)
procedure Join(var C1, C2: collection);

	{ Join_rec(C1, C2) 
		preconditions:  C1 and C2 are two different defined collections.
		postconditions:	C1 has new collection_elements added, which copy all the values of C2, 
							such that C1 preserves its 'binary tree' property.  C2 is unchanged.  }
		procedure Join_rec(var C1, C2: Collection) ;
            var
                    leftC, rightC: collection ;
		BEGIN
			{ if C2 is empty, do nothing. }
		     if ( not Is_Empty(C2) ) then
		     	 { other wise, will do a postorder traversal of C2 to copy all its values to C1 }
			 BEGIN
			 { recursive call of the procedure to join the left child of C2 to C1 }
                   leftC := LeftChild_BT(C2) ;
			 Join_rec(C1, leftC) ;
			 { recursive call of the procedure to join the right child of C2 to C1 }
                   rightC := RightChild_BT(C2) ;
                   Join_rec(C1, rightC) ;
                   { insert the root value of C2 into C1 }
			 Insert(C1, Get_Root_Value_BT(C2)) ;
			 END
		END;

BEGIN
	{ if C1 is empty, then all that is needed is to point C1 to C2 to obtain the new 'joined' C1.  This will
		work if C2 is empty or not.  Then a new node is created for C2 so that the destroy procedure
		can later be called to undefine C2. }
	if ( Is_Empty(C1) ) then
		BEGIN
		C1 := C2 ;
		Create_Singleton_BT(C2)
		END
	{ however, if C1 is not empty but C2 is, then all that is needed is to undefine C2, and this can only
		be done by assigning it a new node first. }
	else if ( Is_Empty(C2) ) then
		      Create_Singleton_BT(C2)
		  else
		  { when both C1 and C2 are non-empty, the Join_rec procedure is called to copy all the 
		  	values in C2 as new collection_elements in C1. }
		      Join_rec(C1, C2) ;
	{ finally, the existing C2 -- either a new singleton or the non-empty C2 whose values were copied
		into C1 -- is destroyed to undefine it }
	Destroy(C2)
END;


(* Print(C1)
     preconditions: C1 is a defined collection.
     postconditions: The elements in C1 are printed to the screen in any order.  If C1 is empty,
     the message "EMPTY COLLECTION" is printed to the screen.
     NOTE: The print could be done in any order, but to help you out, it prints in alphabetical order
     using an InOrder traversal.  It also makes use of a nested subprocedure (Print_Rec).
     This subprocedure is hidden from all other parts of the program.*)
procedure Print(C: Collection);	(* Linear time O(n) *)

		procedure Print_Rec(C: Collection);
		begin
			if not Is_Empty(C) then begin
				Print_Rec(LeftChild_BT(C));
				Writeln(Get_Root_Value_BT(C));
				Print_Rec(RightChild_BT(C))
			end
		end;

begin
   if Is_Empty(C) then
      writeln('Empty Collection')
   else
      Print_Rec(C)
end;

procedure IdentifyMyself;
begin
	writeln;
	writeln('***** Student Name:  Mark Sattolo');
	writeln('***** Student Number:  428500');
	writeln('***** Professor Name:  Sam Scott');
	writeln('***** Course Number:  CSI-2114D');
	writeln('***** T.A. Name:  Adam Murray');
	writeln('***** Tutorial Number:  D-1');
	writeln;
end;  { proc IdentifyMyself }


(******************** INITIALIZATION CODE **********************)
(* Note that we have nothing to initialize this time, since
   memory management is being done by the Binary Tree ADT.*)

end.
