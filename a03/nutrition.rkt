;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname nutrition) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 3, Problem 2
;; **********************************************

;; Constants
(define fat->calories 9)
(define carbs->calories 4)
(define protein->calories 4)

(define-struct nutri-fact (name serving fat carbs sugar protein))
;; A Nutri-Fact is a (make-nutri-fact Str Num Num Num Num Num)
;; requires: 0 < serving
;;           fat + carbs + protein <= serving
;;           0 <= sugar <= carbs
;;           0 <= fat, protein

;; my-nutri-fact-fn: Nutri-Fact -> Any
(define (my-nutri-fact-fn nutri)
  (... (nutri-fact-name nutri)
       (nutri-fact-serving nutri) ...
       (nutri-fact-fat nutri) ...
       (nutri-fact-carbs nutri) ...
       (nutri-fact-sugar nutri) ...
       (nutri-fact-protein nutri) ...))

;; (resize nutri serving) creates a Nutri-Fact with a resized serving portion
;; resize: Nutri-Fact Num -> Nutri-Fact

;; Example:
(check-expect (resize (make-nutri-fact "Kirkland Cashews" 25 10 15 5 25) 15) (make-nutri-fact "Kirkland Cashews" 15 6 9 3 15))

(define (resize nutri serving)
  (make-nutri-fact
       (nutri-fact-name nutri)
       serving
       (* (/ serving (nutri-fact-serving nutri)) (nutri-fact-fat nutri))
       (* (/ serving (nutri-fact-serving nutri)) (nutri-fact-carbs nutri))
       (* (/ serving (nutri-fact-serving nutri)) (nutri-fact-sugar nutri))
       (* (/ serving (nutri-fact-serving nutri)) (nutri-fact-protein nutri))))

;; Test
(check-expect (resize (make-nutri-fact "Raisin Bran" 68 23 423 2423 4213) 24) (make-nutri-fact "Raisin Bran" 24 138/17 2538/17 14538/17 25278/17))

;; (calories nutri) determines the calories of a food product
;; calories: Nutri-Fact -> Num

;; Example:
(check-expect (calories (make-nutri-fact "Kirkland Cashews" 25 10 15 5 25)) 250)

(define (calories nutri)
  (+ (* (nutri-fact-fat nutri) fat->calories)
  (* (nutri-fact-carbs nutri) carbs->calories)
  (* (nutri-fact-protein nutri) protein->calories)))

;; Test:
(check-expect (calories (make-nutri-fact "Raisin Bran" 68 23 423 2423 4213)) 18751)

;; (choose-for-diet nutri1 nutri2) determines the Nutri-Fact that is
;;                                 the best for the friend's diet
;; choose-for-diet: Nutri-Fact Nutri-Fact -> Nutri-Fact

;; Example:
(check-expect (choose-for-diet (make-nutri-fact "Raisin Bran" 1 100 100 100 100) (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))
              (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))

(define (choose-for-diet nutri1 nutri2)
  (cond
    [(< (/ (nutri-fact-sugar nutri1) (nutri-fact-serving nutri1))
        (/ (nutri-fact-sugar nutri2) (nutri-fact-serving nutri2))) nutri1]
    [(> (/ (nutri-fact-sugar nutri1) (nutri-fact-serving nutri1))
        (/ (nutri-fact-sugar nutri2) (nutri-fact-serving nutri2))) nutri2]
    [(< (/ (nutri-fact-protein nutri1) (nutri-fact-serving nutri1))
        (/ (nutri-fact-protein nutri2) (nutri-fact-serving nutri2))) nutri1]
    [(> (/ (nutri-fact-protein nutri1) (nutri-fact-serving nutri1))
        (/ (nutri-fact-protein nutri2) (nutri-fact-serving nutri2))) nutri2]
    [(< (/ (nutri-fact-carbs nutri1) (nutri-fact-serving nutri1))
        (/ (nutri-fact-carbs nutri2) (nutri-fact-serving nutri2))) nutri1]
    [(> (/ (nutri-fact-carbs nutri1) (nutri-fact-serving nutri1))
        (/ (nutri-fact-carbs nutri2) (nutri-fact-serving nutri2))) nutri2]
    [(< (/ (nutri-fact-fat nutri1) (nutri-fact-serving nutri1))
        (/ (nutri-fact-fat nutri2) (nutri-fact-serving nutri2))) nutri1]
    [(> (/ (nutri-fact-fat nutri1) (nutri-fact-serving nutri1))
        (/ (nutri-fact-fat nutri2) (nutri-fact-serving nutri2))) nutri2]
    [else nutri1]))

;; Tests
(check-expect (choose-for-diet (make-nutri-fact "Raisin Bran" 1 100 100 100 100) (make-nutri-fact "Kirkland Cashews" 2 100 100 100 100))
              (make-nutri-fact "Kirkland Cashews" 2 100 100 100 100))
