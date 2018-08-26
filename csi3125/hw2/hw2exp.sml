
(* val calc = fn(x, y:real) => 0.5 * (y + x/y); *)

let val tol = 0.000001 and
calc = fn(x, y:real) => 0.5 * (y + x/y) and
test = fn(a, b:real) => abs(a - b*b) and
sqroot = fn(num, guess:real) => if test(num, calc(num, guess)) < tol then calc(num, guess) else sqroot(num, calc(num, guess)) 
in fun square_root x = if x < 0.0 then ~1.0 else sqroot(x, 1.0) end;


(* THIS ONE WORKS!! *)

local
   val tol = 0.000001 
   fun calc x y:real = 0.5 * (y + x/y)
   fun test a b:real = abs(a - b*b)
   fun sqroot num guess = if test num (calc num guess) < tol then (calc num guess) else sqroot num (calc num guess)
in fun square_root x = if x < 0.0 then ~1.0 else sqroot x 1.0 end ;




datatype tree = nul | node of int * tree * tree ;

val t1 = node (3, node (0, nul,
                           node (1, nul,
                                    node (2, nul, nul))),
                  node (4, nul,
                           node (6, node (5, nul, nul),
                                    nul)) );

val t2 = node (33, node (11, nul,
                             node (22, nul, nul)),
                   node (44, nul,
                             node (66, nul, nul)) );

val t3 = node (44, node (22, node (11, nul, nul),
                             node (33, nul, nul)),
                   node (66, node (55, nul, nul),
                             node (77, nul, nul)) );

val t4 = node (77, node (44, node (22, node (11, nul,
                                                 node (33, nul, nul)),
                                       nul),
                             node (55, nul, nul)),
                   node (88, node (66, nul, nul),
                             node (99, nul, nul)) );

fun max(x,y) : int = if x > y then x else y ;

exception NoSumForTree ;

fun sum_nodes(nul) = raise NoSumForTree |
    sum_nodes(node(h,nul,nul)) = h |
    sum_nodes(node(h,L,nul)) = h + sum_nodes(L) |
    sum_nodes(node(h,nul,R)) = h + sum_nodes(R) |
    sum_nodes(node(h,L,R)) = h + sum_nodes(L) + sum_nodes(R) ;

fun tree_height(nul) = 0 |
    tree_height(node(h,nul,nul)) = 1 |
    tree_height(node(h,L,nul)) = 1 + tree_height(L) |
    tree_height(node(h,nul,R)) = 1 + tree_height(R) |
    tree_height(node(h,L,R)) = 1 + max(tree_height(L), tree_height(R)) ;

fun is_balanced(nul) = true |
    is_balanced(node(h,nul,nul)) = true |
    is_balanced(node(h,L,nul)) = if tree_height(L) <= 1 then true else false |
    is_balanced(node(h,nul,R)) = if tree_height(R) <= 1 then true else false |
    is_balanced(node(h,L,R)) = if is_balanced(L) andalso is_balanced(R) 
                               andalso (abs(tree_height(L) - tree_height(R)) <= 1) then true else false ;



fun reduce(f, nil, v0) = v0 |
    reduce(f, ( a::y ), v0) = f(a, reduce(f, y, v0));

reduce(op +, map (fn x => #f(x) + #m(x)) [{f=4723,m=6457},{f=1445,m=986},{f=2072,m=2918},{f=47,m=72}], 0);
