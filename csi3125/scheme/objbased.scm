; objbased.scm --- Scheme code for a simple object-based programming
; system based on classes and generic procedures.

; This is portable scheme code except that it requires define-macro,
; which is like Lisp defmacro.  (RScheme and Gambit have this, and
; there are implementations for other Scheme systems available
; from the Scheme repository at Indiana.

; filter a list, returning a list of the elements of the original list
; that satisfy the predicate pred?

(define (filter pred? lis)
   (if (null? lis)
       '()
       (if (pred? (car lis))
           (cons (car lis)
                 (filter pred? (cdr lis)))
           (filter pred? (cdr lis)))))


; find the first element of a list that satisfies the predicate pred?
; and return that one element.

(define (find pred? lis)
   (if (null? lis)
       #f
       (if (pred? (car lis))
           (car lis)
           (find pred? (cdr lis)))))



; disp is a variant of display that can handle most circular structures,
; which is useful for displaying cyclic structures.  We want this because
; all of our class objects are have pointers to class <<class>>, which
; is circular, and all of our instance objects have pointers to class
; objects.
;
; it can't handle cyclic lists, though, or improper list.
;
; it can handle things like class objects that hold pointers to themselves.
;
; by default, it prints a data structure down to 3 levels of structure,
; and uses ... to represent the stuff below that level.
   

(define (disp-list-elems lis n)
   (cond ((< n 1)
          (display "..."))
         ((not (null? lis)) 
          (disp (car lis) (- n 1))
          (map (lambda (x)
                 (display " ")
                 (disp x (- n 1)))
               (cdr lis))))
   #f)
   

(define (disp obj . rest)
   ; if no rest arg, default to 3 levels
   (let ((n (if (not (null? rest))
                (car rest)
                3)))
      (cond ((pair? obj)
             (cond ((list? obj) 
                    (display "(")
                    (disp-list-elems obj n)
                    (display ")"))
                   (else
                    (display "...<ill-structured list>...."))))
            ((vector? obj)
             (display "#(")
             (disp-list-elems (vector->list obj) n)
             (display ")"))
            (else
             (display obj))))
   #f)

   
; we'll maintain tables, *generic-procedures* and *classes* of all of the
; generic procedures and all of the classes that are defined.  Both tables
; are represented as association lists.   Of course, we could use a more
; sophisticated implementation of tables to speed up processing of definitions.

; *generic-procedures* is an association list where each association
; has three elements: the generic procedure object itself, a procedure
; to add methods to that generic procedure, and the name of the
; generic procedure.

(define *generic-procedures* '())

; add a generic procedure to the table of all generic procedures

(define (register-generic-procedure! generic-proc method-adder name)
   (set! *generic-procedures*
         (cons (list generic-proc method-adder name)
               *generic-procedures*)))

; find the association that relates a generic procedure to its
; method adder and its name

(define (look-up-generic-assn-by-name generic-name)
   (find (lambda (assn)
            (eq? (caddr assn) generic-name))
         *generic-procedures*))

; *classes* is an association list where each association has two
; elements: the name of the class and the class object itself 

(define *classes* '())

; add a class to the table of all classes

(define (register-class! class name)
   (set! *classes*
         (cons (list name class)
               *classes*)))
               
(define (look-up-class-by-name class-name)
   (let ((assn (assq class-name *classes*)))
      (if assn
          (cadr assn)
          (error "look-up-class-by-name failed to find named class"))))   
             
; define-class generates a sequence of definitions, the last of
; which is defines binds the class name, and initializes it with
; the class object it creates.  Before that definition may be
; zero or more definitions of generic functions for the accessors.

(define-macro (define-class class-name superclass-list . slot-decls)
  
  `(begin

     ,@(generate-needed-slot-generic-defns slot-decls)
     
     (define ,class-name
             (let ((slots-alist (generate-slots-alist ',slot-decls 1)))
            
                ; create the class object, implemented as a Scheme vector
                (let ((class-object (vector <<class>>            ; metaclass
                                            ',class-name         ; name
                                            (list ,@superclass-list) ; supers
                                            slots-alist          ; slots
                                            '*dummy*)))          ; creator
 
                    ; install a routine to create instances                             
                    (vector-set! class-object
                                 4
                                 ; creation routine takes slot values
                                 ; as args, creates a vector w/class
                                 ; pointer for this class followed by
                                 ; slot values in place.
                                 (lambda ,(map car slot-decls)
                                    (vector class-object
                                            ,@(map car slot-decls))))
                                     
      
                    ; register accessor methods with appropriate generic procs 
                    (register-accessor-methods! class-object slots-alist)
                    
                    ; register the class in the table (alist) of all classes                    
                    (register-class! class-object ',class-name)
                          
                    class-object)))))
                    

(define (slot-name->getter-name slot-name-symbol)
   slot-name-symbol)
  
(define (slot-name->setter-name slot-name-symbol)
   (string->symbol (string-append "set-"
                                  (symbol->string slot-name-symbol)
                                  "!")))
                                  
 
  
  
; generate-needed-slot-generic-defns looks at a list of slot decllarations
; (s-expressions) from a class definition, and returns a list of generic
;  procedure definitions for accessing slots with those names.  The list
; only includes a definition for an accessor generic if one doesn't already
; exist.  This ensures that we generate an accessor generic procedure the first
; time we see a slot with that name.
                                 
(define (generate-needed-slot-generic-defns slot-decls)

   ; extract slot names from slot decls
   (let ((slot-names (map car slot-decls)))
   
      ; generate lists of getter and setter names
      (let ((getter-names (map slot-name->getter-name slot-names))
            (setter-names (map slot-name->setter-name slot-names)))
         
         ; combine lists of getter and setter names to get a single list
         ; and filter it to find the ones that don't have generics
         ; defined yet
         (let* ((accessor-names (append getter-names setter-names))
                (needed-names (filter (lambda (name)
                                         (not (assq name *generic-procedures*)))
                                      accessor-names)))
            ; and return a list of define s-expressions to define
            ; generics for those
            (map (lambda (name)
                    `(define-generic ,name))
                 needed-names)))))
                                        


             
