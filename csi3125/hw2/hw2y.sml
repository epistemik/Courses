
val tol = 0.000001;

fun calc(x,y) = 0.5 * (y + x/y);

fun test(a,b) : real = abs(a - b*b);

fun sqroot(num, guess) = if test(num, calc(num, guess)) < tol then calc(num, guess) else sqroot(num, calc(num, guess));

fun square_root(x) = if x < 0.0 then ~1.0 else sqroot(x, 1.0);


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

fun sum_nodes(node(a,nul,nul)) = a |
    sum_nodes(node(a,L,nul)) = a + sum_nodes(L) |
    sum_nodes(node(a,nul,R)) = a + sum_nodes(R) |
    sum_nodes(node(a,L,R)) = a + sum_nodes(L) + sum_nodes(R) ;

fun tree_height(nul) = 0 |
    tree_height(node(a,nul,nul)) = 1 |
    tree_height(node(a,L,nul)) = 1 + tree_height(L) |
    tree_height(node(a,nul,R)) = 1 + tree_height(R) |
    tree_height(node(a,L,R)) = 1 + max(tree_height(L), tree_height(R)) ;

