;MARK SATTOLO  428500
;CSI3125  HW4
;Problem 1
;---------

(define (candy shape filling height dim1 dim2)
        ( let ( (df1 (define pi 3.14159265) )
                (df2 (define liquor 2) )
                (df3 (define nuts 3) )
                (df4 (define nougat 4) )
                (df5 (define round 'round) )
                (df6 (define rectangular 'rectangular) )
                (df7 (define triangular 'triangular) )
                (df8 (define (surface_round radius nought) (* (* radius radius) pi) ) )
                (df9 (define (surface_rectangular side1 side2) (* side1 side2) ) )
               (df10 (define (surface_triangular base height) (* (* base height) 0.5) ) )
               (df11 (define (total_weight shape filling height dim1 dim2 subprog)
                                          ( * (* filling height) (subprog dim1 dim2) ) ) )
              )
              ( cond ( (eq? shape round) (total_weight shape filling height dim1 dim2 surface_round) )
                     ( (eq? shape rectangular) (total_weight shape filling height dim1 dim2 surface_rectangular) )
                     ( else (total_weight shape filling height dim1 dim2 surface_triangular) )
       )))

;----------------------------------------------------------------------

