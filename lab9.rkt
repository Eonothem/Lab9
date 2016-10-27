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

;; Template:
#; (define (expression-fn expr)
     (cond [(number? expr) ...]
           [(symbol? expr) ...]
           [(add? expr) ... (add-fn expr)]
           [(mul? expr) ... (mult-fn expr)]))

(define-struct add [arg0 arg1])
;; An AddCall is a (make-add arg0 arg1)
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
;; A MulCall is a (make-add arg0 arg1)
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


<<<<<<< HEAD
;;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
=======

;;ΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞΞ
>>>>>>> origin/master
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

;; A NumericExpression is either a
;; Number
;; (make-add NumericExpression NumericExpression)
;; (make-mult NumericExpression NumericExpression)

(define (evaluate-expression expr)
  (local [(define (evaluate-add a)
            (+ (evaluate-expression (add-arg0 a))
               (evaluate-expression (add-arg1 a))))
          (define (evaluate-mul m)
            (* (evaluate-expression (mult-arg0 m))
               (evaluate-expression (mult-arg1 m))))]
    (cond [(numeric? expr) expr]
          [(make-add? expr) (evaluate-add expr)]
          [(make-mult? expr) (evaluate-mul expr)])))

(check-expect (evaluate-expression 4) 4)
(check-expect (evaluate-expression (make-add 5 5)) 10)
(check-expect (evaluate-expression (make-mul 4 2)) 8)
(check-expect (evaluate-expression (make-add 12 (make-mult 4 2)) 20))
(check-expect (evaluate-expression (make-add (make-add 1 1) (make-add 2 2)) 6))