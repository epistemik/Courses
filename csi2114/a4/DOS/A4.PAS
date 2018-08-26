program a4;
{This program tests the shortest path algorithm from program strategy 10.16

Below you will find a test program, and some procedure headers.  You must fill in the bodies
of the procedures.  Do not alter the test program or type definitions in any way.

 You are given a constant for INFINITY, which is defined to be the same as MAXINT.
 This is a constant that returns the largest possible number of type integer. 
 This assumes that you will use low edge weight values.  
 Stick to weights less than 100 and the output will also look nicer.

 NOTE - always comment every single local variable you use. }

{************* CONSTANTS ******************}
Const

   MAX = 100;    { This is the maximum size of graph. You can make this bigger if you want. }
                           
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
      post:  G should be an adjacency matrix or adjacency list that corresponds to a graph with S
             vertices and no edges. If using an adjacency matrix, you must initialize the entire matrix.
 HINT:  Remember that the distance from a vertex to itself is always 0.}

procedure NewGraph(var G:GraphRep; S:GraphSize);
var
    i, j: integer ;  { indexes for the loops to initialize a graph }
begin
  { use for loops to access each element of the 2D array }
  for i := 1 to S do
    for j := 1 to S do
     { if i = j, i.e. the edge represents the distance from a node to itself, then the weight is 0 }
     if i = j then
       G[i, j] := 0
     { otherwise, set the initial weight for each edge to INFINITY }
     else
       G[i, j] := INFINITY
end;  { proc NewGraph }

{procedure AddEdge(G,S,Origin,Terminus,Weight)
     pre: G is a graph representation with S vertices.  Origin, Terminus, and Weight define an edge to
          be added to G.
     post: G has the specified edge added.  HINT - you might want to print an error message if Origin
           or Terminus are bigger than S. }

