;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname div-by-3) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 4, Problem 3
;; **********************************************

;; A Nat3 is one of:
;; * 0
;; * 1
;; * 2
;; * 3
;; (+ Nat3 3)

;; (nat3-template n3) is the template for Nat3
;; nat3-template: Nat3 -> Any
(define (nat3-template n3)
  (cond
    [(zero? n3) ...]
    [(= 1 n3) ...]
    [(= 2 n3) ...]
    [(= 3 n3) ...]
    [else (... (nat3-template (- n3 3)) ...)]))

;; (div-by-3? n) determines whether a number is divisible by 3
;; div-by-3?: Nat -> Bool

;; Examples:
(check-expect (div-by-3? 0) false)
(check-expect (div-by-3? 1) false)
(check-expect (div-by-3? 2) false)
(check-expect (div-by-3? 3) true)

(define (div-by-3? n3)
  (cond
    [(zero? n3) false]
    [(= 1 n3) false]
    [(= 2 n3) false]
    [(= 3 n3) true]
    [else (div-by-3? (- n3 3))]))

;; Tests:
(check-expect (div-by-3? 65) false)
(check-expect (div-by-3? 64) false)
(check-expect (div-by-3? 66) true)
