Welcome to Scheme 48 0.52.1 (suspended image).
Copyright (c) 1993, 1994 by Richard Kelsey and Jonathan Rees.
Copyright (c) 1996 by NEC Research Institute, Inc.
Copyright (c) 1998, 1999 by Northwestern University.
Please report all bugs to bug-scheme48@cs.nwu.edu
> 3.14
3.14
> alpha

Error: undefined variable
       alpha
       (package user)
1> ( define alpha ("alpha"))

Warning: non-procedure in operator position
         ("alpha")
         (procedure: #{Type :other #f :string})

Error: attempt to call a non-procedure
       ("alpha")
2> (define alpha "alpha")
2> alpha
"alpha"
2> 3/6
1/2
2> (define y 6)
2> y
6
2> (+ y 4)
10
2> (define z (+ y 4))
2> z
10
2> (* y z)
60
2> bluejay

Error: undefined variable
       bluejay
       (package user)
3> 'bluejay
'bluejay
3> '(* y z)
'(* y z)
3> ((* y z))

Warning: non-procedure in operator position
         ((* y z))
         (procedure: #{Type :number #f #f})

Error: attempt to call a non-procedure
       (60)
4> (quote (* y z))
'(* y z)
4> (list 4 5 6 7)
'(4 5 6 7)
4> list
'#{Procedure 405 (list in scheme-level-1)}
4> (define birdlist '(crow raven pigeon starling sparrow hawk))
4> birdlist
'(crow raven pigeon starling sparrow hawk)
4> (list 5 y birdlist '(a b c))
'(5 6 (crow raven pigeon starling sparrow hawk) (a b c))
4> (first birdlist)

Error: undefined variable
       first
       (package user)
5> (car birdlist)
'crow
5> (cdr birdlist)
'(raven pigeon starling sparrow hawk)
5> (cdar birdlist)

Error: exception
       (cdr 'crow)
6> (cadr birdlist)
'raven
6> (cddr birlist)

Error: undefined variable
       birlist
       (package user)
7> (cddr birdlist)
'(pigeon starling sparrow hawk)
7> 

Error: undefined variable
       birlist
       (package user)
8> (caddr birdlist)

Warning: discarding extraneous right parenthesis

;

Interrupt: keyboard
9> 
Top level
> 
Interrupt: keyboard
1> y

Interrupt: keyboard
2> 6
2> 
Top level
> (cdr birdlist)
'(raven pigeon starling sparrow hawk)
> (define birdlist '(crow raven pigeon starling sparrow hawk))
> birdlist
'(crow raven pigeon starling sparrow hawk)
> (caddr birdlist)
'pigeon
> (cons 'swan birdlist)
'(swan crow raven pigeon starling sparrow hawk)
> (define bigbirdlist cons 'swan birdlist)

Warning: ill-formed definition
         (#{Name define} bigbirdlist cons 'swan birdlist)
'syntax-error
> (define bigbirdlist (cons 'swan birdlist))
> bigbirdlist
'(swan crow raven pigeon starling sparrow hawk)
> birdlist
'(crow raven pigeon starling sparrow hawk)
> ()

Warning: invalid expression
         ()
'syntax-error
> (null? ())

Warning: invalid expression
         ()
#f
> '()
'()
> (null? '())
#t
> (cons lonely '())

Error: undefined variable
       lonely
       (package user)
1> (cons 'lonely ())

Warning: invalid expression
         ()
'(lonely . syntax-error)
1> (cons 'lonely '())
'(lonely)
1> (cons 'a (cons 'b '()) )
'(a b)
1> 'lonely
'lonely
1> (list 'lonely)
'(lonely)
1> (cons 'lonely '())
'(lonely)
1> (cons birdlist birdlist)
'((crow raven pigeon starling sparrow hawk) crow raven pigeon starling sparrow hawk)
1> (append birdlist birdlist)
'(crow raven pigeon starling sparrow hawk crow raven pigeon starling sparrow hawk)
1> (append birdlist bigbirdlist)
'(crow raven pigeon starling sparrow hawk swan crow raven pigeon starling sparrow hawk)
1> (define (add1 x) (+ x 1))
1> (add1 4)
5
1> (add1 y)
7
1> (define (add3 x) (add1 (add1 (add1 x))))
1> (add3 y)
9
1> (define (threecopies x) (list x x x))
1> (threecopies birdlist)
'((crow raven pigeon starling sparrow hawk) (crow raven pigeon starling sparrow hawk) (crow raven pigeon starling sparrow hawk))
1> (define (threeof x) (append x append(x x)))
1> (threeof biggerbirdlist)

Error: undefined variable
       biggerbirdlist
       (package user)
2> (threeof bigbirdlist)

Error: attempt to call a non-procedure
       ('(swan crow raven pigeon starling sparrow ---) '(swan crow raven pigeon starling sparrow ---))
3> (define (threeof x) (append x (append(x x))))
3> (threeof bigbirdlist)

Error: attempt to call a non-procedure
       ('(swan crow raven pigeon starling sparrow ---) '(swan crow raven pigeon starling sparrow ---))
4> (define (threeof x) (append x (append x x)))
4> (threeof bigbirdlist)
'(swan crow raven pigeon starling sparrow hawk swan crow raven pigeon starling sparrow hawk swan crow raven pigeon starling sparrow hawk)
4> ((lambda (x) (list x x x)) '(a b c d e f g))
'((a b c d e f g) (a b c d e f g) (a b c d e f g))
4> ((lambda (x) (append x x x)) '(a b c d e f g))
'(a b c d e f g a b c d e f g a b c d e f g)
4> (define (fourof q) (append q q q q))
4> (fourof birdlist)
'(crow raven pigeon starling sparrow hawk crow raven pigeon starling sparrow hawk crow raven pigeon starling sparrow hawk crow raven pigeon starling sparrow hawk)
4> x

Error: undefined variable
       x
       (package user)
5> z
10
5> y
6
5> (> y z)
#f
5> (if (> y x) 'raven 'bluebird)

Error: undefined variable
       x
       (package user)
6> (if (> y z) 'raven 'bluebird)
'bluebird
6> (define x (* y z))
6> (if (> y x) 'raven 'bluebird)
'bluebird
6> x
60
6> (if (< x y) 'x-less-than-y
            (if (= x y) 'x-equals-y
                        (if (= x (+ y 1)) 'x-one-more-than-y
                                          'x-at-least-two-more-than-y)))
'x-at-least-two-more-than-y
6> y
6
6> (cond ((< x y) 'x-less-than-y)
      ((= x y) 'x-equals-y)
      ((= x (+ y 1)) 'x-one-more-than-y)
      (#t 'x-at-least-two-more-than-y))
'x-at-least-two-more-than-y
6> (cond ((< x y) 'x-less-than-y)
      ((= x y) 'x-equals-y)
      ((= x (+ y 1)) 'x-one-more-than-y)
      (else 'x-at-least-two-more-than-y))
'x-at-least-two-more-than-y
6> (factorial 4)

Error: undefined variable
       factorial
       (package user)
7> (define (factorial n)
        (if (<= n 0) 1
            (* n (factorial (- n 1)))))
7> (factorial 5)
120
7> (factorial 13)
6227020800
7> (define (power x n)
        (if (<= n 0) 1
            (if (= n 1) x
                (* x (power x (- n 1))))))
7> (power 2 9)
512
7> (power 3 7)
2187
7> (power 4 5)
1024
7> (map add3 '(3 5 7 2 9 -5))
'(6 8 10 5 12 -2)
7> (let ((x 3) (y 6) (z 'bluebird)) (list x y z z y))
'(3 6 bluebird bluebird 6)
7> (* 3 3 3 3)
81
7> (let ((x 3) (y 6) (z 'bluebird)) (list x y z z y x ))
'(3 6 bluebird bluebird 6 3)
7> (cadddr bigbirdlist)
'pigeon
7> (let ((x 3) (y 6) (z 'bluebird)) (list x y z z y))
'(3 6 bluebird bluebird 6)
7> (factorial 13)
6227020800
7> (factorial 23)
25852016738884976640000
7> (factorial 33)
8683317618811886495518194401280000000
7> (factorial 33)
8683317618811886495518194401280000000
7> (factorial 32
)263130836933693530167218012160000000
7> (* 33 263130836933693530167218012160000000)
'#{Procedure 271 (* in scheme-level-0)}
7> 33
7> 263130836933693530167218012160000000
7> 
Warning: discarding extraneous right parenthesis


Error: undefined variable
       debug
       (package user)
8> (* 33 263130836933693530167218012160000000)
8683317618811886495518194401280000000
8> ,pop

Error: unassigned variable
       factorial
       (package user)
7> ,reset

Top level
> 
