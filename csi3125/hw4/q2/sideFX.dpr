program sideFX;

uses
    Unit1 in 'Unit1.pas' {Needed for Delphi to run};

{$R *.RES}

var
   X,Z : integer ;

  function add1(var param : integer):integer ;
    begin
      param := param + 1 ;
      add1 := param ;
    end;//fxn add1

  function subtract2(var param : integer):integer ;
    begin
      param := param - 2 ;
      subtract2 := param ;
    end;//fxn subtract2

  function double(var param : integer):integer ;
    begin
      param := param * 2 ;
      double := param ;
    end;//fxn double

  function triple(var param : integer):integer ;
    begin
      param := param * 3 ;
      triple := param ;
    end;//fxn triple

(*Main program*)
begin
  writeln('Mark Sattolo 428500, CSI3125, DGD-2, Homework#4') ;
 repeat
  writeln ;
  writeln('Enter the input parameter: ');
  readln(X);
  Z := triple(X) + subtract2(X) + add1(X) * double(X) * X ;
  writeln('Ouput value is: ', Z);
  writeln('Input value now is: ', X);
 until X = 3994 ;
 readln ;
end.

