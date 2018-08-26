{ Mark Sattolo, 428500, CSI-1100A, prof: Dr. S. Boyd
  tutorial group DGD-1, TA: Chris Lankester
  Assignment 4, Question 1 }

program ConvertTime (input,output);

{ This program converts a positive integer giving the time in seconds
  to three integers representing Hours, Minutes, and Seconds. }

{ Data Dictionary
   GIVENS:   Time_in_seconds - a positive integer representing the time in seconds.
   RESULTS:  Hours, Minutes, Seconds - 3 integers representing their named time periods.
   INTERMEDIATES: Min_Sec - the remainder of the input after splitting out Hours. }

var Time_in_seconds, Hours, Min_Sec, Minutes, Seconds: integer;

begin

  writeln;
  writeln('***************************************************');
  writeln('Mark Sattolo, 428500, CSI-1100A, prof: Dr. S. Boyd');
  writeln('tutorial group DGD-1, TA: Chris Lankester');
  writeln('Assignment 4, Question 1');
  writeln('***************************************************');
  writeln;

{ Prompt the user for the input. }

  write('Please enter the positive integer Time_in_seconds?  ');
  readln(Time_in_seconds);

{ The div function is used to get the integer for Hours and
  the mod function is used to get the remainder representing minutes and seconds. }

  Hours := (Time_in_seconds div 60) div 60;
  Min_Sec := Time_in_seconds mod 3600;

{ div and mod are then used to separate Minutes and Seconds. }

  Minutes := (Time_in_seconds div 60) mod 60;
  Seconds := Time_in_seconds mod 60;

{ Write out the result. }
       
  writeln;
  writeln('The number of hours is ',Hours);
  writeln('The number of minutes is ',Minutes);
  writeln('The number of seconds is ',Seconds)

end.
