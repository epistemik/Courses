
program hw3q2pascal;

uses
  Unit1 in 'Unit1.pas' {Needed for Delphi to run};

{$R *.RES}

const a = 27 ;
      b = 13 ;
      c = a + 2*b ;

begin
     writeln(3*c) ;
     writeln(3*(c)) ;
     //c := a + b ; Left side cannot be assigned to.
     readln;
end.

