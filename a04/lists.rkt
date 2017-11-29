;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lists) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 4, Problem 2
;; **********************************************

;; (sum-positive lst) determines the sum of positive integers of a list
;; sum-positive: (listof Int) -> Nat

;; Example:
(check-expect (sum-positive empty) 0)
(check-expect (sum-positive (cons -100 empty)) 0)

(define (sum-positive lst)
  (cond
    [(empty? lst) 0]
    [(< (first lst) 0) (sum-positive (rest lst))]
    [else (+ (first lst) (sum-positive (rest lst)))]))

;; Tests:
(check-expect (sum-positive (cons 2 (cons -6 (cons 423 empty)))) 425)

;; (contains? elem lst) determines if elem is in lst
;; contains?: Any (listof Any) -> Bool

;; Example:
(check-expect (contains? 'Ishan (cons 'Ishan empty)) true)
(check-expect (contains? 'Ishan empty) true)

(define (contains? elem lst)
  (cond
    [(empty? lst) false]
    [(equal? (first lst) elem) true]
    [else (contains? elem (rest lst))]))

;; Tests:
(check-expect (contains? 'Ishan (cons 'Sharma empty)) false)
(check-expect (contains? 'Ishan (cons 'Sharma (cons 'Ishan empty))) true)

;; (has-duplicate? lst) determines whether there is more than one of something
;; has-duplicate?: (listof Any) -> Bool

;; Example:
(check-expect (has-duplicate? empty) false)
(check-expect (has-duplicate? (cons 'Ishan (cons 'Ishan empty))) true)

(define (has-duplicate? lst)
  (cond
    [(empty? lst) false]
    [(contains? (first lst) (rest lst)) true]
    [else (has-duplicate? (rest lst))]))

;; Tests:
(check-expect (has-duplicate? (cons 'Ishan (cons 'Sharma (cons 'jhgsduk (cons 'Ishan empty))))) true)
(check-expect (has-duplicate? (cons 'Ishan (cons 'Sharma (cons 'jhgsduk (cons 'Ishani empty))))) false)

;; (keep-ints lst) produces a list with only the ints of a list
;; keep-ints: (listof Any) -> (listof Int)

;; Example
(check-expect (keep-ints empty) empty)
(check-expect (keep-ints (cons 2 (cons 'jhefgwjyf (cons 1 empty)))) (cons 2 (cons 1 empty)))

(define (keep-ints lst)
  (cond
    [(empty? (rest lst)) lst]
    [(integer? (first lst)) (cons (first lst) (keep-ints (rest lst)))]
    [else (keep-ints (rest lst))]))

;; Tests:
(check-expect (keep-ints (cons 2 (cons 1 empty))) (cons 2 (cons 1 empty)))
