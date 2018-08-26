
- val lengths = map length;
stdIn:31.1-31.25 Warning: type vars not generalized because of
   value restriction are instantiated to dummy types (X1,X2,...)
val lengths = fn : ?.X1 list list -> int list
- length;
val it = fn : 'a list -> int
- lengths [[1], [2,3], [4,5,6]];
stdIn:34.1-34.30 Error: operator and operand don't agree [literal]
  operator domain: ?.X1 list list
  operand:         int list list
  in expression:
    lengths ((1 :: nil) :: (2 :: <exp> :: <exp>) :: (<exp> :: <exp>) :: nil)


- val second = hd o tl;
stdIn:37.1-37.21 Warning: type vars not generalized because of
   value restriction are instantiated to dummy types (X1,X2,...)
val second = fn : ?.X1 list -> ?.X1
- second [5,3,8];
stdIn:38.1-38.15 Error: operator and operand don't agree [literal]
  operator domain: ?.X1 list
  operand:         int list
  in expression:
    second (5 :: 3 :: 8 :: nil)
