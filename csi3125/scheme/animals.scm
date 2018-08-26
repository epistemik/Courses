(empty-database!) ; start from an empty database

(assert-rule! '(mammal :- breathes-air
                          has-spine
                          has-hair))

(assert-rule! '(mammal :- warm-blooded
                         has-hair))
                         
(assert-rule! '(mammal :- gives-milk))

(assert-rule! '(fish :- breathes-water
                        has-scales
                        has-spine))

(assert-rule! '(reptile :- breathes-air
                           has-scales
                           has-spine))
                           
(assert-rule! '(snake :- reptile
                         no-legs
                         no-ears))                         
                          
(assert-rule! '(bird :- breathes-air
                        has-spine
                        has-feathers))

(assert-rule! '(vulture :- bald-head
                           bird
                           eats-carrion))                       

(assert-rule! '(amphibian :- damp-skin
                             breathes-water))
                            
(assert-rule! '(amphibian :- cold-blood
                             breathes-air
                             damp-skin))

(assert-rule! '(frog :- amphibian
                        smooth-skin
                        jumping-hind-legs
                        eats-insects
                        long-tongue))
                       
(assert-rule! '(toad :- amphibian
                        warty-skin
                        jumping-hind-legs
                        eats-insects
                        long-tongue))
                       
(assert-rule! '(bat :- mammal
                       flies
                       eats-insects))
                      
(assert-rule! '(armadillo :- mammal
                             eats-insects
                             long-tongue
                             has-armor))
                           

; First set of facts to start with:
; (assert-rule! '(gives-milk :-))
; (assert-rule! '(has-sonar :-))
; (assert-rule! '(warm-blooded :-))
; (assert-rule! '(flies :-))
; (assert-rule! '(eats-insects :-))
;
; from this set of facts (and the above rules, ask the following:
;   (provable? 'armadillo)
;   (provable? 'bat)
;   (provable? 'mammal)
;   (provable? 'bird)

; Second set of facts to start with---remember to empty the database
; and reload the rule set first:
;
; (assert-rule! '(green :-)) 
; (assert-rule! '(jumping-hind-legs :-))
; (assert-rule! '(big-eyes :-))
; (assert-rule! '(smooth-skin :-))
; (assert-rule! '(eats-insects :-))
; (assert-rule! '(breathes-air :-))
;
; With these facts, ask the following:
;
;   (provable? 'armadillo)
;   (provable? 'toad)
;   (provable? 'frog)  
;
; explain the answers

; Consider what happens when we add the following rules
; to the animals rule set:
;
; (assert-rule! '(reptile :- snake))
; (assert-rule! '(mammal :- bat))
; (assert-rule! '(cold-blooded :- amphibian))
;
; Notice that these are perfectly reasonable rules saying
; that if something's a snake, then it's also a reptile,
; if somethings a bat, then it's also a mammal, and that
; if something is an amphibian, it's also cold-blooded.

; Given these extra rules, what happens when you ask the following:
; (provable? 'bat)
; (provable? 'reptile)
; (provable? 'frog)

; Explain.