procedure AddEdge(var G:GraphRep; S:GraphSize; Origin, Terminus:VertexNumber; Weight:integer);
{ This procedure adds an edge to a graph.  Because of the way the main procedure is written, with E updated right
  after the return from AddEdge, there are several possibilities for the E value to be incorrect.  If unacceptable
  parameter values (Origin, Terminus, Weight) were entered, then the implementation here prints an error
  message, prompts for new values, and recursively calls AddEdge to check and add a new, correct, edge.  In this
  case though, the program will not exit if the user enters  0' for Origin, as this would mean that E is updated
  incorrectly.  I thought it best to insist on a correct edge within the AddEdge procedure.  As well, there is the case
  where a user enters an edge that has previously been entered - the new Weight value will overwrite the previous
  value and E will be incremented but there will not have been a new edge added, and for each time this happens,
  E will over-report the number of edges by one.  In this case though, I thought it best to give the user the ability to
  correct or change a previously entered edge and just accept that this will result in E being too large.  Also, the
  program will overestimate E if a user just enters an edge that is from a node to itself with a zero value - these
  cases are not usually considered to be separate edges, but it seemed too much trouble to refuse this option to a
  user.  E is just used to report to the user and they can count the edges in the adjacency matrix display for an
  accurate value of E if they want.  E does not figure as a parameter for any procedures, so it doesn't really matter
  if it is wrong: it won't affect the running of ShortestPath. }

     procedure EdgeInput( var G:GraphRep; S:GraphSize );
     { A private procedure of AddEdge that prompts for new Origin, Terminus, and Weight values, then calls
       AddEdge to verify these and add the edge if it has acceptable values. }
     var
               Origin, Terminus: VertexNumber;    { These are the same as the main program variables }
               Weight : integer ;                           { of the same names. }

          begin
               writeln( 'Please enter a correct edge to continue...');
        { Once within the AddEdge procedure - to ensure that E will be updated correctly, users do not have
          the option of using  0' for Origin to exit. }
               writeln( '[You cannot exit the program at this stage :( ]' ) ;
        { Prompt for and read new, hopefully acceptable, values for the edge parameters. }
               write('Origin: ');
               readln(Origin);
               write('Terminus: ');
               readln(Terminus);
               write('Weight: ');
               readln(Weight);
        { Call AddEdge to verify these new values and then add the edge or print a further error message and
          new prompts. }
               AddEdge (G, S, Origin, Terminus, Weight)
          end; { proc EdgeInput }

begin
  { Check that Origin and Terminus are in the proper range.  Do not have to worry about Origin = 0 here because
    that value should never be passed to AddEdge from the main program. }
  if not ( ( Origin in [1.. S] ) and ( Terminus in [1..S] ) ) then
    begin
    { Write an appropriate error message and call EdgeInput to prompt for new values. }
    writeln( 'Error: Origin and Terminus must be in the range 1 to ', S );
    EdgeInput(G, S)
    end { if }
  { Check that the weight value from a node to itself is not non-zero }
  else if (( Origin = Terminus ) and ( Weight <> 0 )) then
     begin
     { Write an appropriate error message and call EdgeInput to prompt for new values. }
     writeln( 'Error: the distance from a vertex to itself is always 0. ' );
     EdgeInput(G, S)
     end { else if}
   else
     { Otherwise, accept the values and add the appropriate edge to G. }
     G[Origin, Terminus] := Weight
end;  { proc AddEdge }

{procedure ShortestPath(G,S,Origin,ShortestDistance)
     pre: G is a graph representation with S vertices.  Origin is the start vertex.
     post: ShortestDistance is an array containing the shortest distances from Origin to each vertex.
 HINT - program strategy 10.16 uses set variables.  This is possible in Pascal, but you can't really use
        them the way you need to here.  I suggest implementing the set W as an array of booleans. 
        Initialize them all to FALSE and then each time you want to put a new vertex in the set,
        change the corresponding value to TRUE.  You also might want to keep a count of the
        number of vertices in W.
 HINT - Watch out for the two "W" variables in 10.16.  They use a big W and a small w. You can't do
        that in Pascal.  I suggest using "w" for the small one and "BigW" for the big one.  Of course
        you are free to use whatever variable names you want, but the closer you stick to the book,
        the easier it will be to mark.
 HINT - Comment this well! }

procedure ShortestPath( var G:GraphRep; S:GraphSize; Origin:VertexNumber; var
                        ShortestDistance:ShortestPathArray );
var
  { V is the set of vertices in the graph.  BigW will be the set of vertices that have already been  processed' by the
    algorithm. }
  V, BigW : set of VertexNumber ;
  { MinDistance holds the minimum value in the ShortestDistance array, for the as yet  unprocessed' nodes, during
    the first step of the while loop }  
  MinDistance : integer ;
  { w holds the index in ShortestDistance for the new node at the minimum Distance from the existing nodes.   j is
    an index for the for loops in the procedure. }
  w, j : VertexNumber ;
begin
  { V contains all the vertices in the graph }
  V := [1..S] ;
  { BigW is initialized to contain the first vertex - Origin }
  BigW := [Origin] ;
  { Initialize ShortestDistance to contain the values in the Origin row of G. }
  for j := 1 to S do
    ShortestDistance[j] := G[Origin, j] ;
  { Start a loop to continue until all the vertices have been processed and are in BigW, i.e. stop when BigW = V }
  while BigW <> V do
    BEGIN
    {  Initialize MinDistance }
    MinDistance := INFINITY ;
    {  use j to loop through the indices of ShortestDistance }
    for j := 1 to S do
     { only consider those j (vertices) that have not been processed (i.e. are not yet in BigW) and that have their
       value in ShortestDistance as less than or equal to the previous MinDistance.  This will find the new
       minimum value, and corresponding vertex, in ShortestDistance.  Here, using  less than or equal to'
       instead of  less than' is necessary to prevent an infinite loop in the case where one node in G cannot be
       reached from the others - i.e. its distance from any other node in G will be INFINITY. }
     if ( j in ( V - BigW ) ) and ( ShortestDistance[j] <= MinDistance ) then
       BEGIN
       {  When a new minimum is found, set MinDistance and record the index j with w }
       MinDistance := ShortestDistance[j] ;
       w := j
       END ;
    { After the next vertex, w, has been found - add it to BigW }
    BigW := BigW + [w] ;
    {  start another loop to compare the existing ShortestDistance values to those which would be obtained by
       travelling from w to the unprocessed nodes }
    for j := 1 to S do
     { Only consider nodes not yet in BigW and values of G for these nodes that are not INFINITY - if the value
       is INFINITY, this cannot be a new minimum, and this also prevents overflow problems with adding
       amounts to MAXINT. }
     if ( j in ( V - BigW ) ) and ( G[w, j] <> INFINITY ) then
       {  Update ShortestDistance if the sum of the existing shortest path to the most recently added node
          (ShortestDistance[w]) plus the  distance' to a still unprocessed node (G[w, j]) is less than the existing
          shortest path to that node (ShortestDistance[j]) }
       ShortestDistance[j] := minimum( ShortestDistance[j],  (ShortestDistance[w] + G[w, j]) )
    END  { while }
end;  {}

(**************************** IDENTIFICATION **************************)
(* Change this procedure to identify yourself *)
procedure IdentifyMyself;
begin
    writeln;
    writeln('***** Student Name:     Mark Sattolo');
    writeln('***** Student Number:   428500');
    writeln('***** Professor Name:   Sam Scott');
    writeln('***** Course Number:    CSI-2114D');
    writeln('***** T.A. Name:        Adam Murray');
    writeln('***** Tutorial Number:  D-1');
  writeln;
end;


var
   G: GraphRep;     {G and S define the graph}
   S: GraphSize;

   E,        {Counts number of edges}

   Weight: integer;     { Weight, Origin and Terminus are }
   Origin, Terminus,    { for User input}

   row, col: VertexNumber;   { Row and Col are for looping through the adjacency matrix }

   answer: string;    { Stores users' answers to questions }

   ShortestPaths: ShortestPathArray;     { Stores the shortest paths }

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