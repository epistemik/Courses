
datatype shapes = round | rectangular | triangular ;
datatype fillings = liquor | nuts | nougat ;

local
   val pi = 3.14159
   fun surface_round radius nought = pi * radius * radius
   fun surface_rectangular side1 side2 : real = side1 * side2
   fun surface_triangular base height = 0.5 * base * height

   fun total_weight shape filling height dim1 dim2 fxn : real = 
                    if filling = liquor then 2.0 * (fxn dim1 dim2) * height
                    else if filling = nuts then 3.0 * (fxn dim1 dim2) * height
                    else 4.0 * (fxn dim1 dim2) * height

in fun candy shape filling height dim1 dim2 = 
       if shape = round then total_weight shape filling height dim1 dim2 surface_round
       else if shape = rectangular then total_weight shape filling height dim1 dim2 surface_rectangular
       else total_weight shape filling height dim1 dim2 surface_triangular : real end ;
