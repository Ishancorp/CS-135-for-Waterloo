;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hello-world) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
(define (Fahrenheit->Celsius fahrenheit)
  (/ (- fahrenheit 32) 1.8))

(define (dollar->euro dollar)
  (* dollar 0.83))

(define (triangle base height)
  (/ (* base height) 2))

(define (convert3 one two three)
  (+ one (* two 10) (* three 100)))

(define (f1 n)
  (+ 10 (sqr n)))

(define (f2 n)
  (+ 20 (/ (sqr n) 2)))

(define (f3 n)
  (- 2 (/ 1 n)))

(define (tax grosspay)
  (* grosspay 0.15))

(define (netpay h)
  (* 12 h))

(define (sum-coins pennies nickels dimes quarters)
  (+ pennies (* 5 nickels) (* 10 nickels) (* 25 quarters)))

(define (total-profit customers)
  (- (* 4.5 customers) 20))

(define (f x)
  (+ x 10))

(define (g x)
  (+ x 10))

(define (h x) 
  (+ x 10))
