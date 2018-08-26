{site1}u428500(1)$ scm
SCM version 5d3, Copyright (C) 1990-1999 Free Software Foundation.
SCM comes with ABSOLUTELY NO WARRANTY; for details type `(terms)'.
This is free software, and you are welcome to redistribute it
under certain conditions; type `(terms)' for details.
;loading /usr/local/lib/slib/require
;done loading /usr/local/lib/slib/require.scm
;loading /usr/local/lib/scm/Transcen
;done loading /usr/local/lib/scm/Transcen.scm
;Evaluation took 66 mSec (0 in gc) 15992 cells work, 4000 env, 17598 bytes other
> '(a b)
;Evaluation took 0 mSec (0 in gc) 14 cells work, 0 env, 33 bytes other
(a b)
> (nolog)
 
unbound variable:  nolog
; in expression: (... nolog)
; in top level environment.
;Evaluation took 0 mSec (0 in gc) 6 cells work, 0 env, 217 bytes other
> (member 'a '(a b c))
;Evaluation took 0 mSec (0 in gc) 22 cells work, 0 env, 31 bytes other
(a b c)
> r
 
unbound variable:  r
; in expression: r
; in top level environment.
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 211 bytes other
> (member 'd '(a b c d e))
;Evaluation took 0 mSec (0 in gc) 29 cells work, 0 env, 33 bytes other
(d e)
> (member 'f '(a b c))
;Evaluation took 0 mSec (0 in gc) 22 cells work, 0 env, 31 bytes other
#f
> (member 'me '(you him her))
;Evaluation took 0 mSec (0 in gc) 34 cells work, 0 env, 46 bytes other
#f
> (member 'i '(me myself i))
;Evaluation took 0 mSec (0 in gc) 25 cells work, 0 env, 38 bytes other
(i)
> (cons 'a '(1 2 3 4))
;Evaluation took 0 mSec (0 in gc) 29 cells work, 0 env, 39 bytes other
(a 1 2 3 4)
> (cons 27.9 '(2 3 4))
;Evaluation took 0 mSec (0 in gc) 22 cells work, 0 env, 47 bytes other
(27.9 2 3 4)
> (append '1 '2)
 
ERROR: append: Wrong type in arg  1
;Evaluation took 0 mSec (0 in gc) 21 cells work, 0 env, 215 bytes other
> (append 1  2)
 
ERROR: append: Wrong type in arg  1
;Evaluation took 0 mSec (0 in gc) 9 cells work, 0 env, 215 bytes other
> (append '(1) '(2 3 4))
;Evaluation took 0 mSec (0 in gc) 31 cells work, 0 env, 39 bytes other
(1 2 3 4)
> (list '(1) '(2 3 4))
;Evaluation took 0 mSec (0 in gc) 30 cells work, 0 env, 39 bytes other
((1) (2 3 4))
> (define L (append '(1 2 3 4) '(5 6 7 8 9)))
;Evaluation took 0 mSec (0 in gc) 56 cells work, 0 env, 49 bytes other
#<unspecified>
> L
;Evaluation took 0 mSec (0 in gc) 2 cells work, 0 env, 31 bytes other
(1 2 3 4 5 6 7 8 9)
> (car L)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
1
> (cdr L)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
(2 3 4 5 6 7 8 9)
> (cadr L)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
2
> (caddr L)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
3
> (cdddr L)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
(4 5 6 7 8 9)
> (null? L)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
#f
> (equal L L)
 
unbound variable:  equal
; in expression: (... equal l l)
; in top level environment.
;Evaluation took 0 mSec (0 in gc) 8 cells work, 0 env, 217 bytes other
> (equal? L L)
;Evaluation took 0 mSec (0 in gc) 4 cells work, 0 env, 31 bytes other
#t
> (number? L)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
#f
> (equal? L 'a)
;Evaluation took 0 mSec (0 in gc) 10 cells work, 0 env, 31 bytes other
#f
> (eq? L L)
;Evaluation took 0 mSec (0 in gc) 4 cells work, 0 env, 31 bytes other
#t
> (eq? L 'a)
;Evaluation took 0 mSec (0 in gc) 10 cells work, 0 env, 31 bytes other
#f
> (eq? 'a 'b)
;Evaluation took 0 mSec (0 in gc) 16 cells work, 0 env, 31 bytes other
#f
> (eq? '(a) '(a))
;Evaluation took 0 mSec (0 in gc) 20 cells work, 0 env, 31 bytes other
#f
> (define (plus X Y) (+ X Y))
;Evaluation took 0 mSec (0 in gc) 27 cells work, 0 env, 36 bytes other
#<unspecified>
> plus 4 7
;Evaluation took 0 mSec (0 in gc) 2 cells work, 0 env, 31 bytes other
#<CLOSURE (x y) #@lambda (+ x y)>
> ;Evaluation took 0 mSec (0 in gc) 2 cells work, 0 env, 33 bytes other
4
> ;Evaluation took 0 mSec (0 in gc) 2 cells work, 0 env, 33 bytes other
7
> (plus 4 7)
;Evaluation took 0 mSec (0 in gc) 7 cells work, 4 env, 35 bytes other
11
> (append L 'a)
;Evaluation took 0 mSec (0 in gc) 21 cells work, 0 env, 31 bytes other
(1 2 3 4 5 6 7 8 9 . a)
> (append L '(a))
;Evaluation took 0 mSec (0 in gc) 23 cells work, 0 env, 31 bytes other
(1 2 3 4 5 6 7 8 9 a)
> (define (add-to-queue A B) (append A cons(B '())))
;Evaluation took 0 mSec (0 in gc) 32 cells work, 0 env, 44 bytes other
#<unspecified>
> (add-to-queue L 'a)
 
Wrong type to apply:  a
; in expression: (... b (quote ()))
; in scope:
;   (a b)
;Evaluation took 0 mSec (0 in gc) 13 cells work, 4 env, 211 bytes other
> (cons 'a ())
;Evaluation took 0 mSec (0 in gc) 11 cells work, 0 env, 31 bytes other
(a)
> (define (add-to-queue A B) (append A cons(B ())))
;Evaluation took 0 mSec (0 in gc) 27 cells work, 0 env, 31 bytes other
#<unspecified>
> (add-to-queue L 'a)
 
Wrong type to apply:  a
; in expression: (... b ())
; in scope:
;   (a b)
;Evaluation took 0 mSec (0 in gc) 13 cells work, 4 env, 211 bytes other
> (append L cons('a ()))
 
Wrong type to apply:  a
; in top level environment.
;Evaluation took 0 mSec (0 in gc) 14 cells work, 0 env, 211 bytes other
> (cons 'a ())
;Evaluation took 0 mSec (0 in gc) 11 cells work, 0 env, 31 bytes other
(a)
> (append L (cons('a ())))
 
Wrong number of args given #<primitive-procedure cons>
; in expression: (... cons ((quote a) ()))
; in top level environment.
;Evaluation took 0 mSec (0 in gc) 11 cells work, 0 env, 211 bytes other
> (list 'a)
;Evaluation took 0 mSec (0 in gc) 10 cells work, 0 env, 31 bytes other
(a)
> (define (add-to-queue A B) (append A (list B)))
;Evaluation took 16 mSec (0 in gc) 26 cells work, 0 env, 31 bytes other
#<unspecified>
> (add-to-queue L 'a)
;Evaluation took 0 mSec (0 in gc) 23 cells work, 4 env, 31 bytes other
(1 2 3 4 5 6 7 8 9 a)
> (define (union set1 set2) ( cond ( (null? set1) (set2)
                                     (null? set2) (set1)
                                     (member (car(set1)) set2) (union (cdr(set1)) set2)
                                     (else (cons(car(set1) (union (cdr(set1)) set2)
                                   )))))))
;Evaluation took 0 mSec (0 in gc) 75 cells work, 0 env, 49 bytes other
#<unspecified>
> (union L '(2 3 11))
 
unbound variable:
 in expression: (...
 in scope:
;   (set1 set2)
;Evaluation took 0 mSec (0 in gc) 27 cells work, 4 env, 217 bytes other
> (define (intersection set1 set2) ( if (null? set1) () (if (member (car set1) set2) (cons (car set1)
                                     (intersection (cdr set1) set2)) (intersection ( cdr set1 set2))))
)
;Evaluation took 0 mSec (0 in gc) 54 cells work, 0 env, 44 bytes other
#<unspecified>
> (define M '((p(n) (q 26) (r b) (s -10))))
;Evaluation took 0 mSec (0 in gc) 45 cells work, 0 env, 37 bytes other
#<unspecified>
> M
;Evaluation took 0 mSec (0 in gc) 2 cells work, 0 env, 31 bytes other
((p (n) (q 26) (r b) (s -10)))
> (define M '((p(n)) (q 26) (r b) (s -10)))
;Evaluation took 0 mSec (0 in gc) 42 cells work, 0 env, 35 bytes other
#<unspecified>
> M
;Evaluation took 0 mSec (0 in gc) 2 cells work, 0 env, 31 bytes other
((p (n)) (q 26) (r b) (s -10))
> (car M)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
(p (n))
> (cdr M)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
((q 26) (r b) (s -10))
> (cadr M)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
(q 26)
> (cddr M)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
((r b) (s -10))
> (define (find-value name a-list) (cond ( name=car a-list) (#t)
                                         (else (find-value name cdr a-list))))
;Evaluation took 0 mSec (0 in gc) 43 cells work, 0 env, 58 bytes other
#<unspecified>
> (find-value r M)
 
unbound variable:  r
; in expression: (... r m)
; in top level environment.
;Evaluation took 0 mSec (0 in gc) 5 cells work, 0 env, 211 bytes other
> (find-value 'r M)
 
unbound variable:  name=car
; in expression: (... name=car a-list)
; in scope:
;   (name a-list)
;Evaluation took 0 mSec (0 in gc) 21 cells work, 4 env, 211 bytes other
> (caar M)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
p
> (define (find-value name a-list) (cond ( name=(caar a-list)) (#t)
                                         (else (find-value name (cdr a-list)))))

;Evaluation took 0 mSec (0 in gc) 40 cells work, 0 env, 37 bytes other
#<unspecified>
> (find-value 'r M)
 
unbound variable:  name=
; in expression: (... name= (caar a-list))
; in scope:
;   (name a-list)
;Evaluation took 0 mSec (0 in gc) 21 cells work, 4 env, 211 bytes other
> (define (find-value name a-list) (cond ( (equal? name (caar a-list))) (#t)
                                         (else (find-value name (cdr a-list)))))

;Evaluation took 0 mSec (0 in gc) 39 cells work, 0 env, 31 bytes other
#<unspecified>
> (find-value 'r M)
;Evaluation took 0 mSec (0 in gc) 19 cells work, 4 env, 31 bytes other
#t
> (cadar M)
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 31 bytes other
(n)
> (define (find-value name a-list) (cond ( (equal? name (caar a-list))) (cadar a-list)
                                         (else (find-value name (cdr a-list) )                                                                    )))
;Evaluation took 0 mSec (0 in gc) 40 cells work, 0 env, 31 bytes other
#<unspecified>
> (find-value M 'r)
 
ERROR: caar: Wrong type in arg1 r
;Evaluation took 0 mSec (0 in gc) 20 cells work, 4 env, 211 bytes other
> (find-value 'r M)
;Evaluation took 0 mSec (0 in gc) 10 cells work, 4 env, 31 bytes other
((p (n)) (q 26) (r b) (s -10))
> (define (delete-pair name alist) (cond ( (null? alist)              ()
                                         (equal? name (caar alist)) (cdr alist)
                                         (else (append (car alist)  (delete-pair name (cdr alist))))
                                        )))
;Evaluation took 0 mSec (0 in gc) 55 cells work, 0 env, 49 bytes other
#<unspecified>
> (delete-pair 'r M)
;Evaluation took 0 mSec (0 in gc) 16 cells work, 4 env, 31 bytes other
#<unspecified>
> (define (delete-pair name alist) (cond ( (null? alist)              ()
                                         (equal? name (caar alist)) (cdr alist)
                                         (else (cons (car alist)  (delete-pair name (cdr alist))))
                                        )))
;Evaluation took 0 mSec (0 in gc) 49 cells work, 0 env, 31 bytes other
#<unspecified>
> (delete-pair 'r M)
;Evaluation took 0 mSec (0 in gc) 16 cells work, 4 env, 31 bytes other
#<unspecified>
> M
;Evaluation took 0 mSec (0 in gc) 2 cells work, 0 env, 31 bytes other
((p (n)) (q 26) (r b) (s -10))
> (define N '(e 3 r 5 6 (5)))
;Evaluation took 0 mSec (0 in gc) 32 cells work, 0 env, 39 bytes other
#<unspecified>
> N
;Evaluation took 0 mSec (0 in gc) 2 cells work, 0 env, 31 bytes other
(e 3 r 5 6 (5))
> (list 'A B C D)
 
unbound variable:  b
; in expression: (... b c d)
; in top level environment.
;Evaluation took 0 mSec (0 in gc) 13 cells work, 0 env, 211 bytes other
> (list 'a 'b 'c 'd)
;Evaluation took 0 mSec (0 in gc) 34 cells work, 0 env, 31 bytes other
(a b c d)
> (list 'a M)
;Evaluation took 0 mSec (0 in gc) 12 cells work, 0 env, 31 bytes other
(a ((p (n)) (q 26) (r b) (s -10)))
> (map (lambda (x) (if (number? x) (list 'num x) (list 'nonum x)))) N)
 
Wrong number of args given #<primitive-procedure map>
; in expression: (... map (lambda (x) (if (number? x) (list (quote num)  ...
; in top level environment.
;Evaluation took 0 mSec (0 in gc) 30 cells work, 0 env, 221 bytes other
> ;Evaluation took 0 mSec (0 in gc) 2 cells work, 0 env, 31 bytes other
(e 3 r 5 6 (5))
>
WARNING: unexpected ")"
 
unbound variable:
 in expression:
 in top level environment.
;Evaluation took 0 mSec (0 in gc) 3 cells work, 0 env, 211 bytes other
> (map (lambda (x) (if (number? x) (list 'num x) (list 'nonum x))) N)
;Evaluation took 0 mSec (0 in gc) 64 cells work, 18 env, 31 bytes other
((nonum e) (num 3) (nonum r) (num 5) (num 6) (nonum (5)))
> (list 'nonum x)
 
unbound variable:  x
; in expression: (... x)
; in top level environment.
;Evaluation took 0 mSec (0 in gc) 11 cells work, 0 env, 211 bytes other

