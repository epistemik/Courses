;Mark Sattolo  428500
;csi3125 A#2


;Problem 1
;---------

(define graph1
    '(
      (a (b f))  (b (a c e))  (c (b))  (d (g j))  (e (b i))
      (f (a))    (g (d))      (h ())   (i (e))    (j (d))
     ))

(define graph2
    '(
      (a (b f))  (b (a c e))  (c (b))  (d (g j))  (e (b i))
      (f (a))    (g (d))      (h (j))  (i (e))    (j (d h))
     ))

(define graph3
    '(
      (a (b f))  (b (a c e))  (c (b j))  (d (g j))  (e (b i))
      (f (a))    (g (d))      (h (j))    (i (e))    (j (c d h))
     ))


(define (minus set1 set2)
        ( cond ( (null? set1)              set1                    )
               ( (null? set2)              set1                    )
               ( (member (car set1) set2) (minus (cdr set1) set2)  )
               ( else   (cons (car set1) (minus (cdr set1) set2))  )
       ))

(define (find t L) (if (null? L) L 
                   (if (equal? t (caar L)) (cadar L)
                   (find t (cdr L))
        )))

(define (contains y z) 
        ( cond ( (null? y) y )
               ( (null? z) z )
               ( (equal? (car y) (caar z)) 
                         (cons (car z) (contains (append (cdr y) (cadar z)) (cdr z))) )
               ( else (cons (contains (cdr y) (car z)) (contains y (cdr z))) )
        ))

(define (component x w) (cons x (contains (cdr x) (cdr w))) )
  
(define (connected-components g) 
        (if (null? g) g 
            (cons (component (car g) g) (connected-components (minus g (component (car g) g))))
       ))
  

;Problem 2
;---------

(define (sqroot val guess) ( let ( (calc (* 0.5 (+ guess (/ val guess)))) )
                                   ( let ( (test (abs(- val (* calc calc)))) )
                                         ( if (< test tol) calc (sqroot val calc)))
                          ))

(define (square-root val) (if (< val 0) 'undef (sqroot val 1.0)))

;----------------------------------------------------------------------



;Problem 4
;---------

(define (reduce f f0 l) (if (null? l) f0
                            (f (car l)(reduce f f0 (cdr l)))
                       ))

;(i)
(reduce + 0 (map (lambda (x) (+ (car x) (cadr x))) '((4723 6457) (1445 986) (2072 2918) (47 72))))


;(ii)
(let ( (mylist '((cologne 175 19.95) (make-up 221 24.99) (cream 207 22.00))) )
        (cons (map (lambda (x) (cons (car x) (* (cadr x) (caddr x)))) mylist)
              (reduce + 0 (map (lambda (x) (* (cadr x) (caddr x))) mylist) ) 
        ))

(let ( (mylist '((cologne 175 19.95) (make-up 221 24.99) (cream 207 22.00))) )
        (list (map (lambda (x) (list (car x) (* (cadr x) (caddr x)))) mylist)
              (reduce + 0 (map (lambda (x) (* (cadr x) (caddr x))) mylist) ) 
        ))


