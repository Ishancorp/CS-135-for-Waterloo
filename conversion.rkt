;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname conversion) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 1, Problem 2
;; **********************************************

;; Useful constants
(define speed-metric->imperial 3600000/1609344)
(define conversion-mpg->L/100km 3785411784/16093440)
(define speed-imperial->smoot/mfn (/ 12096000/17018 speed-metric->imperial))

;; (m/s->mph m/s mph) produces the speed in
;;     mph from m/s
;; m/s->mph: Num -> Num
;; Requires: m/s >= 0
;; Examples:
(check-expect (m/s->mph 1) 3600000/1609344)

(define (m/s->mph m/s)
  (* m/s speed-metric->imperial))

;; Tests;
(check-expect (m/s->mph 12573) 28125)
(check-expect (m/s->mph 4191) 9375)

;; **********************************************

;; (mph->S/mfn mph) produces the speed in smoots/millifortnight
;;    from mph
;; mph->S/mfn: Num -> Num
;; Requires: mph >= 0
;; Examples:
(check-expect (mph->S/mfn 1)
              532224/1675)

(define (mph->S/mfn mph)
  (* mph speed-imperial->smoot/mfn))

;; Tests:
(check-expect (mph->S/mfn 3600)
              76640256/67)

;; **********************************************

;; mpg->L/100km produces the fuel efficiency of a
;;          vehicle in L/100km
;; Requires: mpg >= 0
;; Examples:
(check-expect (mpg->L/100km 1/480) 112903)

(define (mpg->L/100km mpg)
  (* conversion-mpg->L/100km (/ 1 mpg)))

;; Test:
(check-expect (mpg->L/100km 1/1920) 451612)