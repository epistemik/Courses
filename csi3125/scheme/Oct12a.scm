Welcome to Scheme 48 0.52.1 (suspended image).
Copyright (c) 1993, 1994 by Richard Kelsey and Jonathan Rees.
Copyright (c) 1996 by NEC Research Institute, Inc.
Copyright (c) 1998, 1999 by Northwestern University.
Please report all bugs to bug-scheme48@cs.nwu.edu
> (load "scheme2.scm")
scheme2.scm

Warning: non-procedure in operator position
         (#t)
         (procedure: #{Type :boolean #f #f})

Warning: invalid expression
         ()
> (load "scheme2.scm")
scheme2.scm
> N
'(e 3 r 5 6 (5))
> L
'(1 2 3 4 5 6 7 8 9)
> M
'((p (n) (q 26) (r b) (s -10)))
> (union L M)
'(1 2 3 4 5 6 7 8 9 (p (n) (q 26) (r b) (s -10)))
> (define M '( (p(n)) (q 26) (r b) (s -10) ) )
> (union L M)
'(1 2 3 4 5 6 7 8 9 (p (n)) (q 26) (r b) (s -10))
> (intersection L M)
'()
> (union N L)
'(e r (5) 1 2 3 4 5 6 7 8 9)
> (union M N)
'((p (n)) (q 26) (r b) (s -10) e 3 r 5 6 (5))
> (intersection L N)
'(3 5 6)
> (cddddr L)
'(5 6 7 8 9)
> (caddddr L)

Error: undefined variable
       caddddr
       (package user)
1> (cadddr L)
4
1> (load "scheme2a.scm")
scheme2a.scm

Warning: invalid expression
         ()
1> (delete-pair 'r M)
'((p (n)) (q 26) (s -10))
1> (union M L)
'((p (n)) (q 26) (r b) (s -10) 1 2 3 4 5 6 7 8 9)
1> (unx M L)
'((p (n)) (q 26) (r b) (s -10) 1 2 3 4 5 6 7 8 9)
1> (union M '())
'((p (n)) (q 26) (r b) (s -10))
1> (unx M '())
'((p (n)) (q 26) (r b) (s -10))
1> (find-value 'r M)
#t
1> (union N Q)

Error: undefined variable
       q
       (package user)
2> (define Q '())
2> (union N Q)
'(e 3 r 5 6 (5))
2> (define (minus set1 set2) ( cond 
                                ( (null? set1)              set1                           )
                                ( (null? set2)              set1                           )
                                ( (member (car set2) set1) (minus (cdr set1) (cdr set2))   )
                                ( else   ( minus set1 (cdr set2) )                         )
                          ))
2> L
'(1 2 3 4 5 6 7 8 9)
2> M
'((p (n)) (q 26) (r b) (s -10))
2> N
'(e 3 r 5 6 (5))
2> (minus L N)
'(4 5 6 7 8 9)
2> (define (minus set1 set2) ( cond 
                             ( (null? set1)              set1                            )
                             ( (null? set2)              set1                            )
                             ( (member (car set1) set2) (minus (cdr set1) set2)          )
                             ( else   (append (car set1) (minus (cdr set1) set2))        )
                          ))
'#{Procedure 7554 minus}
2> 
Error: undefined variable
       set1
       (package user)
3> 
Error: undefined variable
       set2
       (package user)
4> 
Warning: discarding extraneous right parenthesis

Error: undefined variable
       set1
       (package user)
5> 
Warning: discarding extraneous right parenthesis



Error: undefined variable
       reset
       (package user)
6> 
Top level
> (define (minus set1 set2) ( cond 
                             ( (null? set1)              set1                            )
                             ( (null? set2)              set1                            )
                             ( (member (car set1) set2) (minus (cdr set1) set2)          )
                             ( else   (append (car set1) (minus (cdr set1) set2))        )
                          ))
> L
'(1 2 3 4 5 6 7 8 9)
> N
'(e 3 r 5 6 (5))
> (minus L N)

Error: exception
       (car 9)
1> (define l1 '(1 2))
1> (define l2 '(2))
1> (minus l1 l2)

Error: exception
       (car 1)
2> (car l1)
1
2> (member (car l1) l2)
#f
2> (cdr l1)
'(2)
2> (minus (cdr l1) l2)
'()
2> (append (car l1) (minus (cdr l1) l2))

Error: exception
       (car 1)
3> (define (minus set1 set2) ( cond 
                             ( (null? set1)              set1                            )
                             ( (null? set2)              set1                            )
                             ( (member (car set1) set2) (minus (cdr set1) set2)          )
                             ( else   (cons (car set1) (minus (cdr set1) set2))        )
                          ))
3> (minus L N)
'(1 2 4 7 8 9)
3> L
'(1 2 3 4 5 6 7 8 9)
3> N
'(e 3 r 5 6 (5))
3> 