; generate-slots-alist generates an association list of accessors for
; the slots of (instances of) a class.  The first (key) element is the
; slot name (symbol); the second is a closure to access that named slot,
; and the third is a closure to update that slot.

(define (generate-slots-alist slot-decls slot-num)
   (if (null? slot-decls)
       '()
       (cons `(,(caar slot-decls)
               ,(slot-n-getter slot-num)
               ,(slot-n-setter slot-num))
             (generate-slots-alist (cdr slot-decls)
                                   (+ 1 slot-num)))))
                                   
(define (slot-n-getter offset)
   (lambda (obj)                        ; return a procedure to read
      (vector-ref obj offset)))         ; slot n of an object
      
(define (slot-n-setter offset)
   (lambda (obj value)                  ; return a procedure to update
      (vector-set! obj offset value)))  ; slot n of an object


; define-generic defines a named generic procedure.  It's a macro
; that translates into a variable definition, binding the procedure
; name.  The initial value expression is a letrec that not only
; creates and returns the generic procedure, but creates its
; method list and a routine to add methods to it, and registers
; the generic procedure and its method-adding procedure in
; the association list of generic procedures.

(define-macro (define-generic name)
   `(define ,name
            (letrec ((gp-name ',name)
                     (method-alist '())
                     (method-adder
                      (lambda (class method)
                            (set! method-alist
                                  (cons (list class method)
                                        method-alist)))) 
                     (generic-proc
                     
                      ; here's where we construct the actual generic proc.
                      ; note that its arg list is just a symbol, with
                      ; no parens---that means it takes any number of
                      ; args which are all packaged up as a list.
                      
                      (lambda args
                         (let* ((class (class-of (car args)))
                                (method-assn (assq class method-alist)))
                            (if method-assn
                            
                                ; here's where the generic proc actually
                                ; calls the method proc.  Apply is used
                                ; to pass a list of arguments as though
                                ; they had been passed normally
                                
                                (apply (cadr method-assn) args)
                                (error "method not found for "
                                       gp-name))))))
                                       
               ; add the generic procedure to the list of generic procs,
               ; associating it with its adder and name
                      
               (register-generic-procedure! generic-proc method-adder ',name)
                           
               ; and return the generic procedure as the initial
               ; value for binding the name of the procedure
                           
               generic-proc)))

   
  

; given a generic procedure's name, add a method for a particular class
                        
(define (register-method-on-named-generic! generic-name class method)
   (let* ((generic-assn (look-up-generic-assn-by-name generic-name))
          (method-adder (cadr generic-assn)))
      (method-adder class method)))
    
; given a class object and a slot association, add the getter and setter
; methods for that slot of the class to the appropriate getter and
; setter generic procedures
        
(define (register-accessor-methods-for-slot! class slot-assn)
   (let ((slot-name (car slot-assn)))
      (let ((getter (cadr slot-assn))
            (getter-name (slot-name->getter-name slot-name))
            (setter (caddr slot-assn))
            (setter-name (slot-name->setter-name slot-name)))
           
         (register-method-on-named-generic! getter-name class getter)
         (register-method-on-named-generic! setter-name class setter)))) 

; given a class object and and a slots-alist (list of slot assn's),
; add the accessor (getter and setter) methods for each slot to the
; appropriate generic procedures.        
      
(define (register-accessor-methods! class slots-alist)
   
   (map (lambda (slot-assn)
           (register-accessor-methods-for-slot! class slot-assn))
        slots-alist))

; we're going to construct the metaclass object ``by hand'', and
; we'll need generic procedures for the its slot accessors.      

(define-generic name)
(define-generic set-name!)
(define-generic superclasses)
(define-generic set-superclasses!)
(define-generic slots)
(define-generic set-slots!)
(define-generic allocator)
(define-generic set-allocator!)
(define-generic properties)
(define-generic set-properties!)

; now we define the unique metaclass object <<class>>, constructing
; it ``by hand'' rather than through define-class
  
(define <<class>>
        (let* ((slots-alist (generate-slots-alist '((name) (superclasses)
                                                    (slots) (allocator)
                                                    (properties))
                                                  1))
               (the-object (vector '*dummy*    ; placeholder for class ptr
                                   '<<class>>  ; name of this class
                                   '()         ; superclasses (none)
                                   slots-alist ; slots
                                   #f          ; allocator (none)
                                   '())))      ; prop. list (initially empty)
                                  
           ; set class pointer to refer to itself
           (vector-set! the-object 0 the-object)              
                                                      
           ; register the accessor methods with the appropriate generic procs
           (register-accessor-methods! the-object slots-alist)

           ; add the class to the table (association list) of all classes           
           (register-class! the-object '<class>)  
           
           ; and return the class object as initial value for define
           the-object))
          

; the predicate class? checks if something's a class---is it represented
; as a vector whose 0th slot is a pointer to the unique metaclass object
; <<class>>?
           
(define (class? obj)
   (and (vector? obj)
        (> (vector-length obj) 0) 
        (eq? (vector-ref obj 0) <<class>>)))

; the predicate instance? checks if something's an instance of a class in
; this object system---is it a vector whose 0th slot is a class object?
        
(define (instance? obj)
   (and (vector? obj)
        (> (vector-length obj) 0)
        (class? (vector-ref obj 0))))

; class-of returns the class object representing the class of the object
; it's applied to
        
(define (class-of obj)
   (if (instance? obj)
       (vector-ref obj 0)
       (error "class of applied to object that's not an instance of a class")))

; Now we can define class <object>, the root of the normal inheritance
; hierarchy, which has no superclasses and no slots        
        
(define-class <object> ())

; Now we can define the make macro.  The make macro translates to a call
; to the allocator procedure for the class being instantiated.
; Besides the class to instantiate, the make macro takes keyword arguments
; giving the names and the values of the arguments to the allocator
; routine that allocates instances of the class.
;
; Note that the make macro is a macro so that it can sort out keyword
; arguments at macro-expansion time.  (With a compiler, that happens
; once for each call site, and at run time all it does is pass the
; argumets to the allocation routine for the class, in the right order.)
;
; In this simple version of make, we assume that all slots' initial
; values are passed as keyword arguments to make.  In a better version,
; we'd be able to specify the initial values of some slots in the
; class definition, and only pass the others (without specified
; initial values) to make. 

(define-macro (make class-name . args)
   (display "in make macro, class-name is: ") (display class-name)
   
   (let ((class (look-up-class-by-name class-name)))
      (cond ((not class)
             (error "in make macro, attempt to instantiate unknown class"))
            (else
             ; Since this simple version of make assumes all slots' initial
             ; values are passed to make, we just use the list of slots
             ; to tell us what argument names to expect.
             ; We convert the list of arg names to a list of keywords
             ; that end with a colon, which is the keywords we expect
             ; for those arguments.
             ; Then we transform the list of argument expressions into
             ; a list of arguments to the actual allocator routine,
             ; using the keywords to tell us which arguments they
             ; are, and ordering them according to the class slot
             ; order.
             (let* ((arg-name-list (map car (slots class)))
                    (arg-keyword-list (map slot-name->slot-keyword
                                           arg-name-list))
                    (arg-list (canonicalize-make-args arg-keyword-list
                                                      args)))
                ; now we can generate the actual expression to
                ; allocate an instance.  At run time, it will
                ; fetch the allocation routine for the class, and
                ; call it with the properly-ordered argument
                ; expressions as arguments.
                `((allocator ,class-name) ,@arg-list))))))

; canonicalize-make-args takes an ordered list of expected keyword
; arguments (which tells it the order in which arguments are to
; be passed to the actual allocation routine) an argument list
; consisting of keyword/value pairs.  It returns an argument
; list where the keywords have been stripped out and the argument
; expressions are ordered according to the list of expected
; arguments.
                
(define (canonicalize-make-args expected-keywords args)
   (let loop ((keywords expected-keywords)
              (ordered-args '()))
      (if (null? keywords)
          (reverse ordered-args)
          ; find the next expected keyword argument in args
          (let ((next-arg-expr (find-by-keyword (car keywords) args)))
             (loop (cdr keywords)
                   (cons next-arg-expr ordered-args))))))

; find-by-keyword searches a list for a particular symbol (presumably
; a keyword) and returns the NEXT item in the list.
                    
(define (find-by-keyword keyword lis)
   (if (null? lis)
       (error "couldn't find expected keyword in list")
       (if (eq? (car lis) keyword)
           (cadr lis)
           (find-by-keyword keyword (cdr lis)))))
           
; given a slot name (symbol), generate a keyword name (symbol) that's
; the same except that it has a semicolon on the end.
           
(define (slot-name->slot-keyword slot-name)
   (string->symbol (string-append (symbol->string slot-name)
                                  ":")))
           
          
