program Candy;

uses
    Unit1 in 'Unit1.pas' {Needed for Delphi to run};

{$R *.RES}

type
    shape = (round, rectangular, triangular) ;
    filling = (liquor, nuts, nougat) ;
    candy_fxn = function(dim1, dim2:real):real ;

const
     ShapeString : array [shape] of string = ('round', 'rectangular', 'triangular');
     FillString : array [filling] of string = ('liquor', 'nuts', 'nougat');

var
   top: shape ;
   fill: filling ;
   hite, dim1, dim2, candy_wt: real ;
   input_param: string ;

  function surface_round(radius, nought:real):real ;
    begin
      surface_round := Pi * radius * radius ;
    end;

  function surface_rectangular(side1, side2:real):real ;
    begin
      surface_rectangular := side1 * side2 ;
    end;

  function surface_triangular(base, height:real):real ;
    begin
      surface_triangular := 0.5 * base * height ;
    end;

  function total_weight(surface:candy_fxn; shape_param:shape;
                        fill_param:filling; height,dim1,dim2:real):real ;
    var
       unit_weight_of_filling: integer ;
    begin
      unit_weight_of_filling := ord(fill_param) + 2 ;
      total_weight := surface(dim1, dim2) * height * unit_weight_of_filling ;
    end;

begin
  writeln('Mark Sattolo 428500, CSI3125, DGD-2, Homework#4') ;
 repeat
  writeln ;
  candy_wt := 0.0 ; (*just to keep the compiler quiet*)
  writeln('Enter the shape of the candy top: ');
  readln(input_param);
  top := round ;
  while (top < triangular) and (ShapeString[top] <> input_param) do inc(top) ;
  writeln('Enter the type of filling: ');
  readln(input_param);
  fill := liquor ;
  while (fill < nougat) and (FillString[fill] <> input_param) do inc(fill) ;
  writeln('Enter the height of the candy: ');
  readln(hite);
  writeln('Enter the dimensions of the top: ');
  readln(dim1, dim2);
  case top of
    round: candy_wt := total_weight(surface_round, round, fill, hite, dim1, dim2) ;
    rectangular: candy_wt := total_weight(surface_rectangular, rectangular, fill, hite, dim1, dim2) ;
    triangular: candy_wt := total_weight(surface_triangular, triangular, fill, hite, dim1, dim2) ;
  end;//case
  writeln('This is a ', ShapeString[top], ' candy filled with ', FillString[fill], ' which weighs ', candy_wt:8:4, ' grams.') ;
 until hite = 666 ;
 readln ;
end.
