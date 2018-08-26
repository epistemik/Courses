program ActivationStack;
//from p.285 of CSI3125 lecture notes

uses
  Unit1 in 'Unit1.pas' {Needed for Delphi};

{$R *.RES}

var A, B: integer;

    procedure P( C: integer;
                 var D: integer);
    begin {P}
    {P1} C := C + 2;
    {P2} D := D + 3;
    {P3} writeln('P: ', A, ' ', B, ' ', C, ' ', D);
    {P4} end;

    procedure Q( var C: integer);
    var B: integer;

        procedure R( C: integer);
        begin {R}
        {R1} C := 29;
        {R2} P(B, C);
        {R3} writeln('R: ', A, ' ', B, ' ', C);
        {R4} end;

    begin {Q}
    {Q1} B := 23;
    {Q2} R(A);
    {Q3} P(B, C);
    {Q4} writeln('Q: ', A, ' ', B, ' ', C);
    {Q5} end;

begin {Main}
{M1} A := 6;
{M2} B := 17;
{M3} P(B, A);
{M4} writeln('M: ', A, ' ', B);
{M5} Q(A);
{M6} writeln('M: ', A, ' ', B);
     readln; //just to keep the console open to see the results
{M7} end.

