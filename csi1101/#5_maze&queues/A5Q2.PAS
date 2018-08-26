{ CSI 1101-X,   Winter 1999 }
{ Assignment 5,  Question 2 }
{ Identification:  Mark Sattolo,  student# 428500 }
{ tutorial group DGD-4,  t.a. = Jensen Boire }

program a5q2 (input,output) ;

label 310 ;

const
	 maxMazeSize = 12 ;
      maxSolutionLength = 78 ; { solutions must be length 77 or less }
      up    = 'u' ;         { use the NAMES - up, down, left, and right }
      down  = 'd' ;         { throughout your code }
      left  = 'l' ;
      right = 'r' ;
      free  = '.' ;
      wall  = '#' ;

type
      maze = record
             		size: integer ;  { assume the maze is square }
                 	map: array[1..maxMazeSize,1..maxMazeSize] of char
             	     end ;
             	     
      element_type = string[maxSolutionLength] ;

      queue  = 	record
      				nodes: array[1..maxSolutionLength] of element_type ;
      				front, rear, size, max_size, run: integer ;
      			end ;

{ variable for the main program - NOT to be referenced anywhere else }

var YESorNO: char ;

{ =================  QUEUE OPERATIONS  ==============================  }

procedure create_empty( var q:queue ) ;
begin
	q.front := 0 ;
	q.rear := 0 ;
	q.max_size := maxSolutionLength ;
	q.size := 0 ;
	q.run := 0 ;
end;  { proc create_empty }

function is_empty(q:queue): boolean ;
begin
	if q.size <= 0 then
		is_empty := true 
	else
		is_empty := false ;
end;  { fxn is_empty }

procedure destroy( var q:queue );
begin
	writeln;
	writeln('>> NOT using dynamically allocated memory in this implementation!') ;
	writeln('Maximum array utilization for this run was ', q.run, ' elements.') ;
	writeln;
end;  { proc destroy }

procedure enqueue( v:element_type; var q:queue ) ;
begin
	if q.size = q.max_size then
		begin
		writeln('The queue is already full: ', q.size, ' elements.') ;
		goto 310 ;  { halt }
		end  { if }
	else 
		begin
		q.nodes[(q.rear mod maxSolutionLength) + 1] := v ;
		q.rear := (q.rear mod maxSolutionLength) + 1 ;
		if q.size = 0 then
			q.front := 1 ;
		q.size := q.size + 1 ;
		if q.size > q.run then
			q.run := q.size ;
		end  { else }
end;  { proc enqueue }

procedure serve( var q:queue ; var v:element_type );
begin
	if q.size = 0 then
		begin
		writeln('Error: attempting to serve from empty queue.') ;
		goto 310 ;  { halt }
		end  { if } 
	else
		begin
		v := q.nodes[q.front] ;
		if q.size = 1 then
			begin
			q.rear := 0 ;
			q.front := 0 ;
			end  { if }
		else
			q.front := (q.front mod maxSolutionLength) + 1 ;  { end else-2 }
		q.size := q.size - 1 ;
		end  { else-1 }
end;  { proc serve }

{ =================  MAZE OPERATIONS  ==============================  }

procedure read_maze( var M:maze );
var row,col: integer ;
begin
  writeln('How many rows are in your maze (# columns must be the same) ?');
  readln(M.size);
  if (M.size < 1) or (M.size > maxMazeSize)
  then begin
          writeln('error - bad maze size');
          M.size := 0
       end
  else begin
         writeln('enter each row of your maze on one line.');
         writeln('each position should be either . (empty) or # (wall)');
         for row := 1 to M.size
         do begin
               for col := 1 to M.size
               do read(M.map[row,col]) ;
               readln
            end
       end
end;

procedure check_path ( var path:element_type; var M:maze;
                       var ok: boolean;
                       var is_solution: boolean );
var len,i,row,col: integer ;
    tempM: maze ;  {  mark the positions visited to detect cycles }
begin
   row := 1 ;
   col := 1 ;
   i := 1 ;
   len := length(path);
   ok := len < maxSolutionLength ;

   tempM := M ;
   while (i <= len) and ok
   do if not (path[i] in [left,right,up,down])
      then ok := false
      else begin
              tempM.map[row,col] := wall ;
              case path[i] of
              left : begin
                         col := col - 1 ;
                         if (col < 1) or (tempM.map[row,col]<>free)
                         then ok := false
                     end;
              right: begin
                         col := col + 1 ;
                         if (col > M.size) or (tempM.map[row,col]<>free)
                         then ok := false
                     end;
              up   : begin
                         row := row - 1 ;
                         if (row < 1) or (tempM.map[row,col]<>free)
                         then ok := false
                     end;
              down : begin
                         row := row + 1 ;
                         if (row > M.size) or (tempM.map[row,col]<>free)
                         then ok := false
                     end
              end ;
              i := i + 1
           end ;
   is_solution := ok and (row = M.size) and (col = M.size)

end;

procedure write_path( var path:element_type; var M:maze );
var i,row,col: integer ;
    tempM: maze ;
    ok, is_solution: boolean ;
begin
   write('The path <');
   for i := 1 to length(path) do write(path[i]);
   write('>');

   check_path(path, M, ok, is_solution) ;

   if not ok
   then begin
          writeln('  is not ok')
        end
   else begin
          row := 1 ;
          col := 1 ;
          tempM := M ;
          for i := 1 to length(path)
          do begin
                tempM.map[row,col] := path[i];
                case path[i] of
                  left : col := col - 1 ;
                  right: col := col + 1 ;
                  up   : row := row - 1 ;
                  down : row := row + 1 ;
                end
             end ;
          tempM.map[row,col] := '+' ;

          writeln('  looks as follows in the maze (it ends at ''+'').') ;
          for row := 1 to M.size
          do begin
                for col := 1 to M.size
                do write(tempM.map[row,col]);
                writeln
             end ;
          if is_solution
          then writeln('**** This path leads to the goal.') ;
          writeln
       end
end;

{ =========================================================================  }

procedure breadth_first_search(var M:maze; var path: element_type; var is_solution:boolean);
var
	q: queue ;
	val : element_type ;
	good: boolean ;
begin
	path := '' ;
	check_path(path, M, good, is_solution) ;  write_path(path,M) ;
	if not is_solution then
		begin
		create_empty(q) ;
		path := right ;
		check_path(path, M, good, is_solution) ;  write_path(path,M) ;
		if good then
			enqueue(path, q) ;
		path := down ;
		check_path(path, M, good, is_solution) ;  write_path(path,M) ;
		if good then
			enqueue(path, q) ;
		while (not is_solution) and (not is_empty(q) ) do
			begin
			serve(q, val) ;
			path := val + right ;
			check_path(path, M, good, is_solution) ; write_path(path,M) ;
			if not is_solution then
				begin
				if good then 
					enqueue(path, q) ;
				path := val + down ;
				check_path(path, M, good, is_solution) ; write_path(path,M) ;
				if not is_solution then
					begin
					if good then
						enqueue(path, q) ;
					path := val + left ;
					check_path(path, M, good, is_solution) ; write_path(path,M) ;
					if not is_solution then
						begin
						if good then
							enqueue(path, q) ;
						path := val + up ;
						check_path(path, M, good, is_solution) ; write_path(path,M) ;
							if (not is_solution) and good then 
									enqueue(path, q) ;
						end ;
					writeln;
					writeln('>> q.size is  ', q.size, '; q.front is  ', q.front, '; q.run is  ', q.run) ;
					writeln;
					end
				end
			end ;
	destroy(q) ;
	end;
end ;

procedure assignment5q2 ;
var M: maze ;
    path: element_type ;
    is_solution: boolean ;
begin
   read_maze(M);
   writeln ;
   breadth_first_search(M,path,is_solution);
   if is_solution
   then write_path(path,M)
   else writeln('there is no solution for this maze')
end;

{***** YOU MUST CHANGE THIS PROCEDURE TO DESCRIBE YOURSELF *****}

procedure identify_myself ; {    Writes who you are to the screen }
begin
   writeln ;
   writeln('CSI 1101-X  (winter, 1999).  Assignment 5, Question 2.') ;
   writeln('Mark Sattolo,  student# 428500.') ;
   writeln('tutorial section DGD-4,  t.a. = Jensen Boire') ;
   writeln
end ;


begin  { main program }

  identify_myself ;

repeat
  assignment5q2 ;
310:  writeln('Do you wish to continue (y or n) ?') ;
  readln(YESorNO);
until (YESorNO <> 'y')

end.
