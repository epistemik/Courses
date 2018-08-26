program a4;

{This program tests the shortest path algorithm from program strategy 10.16

 Below you will find a test program, and some procedure headers.
 You must fill in the bodies of the procedures.  Do not alter the test program
 or type definitions in any way.

 You are given a constant for INFINITY, which is defined to be the same as MAXINT.
 This is a constant that returns the largest possible number of type integer. 
 This assumes that you will use low edge weight values.  
 Stick to weights less than 100 and the output will also look nicer.

 NOTE - always comment every single local variable you use. }

{************* CONSTANTS ******************}
Const

   MAX = 100;             { This is the maximum size of graph. You can make this bigger if you want. }
                           
   INFINITY = MAXINT;     { Use this anywhere you need "infinity" }

{************* TYPE DEFINITIONS *********************}
Type

   {The type definitions below define an adjacency matrix
     graph representation that stores edge weights.}
     
   GraphSize = 0..MAX;
   VertexNumber = 1..MAX;
   AdjacencyRow = Array [VertexNumber] of integer;
   GraphRep = Array [VertexNumber] of AdjacencyRow;

   {ShortestPathArray is the type for the ShortestDistance
    variable that returns the result of Dijkstra's algorithm}
   ShortestPathArray = Array [VertexNumber] of integer;

{************** The Procedures and Functions ********************}

{procedure minimum(a,b)
	pre: a and b are integers
	post: returns the larger of a and b.
 NOTE - Pascal does not have a built in minimum function.  Use this one if you need it.}
function minimum(a,b: integer): integer;
begin
	if a<b then
		minimum := a
	else
		minimum := b
end;  { fxn minimum }


{procedure NewGraph(G,S)
	pre: S is the size of graph to create.
	post:	G should be an adjacency matrix or adjacency list that corresponds to a graph with 
	 		S vertices and no edges. If using an adjacency matrix, you must initialize the entire matrix.
 HINT: Remember that the distance from a vertex to itself is always 0.}

procedure NewGraph(var G:GraphRep; S:GraphSize);
var
	i, j: integer ;
begin
	for i := 1 to S do
		for j := 1 to S do
			if i = j then
				G[i][j] := 0
			else
				G[i][j] := INFINITY
end;  { proc NewGraph }


{procedure AddEdge(G,S,Origin,Terminus,Weight)
	pre:  G is a graph representation with S vertices.  Origin, Terminus, and Weight 
			define an edge to be added to G.
	post:  G has the specified edge added.  HINT - you might want to print an error message
			if Origin or Terminus are bigger than S.}
			
procedure AddEdge( var G:GraphRep; S:GraphSize; Origin:VertexNumber; 
							Terminus: VertexNumber; Weight: integer );
begin
	if ( not ( Origin in [1.. S] ) ) or ( not ( Terminus in [1..S] ) ) then
		writeln( 'Error:  Origin and Terminus must be in the range 1 to ', S )
	else if ( Origin = Terminus ) and ( Weight <> 0 ) then
		writeln( 'Error:  the distance from a vertex to itself is always 0. ' )
		else
			G[Origin][Terminus] := Weight
end;  { proc AddEdge }


{procedure ShortestPath(G,S,Origin,ShortestDistance)
	pre: G is a graph representation with S vertices.  Origin is the start vertex.
	post: ShortestDistance is an array containing the shortest distances from Origin to each vertex.
	
 HINT - program strategy 10.16 uses set variables.  This is possible in Pascal, but you can't really 
 			use them the way you need to here.  I suggest implementing the set W as an array 
 			of booleans.  Initialize them all to FALSE and then each time you want to put a new
 			vertex in the set, change the corresponding value to TRUE.  You also might want to 
 			keep a count of the number of vertices in W.

 HINT - Watch out for the two "W" variables in 10.16.  They use a big W and a small w.  
 			You can't do that in Pascal.  I suggest using "w" for the small one and "BigW" for 
 			the big one.  Of course you are free to use whatever variable names you want, but
 			the closer you stick to the book, the easier it will be to mark.

 HINT - Comment this well! }

procedure ShortestPath(var G:GraphRep; S:GraphSize; Origin: VertexNumber; var ShortestDistance: ShortestPathArray);
var
	V, BigW : set of GraphSize ;
	MinDistance, w : integer ;
	i, j, k, y : VertexNumber ;
begin
	w := -1 ;
	V := [1..S] ;
	BigW := [Origin] ;
	for i := 1 to S do
		ShortestDistance[i] := G[Origin][i] ;
	while BigW <> V do
		BEGIN
		MinDistance := INFINITY ;
		for j := 1 to S do
			if ( j in ( V - BigW ) ) then 
				if ( ShortestDistance[j] < MinDistance ) then
					BEGIN
					MinDistance := ShortestDistance[j] ;
					w := j
					END  { if }
				else
					y := j ;
		if w < 0 then w := y ; 
		BigW := BigW + [w] ;
		for k := 1 to S do
			if ( k in ( V - BigW ) ) and ( G[w][k] <> INFINITY ) then
				ShortestDistance[k] := minimum(ShortestDistance[k], ShortestDistance[w] + G[w][k])
		END  { while }
end;  { proc ShortestPath }

(**************************** IDENTIFICATION **************************)

{ Change this procedure to identify yourself  }
procedure IdentifyMyself;
begin
    writeln;
    writeln('***** Student Name:			Mark Sattolo');
    writeln('***** Student Number:  	428500');
    writeln('***** Professor Name:  		Sam Scott');
    writeln('***** Course Number:   		CSI-2114D');
    writeln('***** T.A. Name:       		Adam Murray');
    writeln('***** Tutorial Number: 		D-1');
  writeln;
end;

var
   G: GraphRep;        {G and S define the graph}
   S: GraphSize;

   E,                  {Counts number of edges}

   Weight: integer;    		{ Weight, Origin and Terminus are }
   Origin, Terminus,   		{ for User input}

   row, col: VertexNumber;	{ Row and Col are for looping through the adjacency matrix }

   answer: string;         { Stores users' answers to questions }

   ShortestPaths: ShortestPathArray;		{ Stores the shortest paths }

begin
   IdentifyMyself;

   {INITIALIZE G}

   write('What size of graph do you want (maximum size=',MAX,'): ');
   readln(S); writeln;
   NewGraph(G,S);

   writeln('Enter the edges one by one until you are finished.');
   writeln('Quit by entering a zero for the origin vertex.');
   E := 0;
   repeat
      writeln;
      write('Origin: ');
      readln(Origin);
      if Origin > 0 then begin
         write('Terminus: ');
         readln(Terminus);
         write('Weight: ');
         readln(Weight);
         AddEdge(G,S,Origin,Terminus,Weight);
         E := E+1
      end
   until (Origin<=0);

   {DISPLAY G IF REQUESTED}

   writeln;
   writeln('Your graph has ',S,' vertices and ',E,' edges.');
   writeln;
   write('Would you like to see the adjacency matrix (y/n)' );
   readln(answer); writeln;
   if (answer[1] = 'y') or (answer[1] = 'Y') then
      for row := 1 to S do begin
         for col := 1 to S do
            if G[row,col]=INFINITY then
               write(' INF')
            else
               write(G[row,col]:4);
         writeln
      end;
   writeln;

   {RUN SHORTEST PATH IF REQUESTED }

   write('Would you like to run the shortest path algorithm? (y/n)');
   readln(answer); writeln;
   if (answer[1] = 'y') or (answer[1] = 'Y') then begin
      write('What is the start vertex? (1..',S,'): ');
      readln(Origin); writeln;
      ShortestPath(G,S,Origin,ShortestPaths);
      writeln;
      writeln('Shortest paths from start vertex ',Origin,' are: ');
      for Terminus := 1 to S do
         write(Terminus:5,': ',ShortestPaths[Terminus]);
      writeln;
   end;

   {QUIT}

   writeln;
   writeln('Bye bye')
end.