program ScopeTest;

uses
  Unit1 in 'Unit1.pas' {Needed for Delphi to run.};

{$R *.RES}

var X: integer;

  procedure A;
    begin
    X := X + 1;
    writeln(X);
    readln ;
    end;

  procedure B;
    var X: integer;
    begin
    X := 17;
    A;
    end;

begin //program
X := 23;
B;
end.
