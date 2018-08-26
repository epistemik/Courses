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
        ( cond ( (null? set1) set1 )
               ( (null? set2) set1 )
               ( (member (car set1) set2) (minus (cdr set1) set2) )
               ( else   (cons (car set1) (minus (cdr set1) set2)) )
       ))

(define (remove node mylist)
        ( cond ( (null? mylist) mylist )
               ( (equal? node (caar mylist)) (cdr mylist) )
               ( else (cons (car mylist) (remove node (cdr mylist))) )
       ))

(define (find item mylist)
        ( cond ( (null? mylist) mylist )
               ( (equal? item (caar mylist)) (cadar mylist) )
               ( else (find item (cdr mylist)) )
       ))

(define (contains items mylist) 
        ( cond ( (null? items) items )
               ( (null? mylist) mylist )
               ( (equal? (car items) (caar mylist)) 
                         (cons (car mylist)
                               (contains (append (cdr items) (cadar mylist)) (cdr mylist))) )
               ( (find (car items) mylist)
                       (cons (cons (car items) (find (car items) mylist))
                             (contains (append (cadr items) (find (car items) mylist))
                                       (remove (car items) mylist) ) ) )
               ( else (contains (cadr items) mylist) )
        ))

(define (component x mylist) (cons x (contains (cadr x) (cdr mylist))) )
  
(define (connected-components grapha) 
        (if (null? grapha) grapha 
            (cons (component (car grapha) grapha)
                  (connected-components (minus grapha (component (car grapha) grapha))))
       ))
  

;Problem 2
;---------

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

