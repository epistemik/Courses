(* Mark Sattolo  428500
   CSI3125, DGD-2
   HW4, Q1 *)

(* set the types *)
datatype shapes = round | rectangular | triangular ;
datatype fillings = liquor | nuts | nougat ;

local
(* set constant pi *)
   val pi = 3.14159
(* define the surface computation functions *)
   fun surface_round radius nought = pi * radius * radius
   fun surface_rectangular side1 side2 : real = side1 * side2
   fun surface_triangular base height = 0.5 * base * height

(* calculate the weight with the passed function, with the
   proper value for each filling *)
   fun total_weight shape filling height dim1 dim2 fxn : real = 
                    if filling = liquor then 2.0 * (fxn dim1 dim2) * height
                    else if filling = nuts then 3.0 * (fxn dim1 dim2) * height
                    else 4.0 * (fxn dim1 dim2) * height

(* the main function will pass the proper surface function 
   to total_weight based on the shape of the candy *)
in fun candy shape filling height dim1 dim2 = 
       if shape = round then total_weight shape filling height dim1 0.0 surface_round
       else if shape = rectangular then total_weight shape filling height dim1 dim2 surface_rectangular
       else total_weight shape filling height dim1 dim2 surface_triangular : real end ;
