;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname lab9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;=============================================================================
;;Problem 1:
;;=============================================================================

;; An Expresion is one of:
;;  - AtomicValue
;;  - [FunctionCallOf X]

;; An AtomicValue is one of:
;;  - Boolean
;;  - Number
;;  - String
;;  - Image

;; A [FunctionCallOf X] is a (make-X arg1 arg2),
;;  where X is the structure representation of the function being called
;;  Interpertation:
;;   - Expression arg1: the first arguement passed to X when X is executed
;;   - expression arg2: the first arguement passed to X when X is executed

