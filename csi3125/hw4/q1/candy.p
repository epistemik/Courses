program candy(input,output);

const
     LIMIT = 13 ;
     PI = 3.14159 ;

type
    shape = (round, rectangular, triangular) ;
    filling = (liquor, nuts, nougat) ;
    string = packed array[1..LIMIT] of char ;

var
   top: shape ;
   fill: filling ;
   hite, dim1, dim2, candy_wt: real ;
   input_param: string ;
   response: char ;

function surface_round(radius, nought:real):real ;
    begin
      nought := 0.0 ; (*just to keep the compiler from complaining*)
      surface_round := PI * radius * radius ;
    end;

function surface_rectangular(side1, side2:real):real ;
    begin
      surface_rectangular := side1 * side2 ;
    end;

function surface_triangular(base, height:real):real ;
    begin
      surface_triangular := 0.5 * base * height ;
    end;

function total_weight(function surface(a,b:real):real; shape_param:shape;
                        fill_param:filling; height,dim1,dim2:real):real ;
    var
       unit_weight_of_filling: integer ;
    begin
      shape_param := succ(pred(shape_param)) ; (*just to stop compiler warnings*)
      unit_weight_of_filling := ord(fill_param) + 2 ;
      total_weight := surface(dim1, dim2) * height * unit_weight_of_filling ;
    end;

(*main program*)
begin
  writeln('Mark Sattolo 428500, CSI3125, DGD-2, Homework#4') ;
  writeln ;
 repeat
  write('Enter the shape of the candy top: ');
  readln(input_param);
  if input_param = 'round' then top := round
    else if input_param = 'triangular' then top := triangular
    else top := rectangular ;
  write('Enter the type of filling: ');
  readln(input_param);
  if input_param = 'liquor' then fill := liquor
    else if input_param = 'nuts' then fill := nuts
    else fill := nougat ;
  write('Enter the height of the candy: ');
  readln(hite);
  write('Enter the dimensions of the top: ');
  readln(dim1, dim2);
  case top of
    round: candy_wt := total_weight(surface_round, round, fill, hite, dim1, dim2) ;
    rectangular: candy_wt := total_weight(surface_rectangular, rectangular, fill, hite, dim1, dim2) ;
    triangular: candy_wt := total_weight(surface_triangular, triangular, fill, hite, dim1, dim2) ;
    end;(*case*)
  writeln('This candy weighs ', candy_wt:5:2, ' grams.') ;
  writeln;
  write('Another candy to enter? [Y/N]  ') ;
  readln(response) ;
 until response in ['N', 'n'] ;
 writeln('It has been a pleasure serving you - bye for now.') ;
end.
