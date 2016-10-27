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
           [(mul? expr) ... (add-fn expr)]))

(define-struct add [arg0 arg1])
;; An AddCall is a (make-add arg0 arg1)
;; Interpertation:
;;  - Expression arg0: the first Expression to be added in the 
;;                     addition problem being represented
;;  - Expression arg1: the second Expression to be added in the
;;                     addition problem being represented

;; Example:
(define ADD-0 (make-add 2 2))

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

;; Template:
#; (define (mul-fn m)
     ... (expression-fn (mul-arg0 m))
     ... (expression-fn (mul-arg1 m)))
