;MARK SATTOLO  428500
;CSI3125  HW4
;Problem 1
;---------

(define pi 3.14159)
(define liquor 2)
(define nuts 3)
(define nougat 4)
(define round 'round)
(define rectangular 'rectangular)
(define triangular 'triangular)
 
(define (surface_round radius nought) (* (* radius radius) pi) )

(define (surface_rectangular side1 side2) (* side1 side2) )

(define (surface_triangular base height) (* (* base height) 0.5) )

(define (total_weight shape filling height dim1 dim2 subprog)
        ( * (* filling height) (subprog dim1 dim2) ) )

(define (candy shape filling height dim1 dim2)
        ( cond ( (eq? shape round) (total_weight shape filling height dim1 dim2 surface_round) )
               ( (eq? shape rectangular) (total_weight shape filling height dim1 dim2 surface_rectangular) )
               ( else (total_weight shape filling height dim1 dim2 surface_triangular) )
       ))

;----------------------------------------------------------------------
