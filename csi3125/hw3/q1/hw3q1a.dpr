
program hw3q1a;

uses
  Unit1 in 'Unit1.pas' {Needed for Delphi to run};

{$R *.RES}

procedure A; forward;
procedure D; forward;

  procedure A;
    procedure B;
      procedure C;
      begin
      writeln('Hello from P.A.B.C') ;
      D ;
      //E ; Not visible.
      writeln('Goodbye from P.A.B.C') ;
      end;//P.A.B.C
    begin
    writeln('Hello from P.A.B') ;
    //D ;
    C ;
    //E ;
    writeln('Goodbye from P.A.B') ;
    end;//P.A.B
  begin
  writeln('Hello from P.A') ;
  //B ;
  //D ;
  //C ;
  //E ;
  writeln('Goodbye from P.A') ;
  end;//P.A

 procedure D;
  procedure E; forward;
  procedure C; forward;
    procedure E;
   //  procedure A; forward;
     procedure B; forward;

      procedure A;
      begin
      writeln('Hello from P.D.E.A') ;
      //B ; //Not visible without 'proc B; forward;'
      //C ; //Not visible.
      writeln('Goodbye from P.D.E.A') ;
      end;//P.D.E.A

      procedure B;
      begin
      writeln('Hello from P.D.E.B') ;
      A ;
      //C ; //Not visible without 'proc C; forward;'
      writeln('Goodbye from P.D.E.B') ;
      end;//P.D.E.B
    begin
    writeln('Hello from P.D.E') ;
    //A ;
    B ;
    //C ;
    writeln('Goodbye from P.D.E') ;
    end;//P.D.E

    procedure C;
      procedure J;
        procedure K;
        begin
        writeln('Hello from P.D.C.J.K') ;
        A ;
        E ;
        //B ; Not visible.
        writeln('Goodbye from P.D.C.J.K') ;
        end;//P.D.C.J.K
      begin
      writeln('Hello from P.D.C.J') ;
      K ;
      //E ;
      //B ; Not visible.
      writeln('Goodbye from P.D.C.J') ;
      end;//P.D.C.J
    begin
    writeln('Hello from P.D.C') ;
    //A ;
    //E ;
    //J ;
    //B ;
    writeln('Goodbye from P.D.C') ;
    end;//P.D.C
  begin
  writeln('Hello from P.D') ;
  //A ;
  E ;
  //E ;
  //B ;
  writeln('Goodbye from P.D') ;
  end;//P.D

begin
writeln('Hello from P') ;
D ;
//D ; Not visible
//B ;
//E ;
writeln('Goodbye from P: [press enter]') ;
readln;
end.

