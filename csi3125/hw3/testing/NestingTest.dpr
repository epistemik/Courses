program NestingTest;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Needed for Delphi to run.};

{$R *.RES}

var X: integer;
procedure C; forward;
//procedure B; forward; = Unsatisfied forward or external declaration: 'B'.

  procedure A;
    var Y: char;
    procedure B;
      var Z: Boolean;
      begin
      writeln('Hello from B') ;
      //A ;
      //C ;
      writeln('Goodbye from B') ;
      end;
    begin
    writeln('Hello from A') ;
    B ;
    //C ;
    writeln('Goodbye from A') ;
    end;

  procedure C;
    var Z: integer;
    begin
    writeln('Hello from C') ;
    A ;
    //B ; Not visible.
    writeln('Goodbye from C') ;
    end;

begin
writeln('Hello from P') ;
A ;
//B ; Not visible
C ;
writeln('Goodbye from P: [press enter]') ;
readln;
end.
