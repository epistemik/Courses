program hw3q3a;

uses
    Unit1 in 'Unit1.pas' {Needed for Delphi to run};

{$R *.RES}

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
   Code : integer ;

   procedure NEG(var test : IRB) ;
   var
      iresult : integer ;
      rresult : real ;
      bresult : Boolean ;
   begin
   with test do
     {check the kind of the variant field, then perform the appropriate
      negation and print the result}
     case kind of
       i : begin
           iresult := -1 * IFIELD ;
           writeln(iresult)
           end ;
       r : begin
           rresult := -1.0 * RFIELD ;
           writeln(rresult)
           end ;
       b : begin
           bresult := not BFIELD ;
           writeln(bresult)
           end ;
     end; //case
   end;//proc NEG

begin //program
 writeln('Mark Sattolo, 428500, CSI3125, DGD-2, Assn#3') ;
 writeln ;
 writeln('Please enter a value preceded by its type (i, r, or b).') ;
 writeln('For example: r 2.55 ') ;

 repeat
 writeln ;
 readln(Vtype, Vval) ;
 {According to Prof.Szpackowicz in class on Nov.9, we can assume that all input
  will be perfect and do not have to do any error-checking for this.}

 //if a boolean
 if Vtype = 'b' then begin
   //set the kind field of V
   V.kind := b ;
   //check for the most probable variations of 'true'
   if ((Vval = ' true') or (Vval = ' True') or (Vval = ' TRUE')) then V.BFIELD := true
   //else can assume the input must be some variation of 'false'
   else V.BFIELD := false ;
   end ;

 //if an integer
 if Vtype = 'i' then begin
   //set the kind field of V
   V.kind := i ;
   //convert the string to an integer value - we can assume Vval will represent an integer
   Val(Vval, Vint, Code) ;
   //set the integer field of V
   V.IFIELD := Vint ;
   end ;

 //if a real
 if Vtype = 'r' then begin
   //set the kind field of V
   V.kind := r ;
   //convert the string to a real value - we can assume Vval will represent a real
   Val(Vval, Vreal, Code) ;
   //set the real field of V
   V.RFIELD := Vreal ;
   end ;

 //negate the value in V by calling the NEG procedure
 NEG(V) ;
 until Vtype = 'e' ;
 readln ;

end.//program

