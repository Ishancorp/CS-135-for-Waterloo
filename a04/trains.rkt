;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname trains) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; YOUR NAME  (ID#)
;; CS135 Fall 2017
;; Assignment 04, Problem 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require "a04lib.rkt")


;; The unit structure is defined in a04lib.rkt.  The require
;; statement, above, is all that's needed to have it take
;; effect here.  The following comment is here just so the
;; type definitions that follow make sense.

;; (define-struct unit (type serial))

;; -------- Q4a --------------
;; A Unit-Type is (anyof #/L #\B #\T #\P #\C)

;; A Unit is a (make-unit Char Nat)

;; A Train is one of
;; * (cons unit Empty)
;; * (cons unit Train)


;; -------- Q4b --------------

;; string->train works by taking a string and converting
;;   it into a list of its characters. This list is then
;;   fed into another function, loc->train, a recursive
;;   function that turns a list of strings and a list of
;;   serial numbers (in this case a default list) into
;;   a list of units, which finally terminates once the
;;   function reaches an empty.

;; -------- Q4c --------------

;; (headed-by? rails car) determines whether the first
;;   train has a given unit-type.
;; headed-by?: Train Unit-Type -> Bool

;; Example:
(check-expect (headed-by? (string->train "LBC") 'L) true)

(define (headed-by? rails car)
  (symbol=? (unit-type (first rails)) car))

;; Test:
(check-expect (headed-by? (string->train "LBC") 'B) false)

;; -------- Q4d --------------

;; (train-fn rail) is the template for Trains
;; train-fn: Train -> Any
(define (train-fn rail)
  (cond
    [(empty? (rest rail)) ...]
    [else (... (first lst) ...
               (train-fn (rest rail)) ...)]))

;; (ends-with-caboose? rail) determines whether
;;   a Train ends with a caboose
;; ends-with-caboose?: Train -> Bool

;; Example:
(check-expect (ends-with-caboose? (string->train "LBC")) true)

(define (ends-with-caboose? rail)
  (cond
    [(empty? (rest rail)) (symbol=? (unit-type (first rail)) 'C)]
    [else (ends-with-caboose? (rest rail))]))

;; Tests:
(check-expect (ends-with-caboose? (string->train "LB")) false)

;; -------- Q4e --------------

;; (remove-unit t s) removes the unit that holds
;;   the serial number noted
;; remove-unit: Train Nat -> Train

;; Example:
(check-expect (remove-unit (string->train "L") 5) empty)
(check-expect (remove-unit (string->train "LBBC") 2)
              (cons (unit 'B 3) (cons (unit 'B 5) (cons (unit 'C 7) empty))))

(define (remove-unit t s)
  (cond
    [(empty? (rest t)) (rest t)]
    [(= (unit-serial (first t)) s) (rest t)]
    [else (cons (first t) (remove-unit (rest t) s))]))

;; Test:
(check-expect (remove-unit (string->train "LBBC") 5)
              (cons (unit 'L 2) (cons (unit 'B 3) (cons (unit 'C 7) empty))))

;; -------- Q4f --------------

;; (remove-locomotives rail) removes locomotives
;;   from a Train
;; remove-locomotives: Train -> Train

;; Example:
(check-expect (remove-locomotives (string->train "C"))
              (string->train "C"))
(check-expect (remove-locomotives empty) empty)

(define (remove-locomotives rail)
  (cond
    [(empty? rail) rail]
    [(not (symbol=? 'L (unit-type (first rail)))) rail]
    [else (remove-locomotives (rest rail))]))

;; (remove-cars rail) removes cars from a Train
;; remove-cars: Train -> Train

;; Example:
(check-expect (remove-cars (string->train "C"))
              (string->train "C"))
(check-expect (remove-cars empty) empty)

(define (remove-cars rail)
  (cond
    [(empty? rail) rail]
    [(not (or (symbol=? 'B (unit-type (first rail)))
              (symbol=? 'T (unit-type (first rail)))
              (symbol=? 'P (unit-type (first rail))))) rail]
    [else (remove-cars (rest rail))]))

;; (remove-cabooses rail) removes cabooses from
;;   a Train
;; remove-cabooses: Train -> Train

;; Example:
(check-expect (remove-cabooses (string->train "B"))
              (string->train "B"))
(check-expect (remove-cabooses empty) empty)

(define (remove-cabooses rail)
  (cond
    [(empty? rail) rail]
    [(not (symbol=? 'C (unit-type (first rail)))) rail]
    [else (remove-cabooses (rest rail))]))

;; (proper-train? rail) determines whether a Train
;;   is proper
;; proper-train?: Train -> Bool

;; Example:
(check-expect (proper-train? (string->train "LBC")) true)

(define (proper-train? rail)
  (empty? (remove-cabooses (remove-cars (remove-locomotives rail)))))

;; Test:
(check-expect (proper-train? (string->train "LBLBTBPBC")) false)
