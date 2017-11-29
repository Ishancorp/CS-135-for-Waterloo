;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bonus) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 4, Problem 5
;; **********************************************

(require "a04lib.rkt")

;; (sum-of-digits n) finds the sum of a number's digits
;; sum-of-digits: Nat -> Bool

;; Examples:
(check-expect (sum-of-digits 3) 3)

(define (sum-of-digits n)
  (cond
    [(< n 10) n]
    [else (+ (last-digit n) (sum-of-digits (other-digits n)))]))

;; (div-by-3-alt? n) determines whether a number is divisible by 3
;; div-by-3-alt?: Nat -> Bool

;; Examples:
(check-expect (div-by-3-alt? 0) false)
(check-expect (div-by-3-alt? 6) true)
(check-expect (div-by-3-alt? 9) true)

(define (div-by-3-alt? n)
  (cond
    [(< n 3) false]
    [(or (= 3 n) (= 9 n) (= 6 n)) true]
    [else (div-by-3-alt? (sum-of-digits n))]))

;; Tests:
(check-expect (div-by-3-alt? 66) true)
(check-expect (div-by-3-alt? 65) false)
(check-expect (div-by-3-alt? 64) false)
