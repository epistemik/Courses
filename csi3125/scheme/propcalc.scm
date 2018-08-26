; backward-chaining propositional calculus inference system.

;   A proposition is represented as a Scheme symbol.
; 
;   A database is represented as a list of rules of the form
; (<head> :- <precond>...), where <head> is a symbol
; representing a proposition, :- is literally the symbol :-,
; and <precond> is a symbol representing a proposition that
; must be proved for the rule to be satisfied.
;
;   Simple facts are represented as rules with no preconditions.,
; that is, as two element lists with a proposition symbol followed
; by the :- symbol.

;   Propositions are proved by backward chaining---rules that
; could support the inference are found, and their preconditions
; are proven if possible.  Proving a precondition is done recursively,
; in the same way as proving any other proposition.

; Limitations:
;
;   * propositions only, no predicates with variables
;   * no NOT operator
;   * backward chaining only, no forward rules or Prolog-style assert()
;   * doesn't record inference path to show you the proof
;   * like Prolog, may loop infinitely if rules are mutually
;     recursive.
;   * indexing is very simple (flat list), and searches will slow down
;     as db grows.        

; Playing with the code:
;   * The variable db contains the whole database (rule/fact base).
;     You can just display it.
;   * You can uncomment the display expressions in provable? and
;     rule-satisfiable? to see the backward chaining.
;

; ---- a few handy routines: filter, and-map, and or-map ---

; filter uses a procedure to filter a list.  Like map, it iterates
; through the list applying the predicate to each element.  Unlike
; map, the list it returns is a list of the elements for which
; pred? returned a true.

(define (filter pred? lis)
   (if (null? lis)
       '()
       (if (pred? (car lis))
           (cons (car lis)
                 (filter pred? (cdr lis)))
           (filter pred? (cdr lis)))))

; or-map maps a procedure proc over the elements of a list, returning
; #t if a true value results from any of the applications of
; proc to a list element, and #f otherwise.  Like or, it is
; short-circuiting---as soon as a true value is obtained,
; #t is returned without applying proc to the remaining items
; in the list.
        
(define (or-map proc lis)
   (if (null? lis)
       #f
       (let ((first-val (proc (car lis))))
          (if first-val
              first-val
              (or-map proc (cdr lis))))))

; and-map maps a procedure over the elements of a list, returning
; #t if all of the resulting values are true.  It returns #f if
; any of the applications of proc to a list item returns #f.  Like
; and, it is short-circuiting---as soon as a false value is obtained,
; #f is returned without applying proc to the remaining items in
; the list.

(define (and-map proc lis)
   (if (null? lis)
       #t
       (if (proc (car lis))
           (and-map proc (cdr lis))
           #f)))
                      

; We represent the database as a list of rules, initially empty   
(define db '())

; We can clear out the database to start fresh
(define (empty-database!) (set! db '()))


(define (assert-rule! rule)
   (set! db (cons rule db))
   #t)

(define (rule-head rule)
   (car rule))
   
(define (rule-preconditions rule)
   (cddr rule))
      
; provable? determine whether a proposition can be proven true
; based on rules (including simple facts) in the database.
; This routine explores an OR node in the conceptual
; AND-OR graph that represents the search for a proof.
; That is, something can be proven if ANY of the rules can
; be used to prove it.  (They're "ORed together.")

(define (provable? prop)
    (display "in provable?, prop is ") (display prop) (newline)
   
   ; search the databases for all applicable rules
   (let ((applicable-rules (filter (lambda (rule)
                                      (eq? (car rule) prop))
                                   db)))
       (display "      applicable rules: ")
       (display applicable-rules) (newline)
      
      ; check to see if any of the rules can be used, by recursively
      ; trying to prove the rules' preconditions.
      (or-map rule-satisfiable?
              applicable-rules)))

; rule-satisfiable? determines whether the preconditions of
; a rule can be proven, allowing the rule to "fire", i.e., be
; used to infer the head of the rule.
; This routine effectively explores an AND node in the conceptual
; AND-OR graph that represents the search for a proof.  That is,
; a rule can be used only if ALL of its preconditions are satisfied.
; (They're "ANDed together.")
  
(define (rule-satisfiable? rule)
   (display "in rule-satisfiable?, rule is ") (display rule) (newline)
   
   ; get the rule's list of preconditions
   (let ((preconditions (rule-preconditions rule)))
   
      ; see if all of the preconditions are provable
      (and-map provable? preconditions)))

