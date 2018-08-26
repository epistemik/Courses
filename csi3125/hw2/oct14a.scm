Welcome to Scheme 48 0.52.1 (suspended image).
Copyright (c) 1993, 1994 by Richard Kelsey and Jonathan Rees.
Copyright (c) 1996 by NEC Research Institute, Inc.
Copyright (c) 1998, 1999 by Northwestern University.
Please report all bugs to bug-scheme48@cs.nwu.edu
> ,load "hw2x.scm"
hw2x.scm
> (connected-components graph4)
'(((a (b d)) (b (a)) ((d (a)) ())) ((c (e)) (e (c)) ()) ((d (a))))
> (connected-components graph3)
'(((a (b f)) (b (a c e)) ((f (a)) ((c (b j)) ((e (b i)) ((j (c d h)) ((i (e)) ((d (g j)) ((h (j)) ((g (d)) ()))))))))) ((c (b j)) (j (c d h)) ((d (g j)) ((h (j)) ((g (d)) ())))) ((d (g j)) (g (d)) ()) ((e (b i)) (i (e)) ()) ((f (a))) ((h (j))))
> (connected-components graph2)
'(((a (b f)) (b (a c e)) ((f (a)) ((c (b)) ((e (b i)) ((i (e)) ()))))) ((c (b))) ((d (g j)) (g (d)) ((j (d h)) ((h (j)) ()))) ((e (b i)) (i (e)) ()) ((f (a))) ((h (j)) (j (d h)) ()))
> (connected-components graph1)
'(((a (b f)) (b (a c e)) ((f (a)) ((c (b)) ((e (b i)) ((i (e)) ()))))) ((c (b))) ((d (g j)) (g (d)) ((j (d)) ())) ((e (b i)) (i (e)) ()) ((f (a))) ((h ())) ((j (d))))
> (append (list '(a (b d))) '())
'((a (b d)))
> ,load "hw2.scm"
hw2.scm
> (connected-components graph4)
'(((a (b d)) (b (a)) (d (a))) ((c (e)) (e (c))))
> (connected-components graph3)
'(((a (b f)) (b (a c e)) ((f (a)) ((c (b j)) ((e (b i)) ((j (c d h)) ((i (e)) ((d (g j)) ((h (j)) (g (d)))))))))) ((c (b j)) (j (c d h)) ((d (g j)) ((h (j)) (g (d))))) ((d (g j)) (g (d))) ((e (b i)) (i (e))) ((f (a))) ((h (j))))
> (connected-components graph2)
'(((a (b f)) (b (a c e)) ((f (a)) ((c (b)) ((e (b i)) (i (e)))))) ((c (b))) ((d (g j)) (g (d)) ((j (d h)) (h (j)))) ((e (b i)) (i (e))) ((f (a))) ((h (j)) (j (d h))))
> (connected-components graph1)
'(((a (b f)) (b (a c e)) ((f (a)) ((c (b)) ((e (b i)) (i (e)))))) ((c (b))) ((d (g j)) (g (d)) (j (d))) ((e (b i)) (i (e))) ((f (a))) ((h ())))
> ,load "hw2.scm"
hw2.scm
> (connected-components graph1)
'(((a (b f)) (b (a c e) (f (a) (c (b) (e (b i) (i (e))))))) ((b (a c e)) (c (b) (e (b i) (i (e))))) ((c (b))) ((d (g j)) (g (d) (j (d)))) ((e (b i)) (i (e))) ((f (a))) ((g (d))) ((h ())) ((j (d))))
> ,load "hw2.scm"
hw2.scm
> (connected-components graph1)
'(((a (b f)) (b (a c e)) ((f (a)) ((c (b)) ((e (b i)) (i (e)))))) ((c (b))) ((d (g j)) (g (d)) (j (d))) ((e (b i)) (i (e))) ((f (a))) ((h ())))
> (append (list '(b (a c))) '(a c))
'((b (a c)) a c)
> (list '(b (a c)) '(a c))
'((b (a c)) (a c))
> (append '(b (a c)) '(a c))
'(b (a c) a c)
> (connected-components graph4)
'(((a (b d)) (b (a)) (d (a))) ((c (e)) (e (c))))
> (connected-components graph2)
'(((a (b f)) (b (a c e)) ((f (a)) ((c (b)) ((e (b i)) (i (e)))))) ((c (b))) ((d (g j)) (g (d)) ((j (d h)) (h (j)))) ((e (b i)) (i (e))) ((f (a))) ((h (j)) (j (d h))))
> (append (list '(b (a c))) (list '(a c)))
'((b (a c)) (a c))
> (list '(b (a c)) '(a c))
'((b (a c)) (a c))
> ,load "hw2.scm"
hw2.scm
> (connected-components graph1)
'(((a (b f)) (b (a c e)) ((f (a)) ((c (b)) ((e (b i)) (i (e)))))) ((c (b))) ((d (g j)) (g (d)) (j (d))) ((e (b i)) (i (e))) ((f (a))) ((h ())))
> ,load "hw2.scm"
hw2.scm
> (connected-components graph1)
'(((a (b f)) (b (a c e)) (f (a)) (c (b)) (e (b i)) i (e)) ((d (g j)) (g (d)) j (d)) ((h ())) ((i (e))) ((j (d))))
> ,load "hw2a.scm"
hw2a.scm
> (connected-components graph1)
'(((a (b f)) (b (a c e)) (f (a)) (c (b)) (e (b i)) (i (e))) ((d (g j)) (g (d)) (j (d))) ((h ())))
> (connected-components graph2)
'(((a (b f)) (b (a c e)) (f (a)) (c (b)) (e (b i)) (i (e))) ((d (g j)) (g (d)) (j (d h)) (h (j))))
> (connected-components graph3)
'(((a (b f)) (b (a c e)) (f (a)) (c (b j)) (e (b i)) (j (c d h)) (i (e)) (d (g j)) (h (j)) (g (d))))
> (connected-components graph4)
'(((a (b d)) (b (a)) (d (a))) ((c (e)) (e (c))))
> (define (connected xgraph) (if (> (length (connected-components xgraph)) 1) #t #f))
> (connected graph1)
#t
> (define (connected xgraph) (if (> (length (connected-components xgraph)) 1) #f #t))
> (connected graph1)
#f
> (connected graph2)
#f
> (connected graph3)
#t
> (connected graph4)
#f
> 
