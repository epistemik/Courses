Standard ML of New Jersey, Version 110.0.6, October 31, 1999 [CM&CMB]
- fun sq x = x * x;
val sq = fn : int -> int
- fun sqr x: real = x * x;
val sqr = fn : real -> real
- sqr 17.5;
val it = 306.25 : real
- sq 17 ;
val it = 289 : int
- datatype tree = nul | node of int * tree * tree ;
datatype tree = node of int * tree * tree | nul
- val t1 = node (3, node (0, nul,
=                            node (1, nul,
=                                     node (2, nul, nul))),
=                   node (4, nul,
=                            node (6, node (5, nul, nul),
= GC #0.0.0.0.1.9:   (50 ms)
                                    nul)) );
val t1 = node (3,node (0,nul,node #),node (4,nul,node #)) : tree
- val t1 = node (3, node (0, nul, node (1, nul, node (2, nul, nul))), node (4, n
ul, node (6, node (5, nul,  nul),nul)) );
val t1 = node (3,node (0,nul,node #),node (4,nul,node #)) : tree
- t1;
val it = node (3,node (0,nul,node #),node (4,nul,node #)) : tree
- node;
val it = fn : int * tree * tree -> tree
- fun sum_nodes(node(a, L, R)) = a + (sum_nodes(L)) + sum_nodes(R);
stdIn:34.1-34.65 Warning: match nonexhaustive
          node (a,L,R) => ...

val sum_nodes = fn : tree -> int
- sum_nodes(t1);

uncaught exception nonexhaustive match failure
  raised at: stdIn:34.32
- fun sum_nodes(node(a,nul,nul)) = a |
=     sum_nodes(node(a,L,nul)) = a + sum_nodes(L) |
=     sum_nodes(node(a,nul,R)) = a + sum_nodes(R) |
=     sum_nodes(node(a,L,R)) = a + sum_nodes(L) + sum_nodes(R);
stdIn:1.1-38.61 Warning: match nonexhaustive
          node (a,nul,nul) => ...
          node (a,L,nul) => ...
          node (a,nul,R) => ...
          node (a,L,R) => ...

val sum_nodes = fn : tree -> int
- sum_nodes(t1);
val it = 21 : int
-
