Welcome to Scheme 48 0.52.1 (suspended image).
Copyright (c) 1993, 1994 by Richard Kelsey and Jonathan Rees.
Copyright (c) 1996 by NEC Research Institute, Inc.
Copyright (c) 1998, 1999 by Northwestern University.
Please report all bugs to bug-scheme48@cs.nwu.edu
> (define (union set1 set2) ( cond 
                             ( (null? set1)              (set2)                     )
                             ( (null? set2)              (set1)                     )
                             ( (member (car(set1)) set2) (union (cdr(set1)) set2)   )
                             ( else   ( cons (car(set1)) (union (cdr(set1)) set2))  )
                          ))
> (define L (append '(1 2 3 4) '(5 6 7 8 9)))

(define M '((p(n) (q 26) (r b) (s -10))))

(define N '(e 3 r 5 6 (5)))
> > > > > 
> L
'(1 2 3 4 5 6 7 8 9)
> M
'((p (n) (q 26) (r b) (s -10)))
> N
'(e 3 r 5 6 (5))
> (union L N)

Error: attempt to call a non-procedure
       ('(1 2 3 4 5 6 ---))
1> (union L '(9 10 11))

Error: attempt to call a non-procedure
       ('(1 2 3 4 5 6 ---))
2> (member 3 L)
'(3 4 5 6 7 8 9)
2> (union L '())

Error: attempt to call a non-procedure
       ('(1 2 3 4 5 6 ---))
3> (union '() L)

Error: attempt to call a non-procedure
       ('(1 2 3 4 5 6 ---))
4> (null? L)
#f
4> (define (union set1 set2) ( cond 
                             ( (null? set1)              set2                     )
                             ( (null? set2)              set1                     )
                             ( (member (car(set1)) set2) (union (cdr(set1)) set2)   )
                             ( else   ( cons (car(set1)) (union (cdr(set1)) set2))  )
                          ))
4> (union '() L)
'(1 2 3 4 5 6 7 8 9)
4> (union L '())
'(1 2 3 4 5 6 7 8 9)
4> (union L '(9 10 11))

Error: attempt to call a non-procedure
       ('(1 2 3 4 5 6 ---))
5> (define (union set1 set2) ( cond 
                             ( (null? set1)              set2                     )
                             ( (null? set2)              set1                     )
                             ( (member (car set1) set2) (union (cdr set1) set2)   )
                             ( else   ( cons (car set1) (union (cdr set1) set2))  )
                          ))
5> (union L '(9 10 11))
'(1 2 3 4 5 6 7 8 9 10 11)
5> (union L N)
'(1 2 4 7 8 9 e 3 r 5 6 (5))
5> L
'(1 2 3 4 5 6 7 8 9)
5> N
'(e 3 r 5 6 (5))
5> (intersection L N)

Error: undefined variable
       intersection
       (package user)
6> (define (intersection set1 set2) ( if (null? set1) () 
                                      ( if (member (car set1) set2)
                                           (cons (car set1)(intersection (cdr set1) set2))
                                               (intersection (cdr set1) set2)
                                 )    ) )

Warning: invalid expression
         ()
6> (define (intersection set1 set2) ( if (null? set1) set1 
                                      ( if (member (car set1) set2)
                                           (cons (car set1)(intersection (cdr set1) set2))
                                               (intersection (cdr set1) set2)
                                 )    ) )
6> (intersection L N)
'(3 5 6)
6> (cons 'a 'b)

6> 6> 

6> 6> 
Top level
> (cons 'a 'b)

> > (cons 'a '(b))

> > Exit Scheme 48 (y/n)? n
Exit Scheme 48 (y/n)? 
Top level
> 
Error: undefined variable
       end
       (package exec)
1> 1> 
Top level
> (cons 'alpha '(beta))

> > 
> > (union N L)

> > 
Interrupt: keyboard
1> 
