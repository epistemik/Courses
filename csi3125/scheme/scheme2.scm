
(define (find-value name a-list) (cond
                                   ( (equal? name (caar a-list)) #t      )
                                   ( else (find-value name (cdr a-list)) )
                                 ))
 
(define (findvalue name a-list) (cond
                                    ( (equal? name (caar a-list)) (cadar a-list) )
                                    ( else (findvalue name (cdr a-list))         )
                                  ))
 
(define (delete-pair name alist) (cond
                                   ( (null? alist)              '()                         )
                                   ( (equal? name (caar alist)) (cdr alist)                 )
                                   ( else (cons (car alist) (delete-pair name (cdr alist))) )
                                 ))

(define (deletepair name alist) (cond
                                   ( (null? alist)        alist                             )
                                   ( (equal? name (caar alist)) (cdr alist)                 )
                                   ( else (cons (car alist) (deletepair name (cdr alist)))  )
                                 ))

(define (add-to-queue A B) (append A (list B)) )

(define (union set1 set2) ( cond 
                             ( (null? set1)              set2                     )
                             ( (null? set2)              set1                     )
                             ( (member (car set1) set2) (union (cdr set1) set2)   )
                             ( else   ( cons (car set1) (union (cdr set1) set2))  )
                          ))

(define (unx set1 set2) ( cond 
                             ( (null? set1)              set2                     )
                             ( (member (car set1) set2) (unx (cdr set1) set2)     )
                             ( else   ( cons (car set1) (unx (cdr set1) set2))    )
                          ))

(define (intersection set1 set2) ( if (null? set1) set1 
                                      ( if (member (car set1) set2)
                                           (cons (car set1)(intersection (cdr set1) set2))
                                               (intersection (cdr set1) set2)
                                 )))

(define (interlet set1 set2)
        (if (null? set1) set1 
            (let ( (cd1 (cdr set1)) )
                 ( if (member (car set1) set2) (cons (car set1)(interlet cd1 set2))
                      (interlet cd1 set2) )
            )))

(define (intx set1 set2) ( cond 
                             ( (null? set1)              set1                                   )
                             ( (member (car set1) set2) (cons (car set1)(intx (cdr set1) set2)) )
                             ( else   ( intersection (cdr set1) set2 )                          )
                          ))

(define (minus set1 set2) ( cond 
                             ( (null? set1)              set1                     )
                             ( (null? set2)              set1                     )
                             ( (member (car set1) set2) (minus (cdr set1) set2)   )
                             ( else   (cons (car set1) (minus (cdr set1) set2))   )
                          ))

(define (unique set1)
          ( cond ( (null? set1)              set1                      )
                 ( (member (car set1) (cdr set1)) (unique (cdr set1))  )
                 ( else   (cons (car set1) (unique (cdr set1)))        )
         ))

(define (uniq set1)
             (if (null? set1)  set1   
                (let ( (unq1 (uniq (cdr set1))) )
                     ( if (member (car set1) (cdr set1)) unq1  
                         (cons (car set1) unq1) )
             )))


(define L (append '(1 2 3 4) '(5 6 7 8 9)))

(define M '( (p(n)) (q 26) (r b) (s -10) ) )

(define N '(e 3 r 5 6 (5)))

(define Q '())

(define K (append L N))


;(map (lambda (x) (if (number? x) (list 'num x) (list 'nonum x))) N);
 
 
;reduce (in class notes)
;-----------------------

(define (reduce f f0 L) (if (null? L) f0
                           (f (car L) (reduce f f0 (cdr L)))
                         ))

;>> NOT A DEFINED FUNCTION!!
 
;reduce f f0 L = (f0 L1(f0 L2(f0 L3(f0 L4 f))))).
 
;L = (1 2 3 4) -> (reduce (+ f x) 1 L) = 11.

