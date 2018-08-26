{ Mark Sattolo  428500   
  CSI-1100A  DGD-1  TA: Chris Lankester 
  Assignment 10, Question 1 }

program  ProcessRecords (input,output);

uses UNITA10;

{ *************************************************************************** }
  procedure HighAdvanced (var U:University; I:integer; var High:real; var Adv:integer);

{ Find the # of advanced courses for a student and the highest advanced course mark. }

{ Data Dictionary
	   Givens:  U - a University type record.
	   	    I - an integer giving the position of a student in the Students array.
    Intermediates:  j - an index for the position of a course/mark in StudentInfo.
		    k - the position of a course in the CourseList array.
	  Results:  High - the highest mark a student has in an advanced course.
	  	    Adv - the number of advanced courses taken by a student. }

  var	j,k : integer;
  		
  begin
  	Adv := 0;
  	High := 0;
  	for j := 1 to NumTaken do
           begin
  	   k := U.Students[I].CoursesTaken[j];
  	   if U.Courses[k].Advanced then
  	      begin
  	      inc(Adv);
  	      if U.Students[I].Marks[j] > High then
  		 High := U.Students[I].Marks[j];
  	      end;	{ if Advanced }
           end;         { for loop }
  end;	{ procedure HighAdvanced }

{ *************************************************************************** }

{ Main program: Find and output the name, number of advanced courses, and
		highest advanced mark for each TA in record U. }

{ Data Dictionary
	   Givens:   U - a University type record.
	   	     nS - the number of students in U.
	   	     nC - the number of courses in U.
	   	     seed - a random number used to generate data for U.
    Intermediates:   l - an index for the Students array.
		     m - an index for the Courses array.
		     TAyes - a boolean which is true if a student is a TA, and false otherwise.
	  Results:   High - the highest mark a student has in an advanced course.
	  	     Adv - the number of advanced courses taken by a student.
	     Uses:   HighAdvanced, makeData, writeAllCourses, writeAllStudents. }

var U : University;
    nS, nC, l, m, Adv : integer ;
    seed, High : real;
    TAyes : boolean;

begin
repeat	{ start outer loop }

     { Read in the program's givens. }

     writeln('Please enter a value for the random seed [ 0 to exit ]:');
     readln(seed);

     if seed <> 0 then
	begin
	writeln('Please enter the # of courses [ at least ', NumTaken, ' ]:');
	readln(nC);

        writeln('Please enter the # of students [ at least 2 * the # of courses ]:');
	readln(nS);

         write('Enter the name of the output file: ');
	     readln(OutputFile);
    	 assign(Output, OutputFile);
    	 rewrite(Output);

	{ generate and print out the record data }

	makeData(U,nS,nC,seed);

	writeln('-------------- COURSES --------------');
	writeAllCourses(U);
	writeln;

	writeln('-------------- STUDENTS --------------');
	writeAllStudents(U) ;
	writeln;

	{ begin output }

{	    writeln;
	writeln('************************************************');
	writeln('     Mark Sattolo  428500');
	writeln('     CSI-1100A  DGD-1  TA: Chris Lankester');
	writeln('     Assignment 10, Question 1');
	writeln('************************************************');
	writeln;	}

        { get info and write the table }

        writeln(output, 'Name':12, '# advanced courses':27, 'Highest advanced mark':25);
        writeln(output,'---------------      ------------------    ---------------------');
        
        for l := 1 to U.NumStudents do		           { Loop through the students. }
	    begin
            HighAdvanced(U, l, High, Adv);		   { Find the # advanced courses and highest }
	    m := 1;					   { advanced course mark for each student. }
	    TAyes := false;
	    while (not TAyes) and (m <= U.NumCourses) do   { Only need to find the first course for }
		 begin				           { which the student is a TA.}
		 TAyes := U.Courses[m].TA = l;
		 inc(m);
		 if TAyes then			           { If a TA, then print out the required info.}
		    with U.Students[l] do
		        begin
		        writeln(output, Name:15, Adv:15, High:20:2);
		        writeln(output);
		        end;	{ writeln statements }
	    end;	{ while loop }
	end;	{ for loop }
        writeln(output, '********************************************************************');
	writeln;
     writeln('The data has been written to ', OutputFile);
     end     { if seed <> 0 }
   else
       writeln('PROGRAM ENDED');
until
     seed = 0;	{ finish outer loop }
end.
