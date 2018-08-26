program sideFX;

var
   X,Z : integer ;

  function add1(var param : integer):integer ;
    begin
      param := param + 1 ;
      add1 := param ;
    end; (*fxn add1*)

  function subtract2(var param : integer):integer ;
    begin
      param := param - 2 ;
      subtract2 := param ;
    end; (*fxn subtract2*)

  function double_(var param : integer):integer ;
    begin
      param := param * 2 ;
      double_ := param ;
    end; (*fxn double*)

  function triple(var param : integer):integer ;
    begin
      param := param * 3 ;
      triple := param ;
    end; (*fxn triple*)

(*Main program*)
begin
  writeln('Mark Sattolo 428500, CSI3125, DGD-2, Homework#4') ;
 repeat
  writeln ;
  write('Enter the input parameter: ');
  readln(X);
  Z := triple(X) + subtract2(X) + add1(X) * double_(X) * X ;
  writeln('Ouput value is: ', Z);
  writeln('Input value now is: ', X);
 until X > 3991 ;
end.
