
program hw3q1bonus;

uses
  Unit1 in 'Unit1.pas' {Needed for Delphi to run};

{$R *.RES}

var
   x : Integer = 1 ;
   y : Integer = 5 ;

procedure A; forward;
procedure D; forward;

  procedure A;
  var y : Integer;
    procedure B;
    var x : Integer;
      procedure C;
      begin
      write(x) ;
      writeln(y) ;
      end;//P.A.B.C
    begin
    x := 2 ;
    write(x) ;
    writeln(y) ;
    C ;
    end;//P.A.B
  begin
  y := 8 ;
  write(x) ;
  writeln(y) ;
  D ;
  end;//P.A

 procedure D;
    procedure E;
    var y : Integer ;
      procedure A; forward;
      procedure B; forward;

      procedure A;
      var x : Integer ;
      begin
      x := 4 ;
      write(x) ;
      writeln(y) ;
      end;//P.D.E.A

      procedure B;
      var x : Integer ;
      begin
      x := 3 ;
      write(x) ;
      writeln(y) ;
      end;//P.D.E.B
    begin
      y := 6 ;
      write(x) ;
      writeln(y) ;
      A ;
      B ;
    end;//P.D.E

    procedure C;
    var y : Integer ;
      procedure J;
      begin
      write(x) ;
      writeln(y) ;
      end;//P.D.C.J
    begin
    y := 7 ;
    write(x) ;
    writeln(y) ;
    J ;
    end;//P.D.C
  begin
  write(x) ;
  writeln(y) ;
  //A ;
  C ;
  end;//P.D

begin
write(x) ;
writeln(y) ;
A ;
//D ;
readln;
end.

