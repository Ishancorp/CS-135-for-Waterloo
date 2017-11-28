;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname grades) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 1, Problem 3
;; **********************************************

;; (final-cs135-grade first-midterm second-midterm final-exam assignments)
;;     finds the total grade from split coursework
;; final-cs135-grade: Num Num Num Num -> Num
;;  requires 0 <= assignments <= 100
;;           0 <= first-midterm <= 100
;;           0 <= second-midterm <= 100
;;           0 <= final-exam <= 100
;;           0 <= assignments <= 100
;; Examples:
(check-expect (final-cs135-grade 70 70 70 70) 143/2)

(define (final-cs135-grade first-midterm second-midterm final-exam assignments)
  (+ (* 0.1 first-midterm) (* 0.2 second-midterm) (* 0.45 final-exam) (* 0.2 assignments) 5))

;; Tests:
(check-expect (final-cs135-grade 74 76 74 73) 151/2)
(check-expect (final-cs135-grade 65 68 45 92) 255/4)


;; (cs135-final-exam-grade-needed first-midterm second-midterm assignments)
;;      finds the minimum final exam grade to get a total 60%
;; cs135-final-exam-grade-needed: Nat Nat Nat Nat -> Num
;;  requires assignments <= 100
;;           first-midterm <= 100
;;           second-midterm <= 100
;;           assignments <= 100
;; Examples:
(check-expect (cs135-final-exam-grade-needed 100 100 100) 100/9)

(define (cs135-final-exam-grade-needed first-midterm second-midterm assignments)
  (/ (- 60 (* 0.1 first-midterm) (* 0.2 second-midterm) (* 0.2 assignments) 5) 0.45))

;; Tests:
(check-expect (cs135-final-exam-grade-needed 60 60 60) 500/9)