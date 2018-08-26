Welcome to Scheme 48 0.52.1 (suspended image).
Copyright (c) 1993, 1994 by Richard Kelsey and Jonathan Rees.
Copyright (c) 1996 by NEC Research Institute, Inc.
Copyright (c) 1998, 1999 by Northwestern University.
Please report all bugs to bug-scheme48@cs.nwu.edu
> (member 22 '(18 22 #f 300))
'(22 #f 300)
> (define sort #f)
(define merge #f)
(let ()
  (define dosort
    (lambda (pred? ls n)
      (cond
        ((= n 1) (list (car ls)))
        ((= n 2) (let ((x (car ls)) (y (cadr ls)))
                   (if (pred? y x) (list y x) (list x y))))
        (else
         (let ((i (quotient n 2)))
           (domerge pred?
                    (dosort pred? ls i)
                    (dosort pred? (list-tail ls i) (- n i))))))))
  (define domerge
    (lambda (pred? l1 l2)
      (cond
        ((null? l1) l2)
        ((null? l2) l1)
        ((pred? (car l2) (car l1))
         (cons (car l2) (domerge pred? l1 (cdr l2))))
        (else (cons (car l1) (domerge pred? (cdr l1) l2))))))
  (set! sort
    (lambda (pred? l)
      (if (null? l) l (dosort pred? l (length l)))))
  (set! merge
    (lambda (pred? l1 l2)
      (domerge pred? l1 l2))))
> > > (sort < '(3 4 2 1 8 5))
'(1 2 3 4 5 8)
> (pred? sort)

Error: undefined variable
       pred?
       (package user)
1> (sort < '(3 4 2 11 8 5))
'(2 3 4 5 8 11)
1> (merge <
       '(1/2 2/3 3/4)
       '(0.5 0.6 0.7))
'(1/2 0.5 0.6 2/3 0.7 3/4)
1> (list->string
  (sort char>?
        (string->list "coins")))
"sonic"
1> ("g" char> "k")

Warning: non-procedure in operator position
         ("g" char> "k")
         (procedure: #{Type :other #f :string})

Error: undefined variable
       char>
       (package user)
2> (char> "g" "k")

Error: undefined variable
       char>
       (package user)
3> (char>? "g" "k")

Warning: argument type error
         (char>? "g" "k")
         (procedure wants: (:char :char))
         (arguments are: (:string :string))

Error: exception
       wrong-type-argument
       (char<? "k" "g")
4> (char>? 'g 'k)

Warning: argument type error
         (char>? 'g 'k)
         (procedure wants: (:char :char))
         (arguments are: (:symbol :symbol))

Error: exception
       wrong-type-argument
       (char<? 'k 'g)
5> (char>? 'g' 'k')

Error: unexpected right parenthesis
       #{Input-port #{Input-channel "standard input"}}
5> (char>? @g @k)

Error: undefined variable
       @g
       (package user)
6> (char>? #\g #\k)
#f
6> (char>? #\x #\k)
#t
6> (list '1 '2 '3)
'(1 2 3)
6> (list '1 '(2 3))
'(1 (2 3))
6> (append '(1 2) '(3 4))
'(1 2 3 4)
6> (list '(1 2) '(3 4))
'((1 2) (3 4))
6> 
