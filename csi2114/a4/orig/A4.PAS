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
 
 USES  GraphsUnit ;
 
var
   G: GraphRep;        {G and S define the graph}
   S: GraphSize;

   E,                  {Counts number of edges}

   Weight: integer;    		{ Weight, Origin and Terminus are }
   Origin, Terminus,   		{ for User input}

   row, col: VertexNumber;	{ Row and Col are for looping through the adjacency matrix }

   answer: string;         { Stores users' answers to questions }

   ShortestPaths: AdjacencyRow ;		{ Stores the shortest paths }

begin
   IdentifyMyself;

   {INITIALIZE G}
repeat
   write('What size of graph do you want (maximum size = ', MAX,'): ') ;
   readln(S);
until S in [1..MAX] ;
   writeln;
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
   until ( Origin <= 0 );

   {DISPLAY G IF REQUESTED}

   writeln;
   writeln('Your graph has ', S,' vertices and ', E,' edges.');
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
      write('What is the start vertex? (1..', S,'): ');
      readln(Origin);
      ShortestPath(G,S,Origin,ShortestPaths);
      writeln;
      writeln('Shortest paths from start vertex ',Origin,' are: ');
      for Terminus := 1 to S do
         write(Terminus:5,': ',ShortestPaths[Terminus]);
      writeln;
   end;

   {RUN minimal spanning tree IF REQUESTED }

   writeln ;
   write('Would you like to run the minimal spanning tree algorithm? (y/n)');
   readln(answer); writeln;
   if (answer[1] = 'y') or (answer[1] = 'Y') then
	MinimalSpan(G,S);

   {QUIT}

   writeln;
   writeln('Bye bye')
end.
