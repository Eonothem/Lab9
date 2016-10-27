;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname lab9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;=============================================================================
;;Problem 1:
;;=============================================================================

;; An Expresion is one of:
;;  - AtomicValue
;;  - [FunctionCallOf X]

;;Template:
#; (define (expression-fn expr)
     (cond [(struct? expr) ... (X-fn expr)]
           [(atom? expr) ...]))

;; An AtomicValue is any Expresion which statisfies the atom? predicate

;; A [FunctionCallOf X] is a (make-X arg1 arg2),
;;  where X is the structure representation of the function being called
;;  Interpertation:
;;   - Expression arg1: the first arguement passed to X when X is executed
;;   - expression arg2: the first arguement passed to X when X is executed

;;Examples:
(define-struct add [arg1 arg2])
(define-struct mul [arg1 arg2])
(define FC-0 (make-mul 3 10))
(define FC-1 (make-add (make-mul 3 3) (make-mul 4 4)))
(define FC-2 (make-add (make-mul 'x 'x) (make-mul 4 4)))
(define FC-3 (make-mul 0.5 (make-mul 3 3)))

;;Template:
#; (define (function-call-fn fc)
     ... (X-arg1 fc)
     ... (X-arg2 fc))

