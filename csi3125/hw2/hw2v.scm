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

(define graph4 '( (a (b d)) (b (a)) (c (e)) (d (a)) (e (c)) ) )

  
(define (minus list1 list2)
        ( cond ( (null? list1) list1 )
               ( (null? list2) list1 )
               ( (member (car list1) list2) (minus (cdr list1) list2) )
               ( else   (cons (car list1) (minus (cdr list1) list2)) )
       ))

(define (remove node xlist)
        ( cond ( (null? xlist) xlist )
               ( (equal? node (caar xlist)) (cdr xlist) )
               ( else (cons (car xlist) (remove node (cdr xlist))) )
       ))

(define (find item xlist)
        ( cond ( (null? xlist) xlist )
               ( (equal? item (caar xlist)) (cadar xlist) )
               ( else (find item (cdr xlist)) )
       ))

(define (contains itemlist grlist) 
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
                                            (list node end)) )) )
               )))

(define (component x glist)
        ( let ( (xcomp (contains (cadr x) (cdr glist))) )
              ( cond ( (null? xcomp) (append (list x) xcomp) )
                     ( (symbol? (car xcomp)) (list x xcomp) )
                     ( else (append (list x) xcomp) )
            )))

(define (connected-components grapha) 
        (if (null? grapha) grapha 
            ( let ( (compa (component (car grapha) grapha)) )
                  ( cons compa (connected-components (minus grapha compa)) )
          )))


;Problem 2
;---------

(define tol 0.000001)

(define (sqroot num guess) ( let ( (calc (* 0.5 (+ guess (/ num guess)))) )
                                   ( let ( (test (abs(- num (* calc calc)))) )
                                         ( if (< test tol) calc (sqroot num calc)))
                          ))

(define (square-root num) (if (< num 0) 'undef (sqroot num 1.0)))

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





