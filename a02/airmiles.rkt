;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname airmiles) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 2, Problem 2
;; **********************************************

(define standard-sponsor-airmiles 15)
(define standard-nosponsor-airmiles 20)
(define premium-sponsor-airmiles 10)
(define premium-nosponsor-airmiles 15)

;; (calc-airmiles dollars-spent card-type sponsor?)
;;    determines the amount of AirMiles rewarded
;; calc-airmiles: Nat Sym Bool -> Int
;; card-type is equal to 'standard or 'premium
;; Example:
(check-expect (calc-airmiles 15 'standard true) 1)

(define (calc-airmiles dollars-spent card-type sponsor)
  (cond
    [(and (symbol=? card-type 'standard) sponsor) (floor (/ dollars-spent standard-sponsor-airmiles))]
    [(symbol=? card-type 'standard) (floor (/ dollars-spent standard-nosponsor-airmiles))]
    [sponsor (floor (/ dollars-spent premium-sponsor-airmiles))]
    [else (floor (/ dollars-spent premium-nosponsor-airmiles))]))

;; Tests
(check-expect (calc-airmiles 37 'standard true) 2)
(check-expect (calc-airmiles 10 'premium true) 1)
(check-expect (calc-airmiles 37 'premium true) 3)
(check-expect (calc-airmiles 20 'standard false) 1)
(check-expect (calc-airmiles 59.99 'standard false) 2)
(check-expect (calc-airmiles 30 'premium false) 2)
(check-expect (calc-airmiles 59.99 'premium false) 3)
