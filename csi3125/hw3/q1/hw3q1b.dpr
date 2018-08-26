program hw3q1b;

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
      write('P.A.B.C : ') ;
      write(x) ;
      writeln(y) ;
      end;//P.A.B.C
    begin
    x := 2 ;
    write('P.A.B : ') ;
    write(x) ;
    writeln(y) ;
    C ;
    end;//P.A.B
  begin
  y := 8 ;
  write('P.A : ') ;
  write(x) ;
  writeln(y) ;
  B ;
  end;//P.A

 procedure D;
  procedure E; forward;
  procedure C; forward;

    procedure E;
     var y : Integer ;
     procedure A; forward;
     procedure B; forward;

      procedure A;
      var x : Integer ;
      begin
      x := 4 ;
      write('P.D.E.A : ') ;
      write(x) ;
      writeln(y) ;
      end;//P.D.E.A

      procedure B;
      var x : Integer ;
      begin
      x := 3 ;
      write('P.D.E.B : ') ;
      write(x) ;
      writeln(y) ;
      end;//P.D.E.B
    begin
      y := 6 ;
      write('P.D.E : ') ;
      write(x) ;
      writeln(y) ;
      A ;
      B ;
    end;//P.D.E

    procedure C;
    var y : Integer ;
      procedure J;
      begin
      write('P.D.C.J : ') ;
      write(x) ;
      writeln(y) ;
      end;//P.D.C.J
    begin
    y := 7 ;
    write('P.D.C : ') ;
    write(x) ;
    writeln(y) ;
    J ;
    end;//P.D.C
  begin
  write('P.D : ') ;
  write(x) ;
  writeln(y) ;
  E ;
  C ;
  end;//P.D

 begin //program
  write('P : ') ;
  write(x) ;
  writeln(y) ;
  A ;
  D ;
  readln;
 end.

