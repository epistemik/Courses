program hw3q3b;

var
   Vtype : char ;
   Vval : string ;
   Vint : integer ;
   Vreal : real ;
   Vbool : Boolean ;
   strCode : integer ;

   (*Only one procedure is needed to negate the input, but without using variant
    records, we then need separate variables for each different type of input,
    plus a test variable to serve as the equivalent of the 'kind' field in the
    variant record.  Thus, we are being wasteful as we have to send along two
    "dummy variables" in each procedure call instead of just the variable type
    actually given by the user.  The variable 'test' will indicate which kind
    of input was given.  We can then negate this value and print the result.*)
   procedure NEG(test : char; ival : integer; rval : real; bval : Boolean) ;
   begin
      case test of
       'i' : begin
             ival := -1 * ival ;
             writeln('Negation of input is: ', ival)
             end ;
       'r' : begin
             rval := -1.0 * rval ;
             writeln('Negation of input is: ', rval)
             end ;
       'b' : begin
             bval := not bval ;
             writeln('Negation of input is: ', bval)
             end ;
     end; (*case*)
   end;(*proc NEG*)

begin (*program*)
 (*identification*)
 writeln('Mark Sattolo, 428500, CSI3125, DGD-2, Homework#3') ;
 writeln ;

 (*initialize the variables*)
 Vint := 0 ;
 Vreal := 0.0 ;
 Vbool := false ;

 (*ask for the input*)
 writeln('Please enter a value preceded by its type (i, r, or b).') ;
 writeln('For example: r 3.14129') ;
 writeln ;
 write('Input: ') ;
 (*get the input*)
 readln(Vtype, Vval) ;

 (*According to Prof.Szpackowicz in class on Nov.9, we can assume that all input
  will be perfect and do not have to do any error-checking for this.*)

 (*if a boolean*)
 if Vtype = 'b' then begin
   (*check for the most probable variations of 'true'*)
   if ((Vval = ' true') or (Vval = ' True') or (Vval = ' TRUE')) then
     Vbool := true
     (*else can assume the input must be some variation of 'false'*)
   else Vbool := false ;
   end ;

 (*if an integer*)
 if Vtype = 'i' then
   (*convert the string to an integer - we can assume Vval will represent an integer*)
   Val(Vval, Vint, strCode) ;

 (*if a real*)
 if Vtype = 'r' then
   (*convert the string to a real - we can assume Vval will represent a real*)
   Val(Vval, Vreal, strCode) ;

 (*negate the input value by calling the NEG procedure*)
 NEG(Vtype, Vint, Vreal, Vbool) ;

end.
