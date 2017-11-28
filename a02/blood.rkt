;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname blood) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 2, Problem 4
;; **********************************************

;; (can-donate-to/cond? donor-type recipient-type)
;;   determines whether a donor can donate to a recipient with a certain blood type
;; can-donate-to/cond?: Sym Sym -> Bool
;; Required: donor-type, recipient-type must equal
;;           'O-, 'O+, 'A-, 'A+, 'B+, 'B-, 'AB+, 'AB-
;; Examples:
(check-expect (can-donate-to/cond? 'O- 'AB-) true)

(define (can-donate-to/cond? donor-type recipient-type)
  (cond
    [(symbol=? donor-type recipient-type) true]
    [(symbol=? donor-type 'O-) true]
    [(symbol=? recipient-type 'AB+) true]
    [(symbol=? donor-type 'O+)
     (cond
       [(symbol=? recipient-type 'A+) true]
       [(symbol=? recipient-type 'B+) true]
       [else false])]
    [(symbol=? donor-type 'A-)
     (cond
       [(symbol=? recipient-type 'A+) true]
       [(symbol=? recipient-type 'AB-) true]
       [else false])]
    [(symbol=? donor-type 'B-)
     (cond
       [(symbol=? recipient-type 'B+) true]
       [(symbol=? recipient-type 'AB-) true]
       [else false])]
    [else false]))

;;Tests:
(check-expect (can-donate-to/cond? 'O- 'O-) true)
(check-expect (can-donate-to/cond? 'A- 'AB+) true)
(check-expect (can-donate-to/cond? 'O+ 'A+) true)
(check-expect (can-donate-to/cond? 'O+ 'B+) true)
(check-expect (can-donate-to/cond? 'O+ 'B-) false)
(check-expect (can-donate-to/cond? 'A- 'A+) true)
(check-expect (can-donate-to/cond? 'A- 'AB-) true)
(check-expect (can-donate-to/cond? 'A- 'B-) false)
(check-expect (can-donate-to/cond? 'B- 'B+) true)
(check-expect (can-donate-to/cond? 'B- 'AB-) true)
(check-expect (can-donate-to/cond? 'B- 'O-) false)
(check-expect (can-donate-to/cond? 'A+ 'O-) false)

;; (can-donate-to/bool? donor-type recipient-type)
;;   determines whether a donor can donate to a recipient with a certain blood type
;; can-donate-to/bool?: Sym Sym -> Bool
;; Required: donor-type, recipient-type must equal
;;           'O-, 'O+, 'A-, 'A+, 'B+, 'B-, 'AB+, 'AB-
;; Examples:
(check-expect (can-donate-to/bool? 'O- 'AB-) true)

(define (can-donate-to/bool? donor-type recipient-type)
  (or
   (symbol=? donor-type recipient-type)
   (symbol=? donor-type 'O-)
   (symbol=? recipient-type 'AB+)
   (and (symbol=? donor-type 'O+)
        (or
         (symbol=? recipient-type 'A+)
         (symbol=? recipient-type 'B+)))
   (and (symbol=? donor-type 'A-)
        (or
         (symbol=? recipient-type 'A+)
         (symbol=? recipient-type 'AB-)))
   (and (symbol=? donor-type 'B-)
        (or
         (symbol=? recipient-type 'B+)
         (symbol=? recipient-type 'AB-)))))


(check-expect (can-donate-to/bool? 'O- 'O-) true)
(check-expect (can-donate-to/bool? 'A- 'AB+) true)
(check-expect (can-donate-to/bool? 'O+ 'A+) true)
(check-expect (can-donate-to/bool? 'O+ 'B+) true)
(check-expect (can-donate-to/bool? 'O+ 'B-) false)
(check-expect (can-donate-to/bool? 'A- 'A+) true)
(check-expect (can-donate-to/bool? 'A- 'AB-) true)
(check-expect (can-donate-to/bool? 'A- 'B-) false)
(check-expect (can-donate-to/bool? 'B- 'B+) true)
(check-expect (can-donate-to/bool? 'B- 'AB-) true)
(check-expect (can-donate-to/bool? 'B- 'O-) false)
(check-expect (can-donate-to/bool? 'A+ 'O-) false)
