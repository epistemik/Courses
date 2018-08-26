program Test_Integral;

uses
    Unit1 in 'Unit1.pas' {Form1};

type
    R2Rfxn = function(ARG: real): real ;

var
   lower, upper, result: real ;
   continue: char ;

{$R *.RES}

    function DEFINITE_INTEGRAL( F: R2Rfxn; LOW, HIGH: real): real;
    const
        N_INTERVALS = 1000;
    var
       DELTA, SUM, X: real;
       I: integer;
    begin
         DELTA := (HIGH - LOW) / N_INTERVALS;
         X := LOW;
         SUM := F(X);
         for I := 1 to N_INTERVALS - 1 do
            begin
            X := X + DELTA;
            SUM := SUM + 2.0 * F(X)
            end;
         X := X + DELTA;
         SUM := SUM + F(X);
         DEFINITE_INTEGRAL := 0.5 * DELTA * SUM
    end;//fxn DEFINITE_INTEGRAL

    function SQ( A: real ): real;
    begin SQ := sqr(A) end;

begin //main
     writeln('We will integrate under the curve y = x**2') ;
     repeat
       writeln ;
       write('Enter the lower limit of integration: ') ;
       readln(lower) ;
       write('Enter the upper limit of integration: ') ;
       readln(upper) ;
       result := DEFINITE_INTEGRAL(SQ, lower, upper) ;
       writeln('Area is ', result:4:4) ;
       write('Enter another pair of values [Y/N]? ') ;
       readln(continue) ;
     until continue in ['n', 'N'] ;
end.

