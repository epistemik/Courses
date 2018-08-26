program hw4q2;

var
   X,Y,W,Z : integer ;

  function add1(var param : integer):integer ;
    begin
      param := param + 1 ;
      add1 := param ;
    end;(*fxn add1*)

  function subtract2(var param : integer):integer ;
    begin
      param := param - 2 ;
      subtract2 := param ;
    end;(*fxn subtract2*)

  function double(var param : integer):integer ;
    begin
      param := param * 2 ;
      double := param ;
    end;(*fxn double*)

  function triple(var param : integer):integer ;
    begin
      param := param * 3 ;
      triple := param ;
    end;(*fxn triple*)

(*Main program*)
begin
  (*identification*)
  writeln('Mark Sattolo 428500, CSI3125, DGD-2, Homework#4') ;
  writeln ;
  (*calculate the expression for a sequence of values in a loop*)
  writeln('We will calculate the expression for 2 to a maximum value.') ;
  write('Enter the maximum input value for the loop: ') ;
  readln(Y) ;
  (*start the loop*)
  for X := 2 to Y do
    begin
    writeln;
    (*preserve the initial value of X*)
    W := X ;
    (*process the expression*)
    Z := triple(X) + subtract2(X) + add1(X) * double(X) * X ;
    (*write out the original and new values*)
    writeln('Starting input value was: ', W) ;
    writeln('Ouput value is: ', Z);
    writeln('Input value now is: ', X);
    (*restore the value of X for the loop*)
    X := W ;
    end ;
 writeln;
 writeln('PROGRAM ENDED.') ;
end.
