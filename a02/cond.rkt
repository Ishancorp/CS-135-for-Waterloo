;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cond) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 2, Problem 1
;; **********************************************


;; Helper functions
;;(define (p1? x) (or (and (= (modulo x 4) 0) (not (= x 24))) (= x 97)))
;;(define (p2? x) (and (= (modulo x 3) 0) (not (= x 24))))

;; (q1a x) is an equivalent function
;;     to Question 1a given in the assignment.
;; q1a: Num -> Sym
;; Examples:
;;(check-expect (q1a 12) 'left)

(define (q1a x)
  (cond
    [(and (p2? x) (p1? x)) 'left]
    [(p2? x) 'down]
    [(p1? x) 'up]
    [else 'right]))

;; Tests:
;;(check-expect (q1a 3) 'down)
;;(check-expect (q1a 4) 'up)
;;(check-expect (q1a 5) 'right)

;; (q1b x) is an equivalent function
;;     to Question 1b given in the assignment.
;; q1b: Num -> Sym
;; Examples:
;;(check-expect (q1b 12) 'right)

(define (q1b x)
  (cond
    [(and (p1? x) (p2? x) (p1? (+ x 1))) 'up]
    [(and (p1? x) (p2? x) (p2? (* 2 x))) 'down]
    [(and (p1? x) (p2? x)) 'right]
    [(and (p1? x) (p2? 2)) 'down]
    [(p1? x) 'up]
    [(and (p1? 0) (p2? x)) 'left]
    [(p1? 0) 'right]
    [else 'down]))

;;(check-expect (q1b 48) 'down)
;;(check-expect (q1b 5) 'right)
;;(check-expect (q1b 4) 'up)
;;(check-expect (q1b 3) 'left)
;;(check-expect (q1b 96) 'up)

;; Tests:
;(check-expect (q1b -2) 'up)

;; (q1c x) is an equivalent function
;;     to Question 1c given in the assignment.
;; q1c: Num -> Sym
;; Examples:
;;(check-expect (q1c 12) 'up)

(define (q1c x)
  (cond
    [(or (and (p1? x) (p2? x)) (not (p1? x))) 'up]
    [else 'down]))

;; Tests:
;;(check-expect (q1c 4) 'down)
;;(check-expect (q1c 2) 'up)
