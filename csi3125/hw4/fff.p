program p(input, output);

function DEFINITE_INTEGRAL(
      function F(ARG: real): real;
      LOW, HIGH: real): real;
const N_INTERVALS = 10000;
var DELTA, SUM, X: real; I: integer;
begin
   DELTA := (HIGH - LOW) / N_INTERVALS;
   X := LOW;
   SUM := F(X);
   for I := 1 to N_INTERVALS - 1 do
   begin
      X := X + DELTA;
      SUM := SUM + 2.0 * F(X);
   end;
   X := X + DELTA;
   SUM := SUM + F(X);
   DEFINITE_INTEGRAL := 0.5 * DELTA * SUM;
end;

function LI( A: real ): real;
begin
  LI := 2.0*A + 1.0;
end;

function SQ( A: real ): real;
begin
  SQ := sqr(A);
end;

function CU( A: real ): real;
begin
  CU := A*sqr(A);
end;

begin
  writeln(DEFINITE_INTEGRAL(LI,  0.0, 8.0):14:8);
  writeln(DEFINITE_INTEGRAL(SQ,  0.0, 9.0):14:8);
  writeln(DEFINITE_INTEGRAL(CU, -3.0, 3.0):14:8);
end.
