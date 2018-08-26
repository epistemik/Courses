Welcome to Scheme 48 0.52.1 (suspended image).
Copyright (c) 1993, 1994 by Richard Kelsey and Jonathan Rees.
Copyright (c) 1996 by NEC Research Institute, Inc.
Copyright (c) 1998, 1999 by Northwestern University.
Please report all bugs to bug-scheme48@cs.nwu.edu
> ,load "hw2.scm"
hw2.scm

Undefined: (tol)
> (define tol 0.000001)
> tol
1.e-006
> sqroot
'#{Procedure 7487 sqroot}
> square-root
'#{Procedure 7488 square-root}
> component
'#{Procedure 7485 component}
> graph4
'((a (b d)) (b (a)) (c (e)) (d (a)) (e (c)))
> (connected-components graph4)
'(((a (b d)) (b) a ((d) a ())) ((b (a))) ((c (e)) (e) c ()) ((d (a))) ((e (c))))
> (define (contains itemlist grlist) 
        ( cond ( (null? itemlist) itemlist )
               ( (null? grlist) grlist )
               ( else ( let ( (h-item (car itemlist))
                              (t-list (cdr itemlist))
                              (target (find (car itemlist) grlist)) )
                            ( if (null? target) (contains t-list grlist)
                                 (append (cons h-item list(target))
                                         (list (contains (append t-list target)
                                               (remove h-item grlist)))) )
               ))))

Warning: wrong number of arguments
         (cons h-item list (target))
         (procedure wants: (:value :value))
         (arguments are: (:value (proc (&rest :value) :value) :values))
> (define (contains itemlist grlist) 
        ( cond ( (null? itemlist) itemlist )
               ( (null? grlist) grlist )
               ( else ( let ( (h-item (car itemlist))
                              (t-list (cdr itemlist))
                              (target (find (car itemlist) grlist)) )
                            ( if (null? target) (contains t-list grlist)
                                 (append (cons h-item (list target))
                                         (list (contains (append t-list target)
                                               (remove h-item grlist)))) )
               ))))
> (connected-components graph4)
'(((a (b d)) b (a) (d (a) ())) ((b (a))) ((c (e)) e (c) ()) ((d (a))) ((e (c))))
> (define (contains itemlist grlist) 
        ( cond ( (null? itemlist) itemlist )
               ( (null? grlist) grlist )
               ( else ( let ( (h-item (car itemlist))
                              (t-list (cdr itemlist))
                              (target (find (car itemlist) grlist)) )
                            ( if (null? target) (contains t-list grlist)
                                 (cons (cons h-item (list target))
                                         (list (contains (append t-list target)
                                               (remove h-item grlist)))) )
               ))))
