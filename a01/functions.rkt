;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functions) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 1, Problem 1
;; **********************************************

;; Constant for gravitational acceleration
(define gravity 9.8)

;; (distance x1 y1 x2 y2) determines Manhattan distance
(define (distance x1 y1 x2 y2)
  (+ (abs (- x1 x2)) (abs (- y1 y2))))

;; (Stirling n) Determines Stirling's upper bound from n. 
(define (Stirling n)
  (* (expt n (+ n 1/2)) (expt e (- 1 n))))

;;  (logit p) determines the logit of p. 
(define (logit p)
  (log (/ p (- 1 p))))

;;  (freq base-frequency interval) determines the even temperment. 
(define (freq base-frequency interval)
  (* base-frequency (expt 2 (/ interval 12))))

;;  (d1 maturity rate volatility spot-price strike-price) is the Black-Scholes formula
(define (d1 maturity rate volatility spot-price strike-price)
  (* (/ 1 (* volatility (sqrt maturity)))
     (+ (log (/ spot-price strike-price))
        (* (+ rate (/ (sqr volatility) 2)) maturity))))

;; (height initial-velocity time) is the ballistics formula
(define (height initial-velocity time)
  (- (* initial-velocity time) (* 1/2 gravity (sqr time))))
