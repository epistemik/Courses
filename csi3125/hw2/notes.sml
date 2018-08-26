2 + 3 * 4;

fun succ x = x + 1;

3 * succ 4 * succ 5;

fun length( x ) =
    if null( x ) then 0
    else 1+length( tl( x ) );

length( [11, 33, 55] );

length( ["11", "abc"] );

fun length( nil ) = 0 |
    length( a::x ) = 1+length( x );
(* val length = fn : 'a list -> int *)

length( nil );

fun length nil = 0 |
    length ( a::x ) = 1+length x;

length ( ["a", "bb", "ccc"] );

fun append( x, z ) =
    if null( x ) then z else
    hd(x) :: append( tl(x), z );

append([1, 2, 3, 4], [5, 6, 7]);

fun append( nil, z ) = z |
    append( a::y, z ) =
          a :: append( y, z );

append( [1, 2, 3, 4], [5, 6] );

append( ["a", "b"], [3] );

append(["a", "b"], ["cc", "dd"]);

["a", "b"] @ ["cc", "dd"];

"abcd" ^ "efghijk";

fun reverse( nil, z ) = z |
    reverse( a::y, z ) = reverse( y, a::z );

reverse( [1, 2, 3], [4] );

fun rev x = reverse( x, nil );

rev( [1, 2, 3] );

fun same_neighbours L =
   if null L then false else
   if null (tl L) then false else
   if hd L = hd (tl L) then true
   else same_neighbours (tl L);

same_neighbours [3, 4, 5, 6];

same_neighbours [3, 4, 4, 5, 6];

fun same_neighbours nil = false |
   same_neighbours (a::nil) = false |
   same_neighbours (a::b::L) =
     if a = b then true else same_neighbours (b::L);

fun succ x = x + 1;

fun succr x = x + 1.0;

fun sq x = x * x;

fun sq x: int = x * x;

fun sq x = x * x : int;

fun sq x =(x: int) * x;

length 7::[];

length( 7::[] );

length( 7::8::nil );

"a"::"bb"::nil @
"c"^"cc"::"dddd"::"eee"::nil;

length ["abcd"]::2*11::nil @
333::4400+44::555::nil;

map sq [1, 3, 5];

map sq
    ( map hd [ 1::[11],
               2::[22, 222, 2222],
               3::[33, 333]] );

fun map f nil = nil |
    map f ( a::y ) = ( f a ) :: map f y;

fun add x y: int = x + y;

val succ2 = add 2;

succ2 7;

val squarelist = map sq;

squarelist [5,7,11];

val lengths = map length;

lengths [[1], [2, 3], [4,5,6]];

fun mapp( f, nil ) = nil |
    mapp( f, a::y ) = ( f a ) :: mapp( f, y );

mapp( sq, [1, 2, 3] );

map ( fn x => x*x*x ) [2, 3, 4];

val sq = fn x:int => x*x;

sq 12;

sq ~12;

map ( sq o sq ) [2, 3, 4];

val pow4 = sq o sq;

pow4 4;

val second = hd o tl;

second [5, 3, 8];

hd o tl [5, 3, 8];

(hd o tl)
[fn x=>x:int, fn x=>x*x:int] 7;

fun reduce(f, nil, v0) = v0 |
    reduce(f, ( a::y ), v0) = f(a, reduce(f, y, v0));

reduce(fn(x, y:int)=>x+y, [1, 2, 3, 4], 0);

reduce(fn(x, y:int)=> x*y, [1, 2, 3, 4], 1);

reduce(op +, [1, 2, 3, 4], 0);

reduce(op *, [1, 2, 3, 4], 1);

fun reduce f nil v0 = v0 |
    reduce f ( a::y ) v0 = f( a, reduce f y v0 );

datatype colour = red | amber | green;

red;

length [red,green,red,amber];

datatype tree = nul | node of int * tree * tree;

node;

fun left(node(a, L, R)) = L;

exception NoRight;

fun right(node(a, L, R)) = R |
    right(nul) = raise NoRight;

right nul;

fun insert( a, nul ) =
       node( a, nul, nul ) |
    insert( a, node( b, L, R ) ) =
       if a < b then
         node( b, insert( a, L ), R )
       else if a > b then
         node( b, L, insert( a, R ) )
       else node( b, L, R );

fun inorder(nul) = nil |
    inorder(node(a, L, R)) = inorder(L) @ (a::inorder(R));

val my_tree = 
    insert(7, insert(3, insert(9,
    insert(4, insert(3, nul)))));

right(my_tree);

right(right(my_tree));

inorder( my_tree );

let val aa = [1,2]
in tl aa
end;

aa;

let val aa=[1,2] and bb=[3,4,5]
in aa @ bb
end;

let val aa = [1,2]
in let val bb = [3,4,5]
   in aa @ bb
   end
end;

let val (aa,    bb) =
        ([1,2], [3,4,5])
in aa @ bb
end;

local fun divides(x, y) =
          y mod x = 0
in fun anniversary age =
          divides(10, age) orelse
          divides(25, age)
end;

anniversary 30;

anniversary 45;

fun mirror ( p as ( x, y ) ) = ( p, ( y, x ) );

mirror (6,17);

local
  fun minl_aux(elt, lst): int =
    if null lst then elt
    else if elt > hd(lst) then
       minl_aux(hd lst, tl lst)
    else minl_aux(elt, tl lst)
in
  fun minl L =
    if null L then ~1000000000
    else minl_aux(hd L, tl L)
end;

minl [1, 2, 3, 0, 5, 4, ~9, 8];

( 3, 4 ) = ( 4, 3 );

{ a=3, b=4 } = { b=4, a=3 };

( 3, "four" ) = ( "four", 3 );

{ a = 3, b = "four" } =
{ b = "four", a = 3 };

datatype 'a list = null | cons of 'a * ('a list);

cons(1, cons(2, null));

cons("aa", cons("bb", null));

val twoFunc = cons(fn x:int=>x*x*x,
                   cons(fn x=>x*x, null));

fun head(cons(x, y)) = x;

head(twoFunc) 3;

