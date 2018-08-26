program p(input, output);

function DEFINITE_INTEGRAL(
      function F(ARG: real): real;
      LOW, HIGH: real): real;
const N_INTERVALS = 1000;
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

function SQ( A: real ): real;
begin
  SQ := sqr(A);
end;

begin
  writeln(DEFINITE_INTEGRAL(SQ, 0.0, 9.0));
end.