> (connected-components graph4)
'(((a (b d)) (b (a)) ((d (a)) ())) ((c (e)) (e (c)) ()) ((d (a))))
> ,trace contains
> (connected-components graph4)
[Enter (contains '(b d) '((b (a)) (c (e)) (d (a)) (e (c))))
[Enter (contains '(d a) '((c (e)) (d (a)) (e (c))))
[Enter (contains '(a a) '((c (e)) (e (c))))
[Enter (contains '(a) '((c (e)) (e (c))))
[Enter (contains '() '((c (e)) (e (c))))
 Leave contains '()]
 Leave contains '()]
 Leave contains '()]
 Leave contains '((d (a)) ())]
 Leave contains '((b (a)) ((d (a)) ()))]
[Enter (contains '(b d) '((b (a)) (c (e)) (d (a)) (e (c))))
[Enter (contains '(d a) '((c (e)) (d (a)) (e (c))))
[Enter (contains '(a a) '((c (e)) (e (c))))
[Enter (contains '(a) '((c (e)) (e (c))))
[Enter (contains '() '((c (e)) (e (c))))
 Leave contains '()]
 Leave contains '()]
 Leave contains '()]
 Leave contains '((d (a)) ())]
 Leave contains '((b (a)) ((d (a)) ()))]
[Enter (contains '(e) '((d (a)) (e (c))))
[Enter (contains '(c) '((d (a))))
[Enter (contains '() '((d (a))))
 Leave contains '()]
 Leave contains '()]
 Leave contains '((e (c)) ())]
[Enter (contains '(e) '((d (a)) (e (c))))
[Enter (contains '(c) '((d (a))))
[Enter (contains '() '((d (a))))
 Leave contains '()]
 Leave contains '()]
 Leave contains '((e (c)) ())]
[Enter (contains '(a) '())
 Leave contains '()]
[Enter (contains '(a) '())
 Leave contains '()]
'(((a (b d)) (b (a)) ((d (a)) ())) ((c (e)) (e (c)) ()) ((d (a))))
> (cons '(d (a)) '())
'((d (a)))
> (contains '(d a) '((c (e)) (d (a)) (e (c))))
[Enter (contains '(d a) '((c (e)) (d (a)) (e (c))))
[Enter (contains '(a a) '((c (e)) (e (c))))
[Enter (contains '(a) '((c (e)) (e (c))))
[Enter (contains '() '((c (e)) (e (c))))
 Leave contains '()]
 Leave contains '()]
 Leave contains '()]
 Leave contains '((d (a)) ())]
'((d (a)) ())
> ,trace find
> (contains '(d a) '((c (e)) (d (a)) (e (c))))
[Enter (contains '(d a) '((c (e)) (d (a)) (e (c))))
[Enter (find 'd '((c (e)) (d (a)) (e (c))))
[Enter (find 'd '((d (a)) (e (c))))
 Leave find '(a)]
 Leave find '(a)]
[Enter (contains '(a a) '((c (e)) (e (c))))
[Enter (find 'a '((c (e)) (e (c))))
[Enter (find 'a '((e (c))))
[Enter (find 'a '())
 Leave find '()]
 Leave find '()]
 Leave find '()]
[Enter (contains '(a) '((c (e)) (e (c))))
[Enter (find 'a '((c (e)) (e (c))))
[Enter (find 'a '((e (c))))
[Enter (find 'a '())
 Leave find '()]
 Leave find '()]
 Leave find '()]
[Enter (contains '() '((c (e)) (e (c))))
 Leave contains '()]
 Leave contains '()]
 Leave contains '()]
 Leave contains '((d (a)) ())]
'((d (a)) ())
> (define (connected-components grapha) 
        (if (null? grapha) grapha 
            ( let ( (compa (component (car grapha) grapha)) )
                  ( (cons compa (connected-components (minus grapha compa))) )
          )))

Warning: non-procedure in operator position
         ((cons compa (connected-components (minus grapha compa))))
         (procedure: #{Type :pair #f #f})
>(define (connected-components grapha) 
        (if (null? grapha) grapha 
            ( let ( (compa (component (car grapha) grapha)) )
                  ( cons compa (connected-components (minus grapha compa)) )
          )))

Warning: invalid variable reference
         define

Error: undefined variable
       #{Location #f}
1> 
Error: undefined variable
       grapha
       (package user)
2> 
Error: undefined variable
       grapha
       (package user)
3> 
Warning: discarding extraneous right parenthesis

Error: undefined variable
       reset
       (package user)
4> 
Top level
> (define (connected-components grapha)(if (null? grapha) grapha ( let ( (compa (component (car grapha) grapha)) )( cons compa (connected-components (minus grapha compa)) ))))
> graph4
'((a (b d)) (b (a)) (c (e)) (d (a)) (e (c)))
> (contains '(d a) '((c (e)) (d (a)) (e (c))))
[Enter (contains '(d a) '((c (e)) (d (a)) (e (c))))
[Enter (find 'd '((c (e)) (d (a)) (e (c))))
[Enter (find 'd '((d (a)) (e (c))))
 Leave find '(a)]
 Leave find '(a)]
[Enter (contains '(a a) '((c (e)) (e (c))))
[Enter (find 'a '((c (e)) (e (c))))
[Enter (find 'a '((e (c))))
[Enter (find 'a '())
 Leave find '()]
 Leave find '()]
 Leave find '()]
[Enter (contains '(a) '((c (e)) (e (c))))
[Enter (find 'a '((c (e)) (e (c))))
[Enter (find 'a '((e (c))))
[Enter (find 'a '())
 Leave find '()]
 Leave find '()]
 Leave find '()]
[Enter (contains '() '((c (e)) (e (c))))
 Leave contains '()]
 Leave contains '()]
 Leave contains '()]
 Leave contains '((d (a)) ())]
'((d (a)) ())
> (cons '(d (a)) (list '()))
'((d (a)) ())
> (define (contains itemlist grlist) 
        ( cond ( (null? itemlist) itemlist )
               ( (null? grlist) grlist )
               ( else ( let ( (h-item (car itemlist))
                              (t-list (cdr itemlist))
                              (target (find (car itemlist) grlist)) )
                            ( if (null? target) (contains t-list grlist)
                                 ( let ( (node (cons h-item (list target)))
                                         (end (contains (append t-list target)
                                                        (remove h-item grlist))) )
                                       ( if (null? end) node
                                            (cons node (list end))) )) )
               )))
> (connected-components graph4)
[Enter (find 'b '((b (a)) (c (e)) (d (a)) (e (c))))
 Leave find '(a)]
[Enter (find 'd '((c (e)) (d (a)) (e (c))))
[Enter (find 'd '((d (a)) (e (c))))
 Leave find '(a)]
 Leave find '(a)]
[Enter (find 'a '((c (e)) (e (c))))
[Enter (find 'a '((e (c))))
[Enter (find 'a '())
 Leave find '()]
 Leave find '()]
 Leave find '()]
[Enter (find 'a '((c (e)) (e (c))))
[Enter (find 'a '((e (c))))
[Enter (find 'a '())
 Leave find '()]
 Leave find '()]
 Leave find '()]
[Enter (find 'e '((e (c))))
 Leave find '(c)]
'(((a (b d)) (b (a)) (d (a))) ((c (e)) e (c)) ((e (c))))
> ,trace contains
> (connected-components graph4)
[Enter (contains '(b d) '((b (a)) (c (e)) (d (a)) (e (c))))
[Enter (find 'b '((b (a)) (c (e)) (d (a)) (e (c))))
 Leave find '(a)]
[Enter (contains '(d a) '((c (e)) (d (a)) (e (c))))
[Enter (find 'd '((c (e)) (d (a)) (e (c))))
[Enter (find 'd '((d (a)) (e (c))))
 Leave find '(a)]
 Leave find '(a)]
[Enter (contains '(a a) '((c (e)) (e (c))))
[Enter (find 'a '((c (e)) (e (c))))
[Enter (find 'a '((e (c))))
[Enter (find 'a '())
 Leave find '()]
 Leave find '()]
 Leave find '()]
[Enter (contains '(a) '((c (e)) (e (c))))
[Enter (find 'a '((c (e)) (e (c))))
[Enter (find 'a '((e (c))))
[Enter (find 'a '())
 Leave find '()]
 Leave find '()]
 Leave find '()]
[Enter (contains '() '((c (e)) (e (c))))
 Leave contains '()]
 Leave contains '()]
 Leave contains '()]
 Leave contains '(d (a))]
 Leave contains '((b (a)) (d (a)))]
[Enter (contains '(e) '((e (c))))
[Enter (find 'e '((e (c))))
 Leave find '(c)]
[Enter (contains '(c) '())
 Leave contains '()]
 Leave contains '(e (c))]
[Enter (contains '(c) '())
 Leave contains '()]
'(((a (b d)) (b (a)) (d (a))) ((c (e)) e (c)) ((e (c))))
> (component (car graph4) graph4)
[Enter (contains '(b d) '((b (a)) (c (e)) (d (a)) (e (c))))
[Enter (find 'b '((b (a)) (c (e)) (d (a)) (e (c))))
 Leave find '(a)]
[Enter (contains '(d a) '((c (e)) (d (a)) (e (c))))
[Enter (find 'd '((c (e)) (d (a)) (e (c))))
[Enter (find 'd '((d (a)) (e (c))))
 Leave find '(a)]
 Leave find '(a)]
[Enter (contains '(a a) '((c (e)) (e (c))))
[Enter (find 'a '((c (e)) (e (c))))
[Enter (find 'a '((e (c))))
[Enter (find 'a '())
 Leave find '()]
 Leave find '()]
 Leave find '()]
[Enter (contains '(a) '((c (e)) (e (c))))
[Enter (find 'a '((c (e)) (e (c))))
[Enter (find 'a '((e (c))))
[Enter (find 'a '())
 Leave find '()]
 Leave find '()]
 Leave find '()]
[Enter (contains '() '((c (e)) (e (c))))
 Leave contains '()]
 Leave contains '()]
 Leave contains '()]
 Leave contains '(d (a))]
 Leave contains '((b (a)) (d (a)))]
'((a (b d)) (b (a)) (d (a)))
> ,untrace
?
> (define comp4 (component (car graph4) graph4))
> comp4
'((a (b d)) (b (a)) (d (a)))
> (define rest4 (minus graph4 comp4))
> rest4
'((c (e)) (e (c)))
> (connected-components rest4)
'(((c (e)) e (c)) ((e (c))))
> ,trace contains
> ,trace find
> (connected-components rest4)
[Enter (contains '(e) '((e (c))))
[Enter (find 'e '((e (c))))
 Leave find '(c)]
[Enter (contains '(c) '())
 Leave contains '()]
 Leave contains '(e (c))]
[Enter (contains '(c) '())
 Leave contains '()]
'(((c (e)) e (c)) ((e (c))))
> ,trace component
> (connected-components rest4)
[Enter (component '(c (e)) '((c (e)) (e (c))))
[Enter (contains '(e) '((e (c))))
[Enter (find 'e '((e (c))))
 Leave find '(c)]
[Enter (contains '(c) '())
 Leave contains '()]
 Leave contains '(e (c))]
 Leave component '((c (e)) e (c))]
[Enter (component '(e (c)) '((e (c))))
[Enter (contains '(c) '())
 Leave contains '()]
 Leave component '((e (c)))]
'(((c (e)) e (c)) ((e (c))))
> (append (list '(c (e))) '(e (c)) )
'((c (e)) e (c))
> (append (list '(c (e))) (list '(e (c))) )
'((c (e)) (e (c)))
> ,load "hw2.scm"
hw2.scm
> (connected-components graph4)
'(((a (b d)) (b (a)) (d (a))) ((c (e)) (e (c))))
> (connected-components graph1)

Error: exception
       (car '())
1> (define (component x glist)
        ( let ( (xcomp (contains (cadr x) (cdr glist))) )
              ( cond ( (null? xcomp) xcomp )
                     ( (symbol? (car xcomp)) (append (list x) (list xcomp)) )
                     ( else (append (list x) xcomp) )
            )))
1> (connected-components graph1)



;

