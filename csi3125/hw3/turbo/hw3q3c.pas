program hw3q3c;

type
    TAGTYPE = (i, r, b);
    IRB = record
             case kind: TAGTYPE of
               i: (IFIELD: integer);
               r: (RFIELD: real);
               b: (BFIELD: Boolean);
          end;
var
   Vtype : char ;
   Vval : string ;
   Vint : integer ;
   Vreal : real ;
   V : IRB ;
   sCode : integer ;

   procedure NEG(var test : IRB) ;
     (*This program forgets to check the kind of the variant record
       and operates on the variant record as if all the fields are
       present and meaningful at the same time.  As a result, some
       of the results of this program may sometimes be correct,
       but they will never be trustworthy.*)
   var
      principal : integer ;
      rate, interest : real ;
      changeRate : Boolean ;
   begin
        (*set the integer, real, and Boolean variables*)
        changeRate := test.BFIELD ;
        principal := test.IFIELD ;
        rate := test.RFIELD ;
        writeln ;
        writeln('Change effective interest rate: ', changeRate) ;
       (*Perform an operation using the numbers, based on the Boolean value,
         and print the results.  *)
     if changeRate = true then
       rate := 0.5 * rate ;
     interest := principal * rate ;
     writeln('Principal is ', principal) ;
     writeln('Rate is ', rate) ;
     writeln('Interest is ', interest) ;
   end;(*proc NEG*)

begin (*program*)
 (*identification*)
 writeln('Mark Sattolo, 428500, CSI3125, DGD-2, Homework#3') ;
 writeln ;
 (*request input*)
 writeln('Please enter a value preceded by its type (i, r, or b).') ;
 writeln('For example: r 3.14129 ') ;
 writeln ;
 (*get input*)
 readln(Vtype, Vval) ;

 (*According to Prof.Szpackowicz in class on Nov.9, we can assume that all input
  will be perfect and do not have to do any error-checking for this.*)

 (*if a boolean*)
 if Vtype = 'b' then begin
   (*set the kind field of V*)
   V.kind := b ;
   (*check for the most probable variations of 'true'*)
   if ((Vval = ' true') or (Vval = ' True') or (Vval = ' TRUE')) then V.BFIELD := true
   (*else can assume the input must be some variation of 'false'*)
   else V.BFIELD := false ;
   end ;

 (*if an integer*)
 if Vtype = 'i' then begin
   (*set the kind field of V*)
   V.kind := i ;
   (*convert the string to an integer value - we can assume Vval will represent an integer*)
   Val(Vval, Vint, sCode) ;
   (*set the integer field of V*)
   V.IFIELD := Vint ;
   end ;

 (*if a real*)
 if Vtype = 'r' then begin
   (*set the kind field of V*)
   V.kind := r ;
   (*convert the string to a real value - we can assume Vval will represent a real*)
   Val(Vval, Vreal, sCode) ;
   (*set the real field of V*)
   V.RFIELD := Vreal ;
   end ;

 (*negate the value in V by calling the NEG procedure*)
 NEG(V) ;

end.(*program*)
