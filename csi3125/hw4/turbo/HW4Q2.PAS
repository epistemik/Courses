program hw4q2;

var
   X,Y,W,Z : integer ;

 (*Each function will print out that it has been called
   and will give the new value of X inside that function.*)

  function add1(var param : integer):integer ;
    begin
      writeln('Inside add1.') ;
      param := param + 1 ;
      writeln('Value of X now is: ', param) ;
      add1 := param ;
    end;(*fxn add1*)

  function subtract2(var param : integer):integer ;
    begin
      writeln('Inside subtract2.') ;
      param := param - 2 ;
      writeln('Value of X now is: ', param) ;
      subtract2 := param ;
    end;(*fxn subtract2*)

  function double_(var param : integer):integer ;
    begin
      writeln('Inside double_.') ;
      param := param * 2 ;
      writeln('Value of X now is: ', param) ;
      double_ := param ;
    end;(*fxn double_*)

  function triple(var param : integer):integer ;
    begin
      writeln('Inside triple.') ;
      param := param * 3 ;
      writeln('Value of X now is: ', param) ;
      triple := param ;
    end;(*fxn triple*)

(*Main program*)
begin
  (*identification*)
  writeln('Mark Sattolo 428500, CSI3125, DGD-2, Homework#4') ;
  writeln ;
  (*calculate the expression for a sequence of values in a loop*)
  writeln('We will calculate from X = 1 to a maximum value.') ;
  write('Enter the maximum integer value for the loop: ') ;
  (*can assume that the input is perfect*)
  readln(Y) ;
  (*start the loop*)
  for W := 1 to Y do
    begin
    writeln;
    (* set the initial value of X*)
    X := W ;
    (* print out the initial value *)
    writeln(' >> Starting input value was: ', X) ;
    (*process the expression*)
    Z := triple(X) + subtract2(X) + add1(X) * double_(X) * X ;
    (*write out the new values*)
    writeln(' >> Ouput value is: ', Z);
    writeln(' >> Input value now is: ', X);
    end ;
 writeln;
 writeln('   PROGRAM ENDED.') ;
end.

