;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bonus) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 1, Problem 4
;; **********************************************

;; (final-cs135-grade first-midterm second-midterm final-exam assignments)
;;     finds the total grade from split coursework
;; final-cs135-grade: Nat Nat Nat Nat -> Num
;;  requires assignments <= 100
;;           first-midterm <= 100
;;           second-midterm <= 100
;;           final-exam <= 100
;;           assignments <= 100
;; Examples:
(check-expect (final-cs135-grade 70 70 70 70) 143/2)

(define (final-cs135-grade first-midterm second-midterm final-exam assignments)
  (min (- 74 (* 28 (sgn (- 50 (min assignments final-exam)))))
       (+ (* 0.1 first-midterm) (* 0.2 second-midterm) (* 0.45 final-exam) (* 0.2 assignments) 5)))

;; Tests:
(check-expect (final-cs135-grade 74 76 74 73) 151/2)
(check-expect (final-cs135-grade 65 68 45 92) 46)