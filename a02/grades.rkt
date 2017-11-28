;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname grades) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 2, Problem 3
;; **********************************************

;; Constants
(define ensured-fail 46)

;; (weighted-avg-cs135-grade midterm-1 midterm-2 final-exam assignments participation)
;;   determines the weighted average of a student's marks
;; weighted-avg-cs135-grade: Nat Nat Nat Nat Nat -> Num
;; requires: midterm-1 <= 100
;;           midterm-2 <= 100
;;           final-exam <= 100
;;           assignments <= 100
;;           participation <= 100
;; Example
(check-expect (weighted-avg-cs135-grade 70 15 100 100 100) 80)

(define (weighted-avg-cs135-grade midterm-1 midterm-2 final-exam assignments participation)
  (+ (* 0.1 midterm-1) (* 0.2 midterm-2) (* 0.45 final-exam) (* 0.2 assignments) (* 0.05 participation)))

;; (final-cs135-grade midterm-1 midterm-2 final-exam assignments participation)
;;     determines the final grade of a student
;; final-cs135-grade: Nat Nat Nat Nat Nat -> Num
;; requires: midterm-1 <= 100
;;           midterm-2 <= 100
;;           final-exam <= 100
;;           assignments <= 100
;;           participation <= 100
;; Example:
(check-expect (final-cs135-grade 70 70 70 70 100) 143/2)

(define (final-cs135-grade midterm-1 midterm-2 final-exam assignments participation)
  (cond
    [(and (or (< assignments 50) (< (+ (* 2/15 midterm-1) (* 4/15 midterm-2) (* 3/5 final-exam)) 50))
          (< ensured-fail (weighted-avg-cs135-grade midterm-1 midterm-2 final-exam assignments participation))) 46]
    [else (weighted-avg-cs135-grade midterm-1 midterm-2 final-exam assignments participation)]))

(check-expect (final-cs135-grade 70 15 40 100 100) 46)
(check-expect (final-cs135-grade 100 100 100 45 100) 46)
(check-expect (final-cs135-grade 100 100 100 50 100) 46)
(check-expect (final-cs135-grade 50 50 50 100 100) 46)
