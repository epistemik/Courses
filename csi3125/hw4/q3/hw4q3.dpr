program hw4q3;

uses
    Math, Unit1 in 'Unit1.pas' {Needed for Delphi to run};

{$R *.RES}

var
   A,B,X,Y,F : integer ;
   response : char ;

function odd(t:integer):boolean ;
  begin
  if (t mod 2) = 1 then
    odd := true
  else
      odd := false;
  end;

(*Main program*)
begin
  writeln('Mark Sattolo 428500, CSI3125, DGD-2, Homework#4') ;
 repeat
  writeln ;
  write('Enter parameter A [ >0 ]: ');
  readln(A);
  write('Enter parameter B [ >0 ]: ');
  readln(B);
  {A > 0 & B > 0}
  X := A;
  Y := B;
  F := 1;
  while Y <> 0 do
    begin
    if odd(Y) then
      begin
      Y := Y - 1 ;
      F := F * X ;
      end;
    Y := Y div 2 ;
    X := X * X ;
    end;

  writeln('Input values were ', A, ' and ', B) ;
  writeln('Value of F is: ', F) ;
  writeln('Value of A**B is: ', (IntPower(A,B)):6:0) ;
  writeln;
  writeln('Another set of input values? [Y/N] ');
  readln(response);
 until response in ['n', 'N'] ;
end.

