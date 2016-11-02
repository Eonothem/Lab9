;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname lab9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;=============================================================================
;;Problem 1:
;;=============================================================================

;; An Expression is one of:
;;  - Number
;;  - Symbol
;;  - (make-add Expression Expression)
;;  - (make-mul Expression Expression)
;;  - (make-function-application Symbol Expression)

;; Template:
#; (define (expression-fn expr)
     (cond [(number? expr) ...]
           [(symbol? expr) ...]
           [(add? expr) ... (add-fn expr)]
           [(mul? expr) ... (mult-fn expr)]
           [(function-application? expr) ... (function-application-fn expr)]))

(define-struct add [arg0 arg1])
;; An AddApplication is a (make-add arg0 arg1)
;; Interpertation:
;;  - Expression arg0: the first Expression to be added in the 
;;                     addition problem being represented
;;  - Expression arg1: the second Expression to be added in the
;;                     addition problem being represented

;; Example:
(define ADD-0 (make-add 2 2))
(define ADD-1 (make-add 2 'x))
(define ADD-2 (make-add ADD-0 2))

;; Template:
#; (define (add-fn a)
     ... (expression-fn (add-arg0 a))
     ... (expression-fn (add-arg1 a)))

(define-struct mul [arg0 arg1])
;; A MulApplication is a (make-add arg0 arg1)
;; Interpertation:
;;  - Expression arg0: the first Expression to be added in the 
;;                     multiplication problem being represented
;;  - Expression arg1: the second Expression to be added in the
;;                     multiplication problem being represented

;; Example:
(define MUL-0 (make-mul 2 2))
(define MUL-1 (make-mul 'x 2))
(define MUL-2 (make-mul 2 MUL-0))

;; Template:
#; (define (mul-fn m)
     ... (expression-fn (mul-arg0 m))
     ... (expression-fn (mul-arg1 m)))

;;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
;;Problem 2
;;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ

;; numeric?: Expression -> Boolean
;; Consumes:
;;   - Expression expr: the inputed Expresion
;; Produces: whether or not exp is numeric
(check-expect (numeric? 5) #true)
(check-expect (numeric? 'l) #false)
(check-expect (numeric? ADD-0) #true)
(check-expect (numeric? MUL-0) #true)

(define (numeric? expr)
     (cond [(number? expr) #true]
           [(symbol? expr) #false]
           [(add? expr)
            (local [(define (add-numeric? a)
                      (and (numeric? (add-arg0 a))
                           (numeric? (add-arg1 a))))]
            (add-numeric? expr))]
           [(mul? expr)
            (local [(define (mult-numeric? m)
  (and (numeric? (mul-arg0 m))
       (numeric? (mul-arg1 m))))]
            (mult-numeric? expr))]))

;;💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯
;;Problem 3:
;;💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯💯

;; A NumericExpression is one of:
;;  - Number
;;  - (make-add NumericExpression NumericExpression)
;;  - (make-mult NumericExpression NumericExpression)

;; evaluate-with-one-def: Expression FunctionDefinition -> Expression
;; Consumes:
;;  - Expression expr: the Expression being evaluated
;;  - FunctionDefinition def: the FunctionDefinition according to which 
;;                            any FunctionApplication in expr with a  
;;                            matching name is to be evaluated
;; Produces: expr, with all instances of AddApplications replaced
;;           with the sum of their evaluated arg0 and arg1 portions,
;;           and all instances of MulApplications  replaced with the 
;;           product of their evaluated arg0 and arg1 portions

(define (evaluate-expression expr)
  (local [(define (evaluate-add a)
            (+ (evaluate-expression (add-arg0 a))
               (evaluate-expression (add-arg1 a))))
          (define (evaluate-mul m)
            (* (evaluate-expression (mul-arg0 m))
               (evaluate-expression (mul-arg1 m))))]
    (cond [(number? expr) expr]
          [(add? expr) (evaluate-add expr)]
          [(mul? expr) (evaluate-mul expr)]
          [(not (numeric? expr) (error "input must be a numeric expression: " expr))])))

(check-expect (evaluate-expression 4) 4)
(check-expect (evaluate-expression (make-add 5 5)) 10)
(check-expect (evaluate-expression (make-mul 4 2)) 8)
(check-expect (evaluate-expression (make-add 12 (make-mul 4 2))) 20)
(check-expect (evaluate-expression (make-add (make-add 1 1) (make-add 2 2))) 6)

;;🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋
;;Problem 4
;;🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋🌋

;; subst: Symbol Number -> Expression
;; Consumes:
;;  - Symbol      var: the Symbol for which val is to be substituted
;;  - Numver      val: the Number to be substituted for var
;;  - Expression expr: the Expresion in which val is to be substituted for var
;; Produces: a copy of expr with all Symbols matching var are replaced with val

(check-expect (subst 'x 2 (make-mul 'x 'y))
              (make-mul 2 'y))
(check-expect (subst 'x 4 (make-add (make-mul 3 'x) 
                                    (make-mul 'x 4))) 
              (make-add (make-mul 3 4) 
                        (make-mul 4 4)))
(check-expect 
 (evaluate-expression 
  (subst 'x 4 (make-add (make-mul 3 'x) 
                        (make-mul 'x 4)))) 
 28)

(define (subst var val expr)
  (cond [(number? expr) expr]
           [(symbol? expr)
            (if (symbol=? expr var)
                val
                expr)]
           [(add? expr) (make-add (subst var val (add-arg0 expr))
                                  (subst var val (add-arg1 expr)))]
           [(mul? expr) (make-mul (subst var val (mul-arg0 expr))
                                  (subst var val (mul-arg1 expr)))]))

;;*******************************************************************
;;Problem 5
;;*******************************************************************

(define-struct function-application [name arg])
;; An FunctionApplication is a (make-function-application name arg)
;; Interpertation:
;;  - Symbol    name: the name of the function
;;  - Expression arg: the Expression being operated on

;; Example:
(define FN-APP1 (make-function-application 'g 2))
(define FN-APP2 (make-function-application 'f (make-add 1 1)))

;;Template:
#; (define (function-application-fun def)
     ... (function-application-name def)
     ... (function-application-arg def))

;;-------------------------------------------------------------------
;;Problem 6
;;-------------------------------------------------------------------

(define-struct function-definition [name param body])
;; An FunctionDefinition is a (make-function-definition fn-name param-name arg)
;; Interpertation:
;;  - Symbol     name: the name of the function being defined
;;  - Symbol    param: the name of the function's parameter
;;  - Expression body: the body of the function

;;Template:
#; (define (function-definition-fun def)
     ... (function-definition-name def)
     ... (function-definition-param def)
     ... (function-definition-body def))

;;===================================================================
;;Problem 7
;;===================================================================

;; Examples:
(define FN1 (make-function-definition 'f 'x (make-add 3 'x)))

(define FN2 (make-function-definition 'g 'x (make-mul 3 'x)))

(define FN3 (make-function-definition 'h 'u (make-function-application 'f 'u)))

(define FN4 (make-function-definition 'i 'v (make-add (make-mul 'v 'v) (make-mul 'v 'v))))

(define FN5 (make-function-definition 'k 'w (make-mul (make-function-application 'h 'w) (make-function-application 'i 'w))))


;;===================================================================
;;Problem 8
;;===================================================================

;; evaluate-with-one-def: Expression FunctionDefinition -> Expression
;; Consumes:
;;  - Expression expr: the Expression being evaluated
;;  - FunctionDefinition def: the FunctionDefinition according to which 
;;                            any FunctionApplication in expr with a  
;;                            matching name is to be evaluated
;; Produces: expr, with all instances of FunctionApplications with names
;;           matching def evaulated with their arg substituted for any
;;           Symbol matching def's param, all instances of AddApplications
;;           replaced with the sum of their evaluated arg0 and arg1 portions,
;;           and all instances of MulApplications  replaced with the product
;;           of their evaluated arg0 and arg1 portions

(define (evaluate-with-one-def expr def)
  (local [(define (evaluate-add a)
            (+ (evaluate-with-one-def (add-arg0 a))
               (evaluate-with-one-def (add-arg1 a))))
          (define (evaluate-mul m)
            (* (evaluate-with-one-def (mul-arg0 m))
               (evaluate-with-one-def (mul-arg1 m))))
          (define (evaluate-fn-app app)
            (if (eq? (function-application-name expr) (function-definition-name def))
               (evaluate-with-one-def (subst (function-definition-param def)
                                             (function-application-arg expr)
                                             (function-definition-body def)))
               (evaluate-with-one-def expr)))]
    (cond [(number? expr) expr]
          [(add? expr) (evaluate-add expr)]
          [(mul? expr) (evaluate-mul expr)]
          [(function-application? expr) (evaluate-fn-app expr)])))