(check-expect (choose-for-diet (make-nutri-fact "Kirkland Cashews" 2 100 100 100 100) (make-nutri-fact "Raisin Bran" 1 100 100 100 100))
              (make-nutri-fact "Kirkland Cashews" 2 100 100 100 100))
(check-expect (choose-for-diet (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1) (make-nutri-fact "Raisin Bran" 1 100 100 100 100) )
              (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))
(check-expect (choose-for-diet (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1) (make-nutri-fact "Raisin Bran" 1 100 100 1 100) )
              (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))
(check-expect (choose-for-diet (make-nutri-fact "Kirkland Cashews" 2 100 100 200 100) (make-nutri-fact "Raisin Bran" 1 100 100 100 100))
              (make-nutri-fact "Kirkland Cashews" 2 100 100 200 100))
(check-expect (choose-for-diet (make-nutri-fact "Raisin Bran" 1 100 100 1 100) (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))
              (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))
(check-expect (choose-for-diet (make-nutri-fact "Raisin Bran" 1 100 100 100 100) (make-nutri-fact "Kirkland Cashews" 2 100 100 200 100))
              (make-nutri-fact "Kirkland Cashews" 2 100 100 200 100))

(check-expect (choose-for-diet (make-nutri-fact "Raisin Bran" 1 100 100 100 100) (make-nutri-fact "Kirkland Cashews" 2 100 100 200 200))
              (make-nutri-fact "Kirkland Cashews" 2 100 100 200 200))
(check-expect (choose-for-diet (make-nutri-fact "Raisin Bran" 1 100 100 1 1) (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))
              (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))
(check-expect (choose-for-diet (make-nutri-fact "Kirkland Cashews" 2 100 100 200 200) (make-nutri-fact "Raisin Bran" 1 100 100 100 100))
              (make-nutri-fact "Kirkland Cashews" 2 100 100 200 200))
(check-expect (choose-for-diet (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1) (make-nutri-fact "Raisin Bran" 1 100 100 1 1))
              (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))

(check-expect (choose-for-diet (make-nutri-fact "Raisin Bran" 1 100 100 100 100) (make-nutri-fact "Kirkland Cashews" 2 100 200 200 200))
              (make-nutri-fact "Kirkland Cashews" 2 100 200 200 200))
(check-expect (choose-for-diet (make-nutri-fact "Raisin Bran" 1 100 1 1 1) (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))
              (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))
(check-expect (choose-for-diet (make-nutri-fact "Kirkland Cashews" 2 100 200 200 200) (make-nutri-fact "Raisin Bran" 1 100 100 100 100))
              (make-nutri-fact "Kirkland Cashews" 2 100 200 200 200))
(check-expect (choose-for-diet (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1) (make-nutri-fact "Raisin Bran" 1 100 1 1 1))
              (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))

(check-expect (choose-for-diet (make-nutri-fact "Kirkland Cashews" 2 200 200 200 200) (make-nutri-fact "Raisin Bran" 1 100 100 100 100))
              (make-nutri-fact "Kirkland Cashews" 2 200 200 200 200))
(check-expect (choose-for-diet (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1) (make-nutri-fact "Raisin Bran" 1 1 1 1 1))
              (make-nutri-fact "Kirkland Cashews" 1 1 1 1 1))

;; (valid-nutri-fact? nutri) determines whether the Nutri-Fact follows the contract's terms
;; valid-nutri-fact?: Nutri-Fact -> Bool

;; Example:
(check-expect (valid-nutri-fact? (make-nutri-fact "Kirkland Cashews" 2 200 200 200 200)) true)

(define (valid-nutri-fact? nutri)
  (and (nutri-fact? nutri)
       (string? (nutri-fact-name nutri))
       (number? (nutri-fact-serving nutri))
       (number? (nutri-fact-fat nutri))
       (number? (nutri-fact-carbs nutri))
       (number? (nutri-fact-sugar nutri))
       (number? (nutri-fact-protein nutri))))

;; Tests:
(check-expect (valid-nutri-fact? (make-nutri-fact 1 2 200 200 200 200)) false)
(check-expect (valid-nutri-fact? (make-nutri-fact "Kirkland Cashews" 'two 200 200 200 200)) false)
(check-expect (valid-nutri-fact? (make-nutri-fact "Kirkland Cashews" 2 'hundred 200 200 200)) false)
(check-expect (valid-nutri-fact? (make-nutri-fact "Kirkland Cashews" 2 200 'hundred 200 200)) false)
(check-expect (valid-nutri-fact? (make-nutri-fact "Kirkland Cashews" 2 200 200 'hundred 200)) false)
(check-expect (valid-nutri-fact? (make-nutri-fact "Kirkland Cashews" 2 200 200 200 'hundred)) false)
