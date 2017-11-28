;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bonus) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 2, Problem 5
;; **********************************************

;; (can-donate-to/bonus? donor-type recipient-type)
;;   determines whether a donor can donate to a recipient with a certain blood type
;; can-donate-to/bonus?: Sym Sym -> Bool
;; Required: donor-type, recipient-type must equal
;;           'O-, 'O+, 'A-, 'A+, 'B+, 'B-, 'AB+, 'AB-
;; Examples:
(check-expect (can-donate-to/bonus? 'O- 'AB-) true)

(define (can-donate-to/bonus? donor-type recipient-type)
  (not (and
   (not (symbol=? donor-type recipient-type))
   (not (symbol=? donor-type 'O-))
   (not (symbol=? recipient-type 'AB+))
   (not (and (symbol=? donor-type 'O+)
        (not (and
         (not (symbol=? recipient-type 'A+))
         (not (symbol=? recipient-type 'B+))))))
   (not (and (symbol=? donor-type 'A-)
        (not (and
         (not (symbol=? recipient-type 'A+))
         (not (symbol=? recipient-type 'AB-))))))
   (not (and (symbol=? donor-type 'B-)
        (not (and
         (not (symbol=? recipient-type 'B+))
         (not (symbol=? recipient-type 'AB-)))))))))


(check-expect (can-donate-to/bonus? 'O- 'O-) true)
(check-expect (can-donate-to/bonus? 'A- 'AB+) true)
(check-expect (can-donate-to/bonus? 'O+ 'A+) true)
(check-expect (can-donate-to/bonus? 'O+ 'B+) true)
(check-expect (can-donate-to/bonus? 'O+ 'B-) false)
(check-expect (can-donate-to/bonus? 'A- 'A+) true)
(check-expect (can-donate-to/bonus? 'A- 'AB-) true)
(check-expect (can-donate-to/bonus? 'A- 'B-) false)
(check-expect (can-donate-to/bonus? 'B- 'B+) true)
(check-expect (can-donate-to/bonus? 'B- 'AB-) true)
(check-expect (can-donate-to/bonus? 'B- 'O-) false)
(check-expect (can-donate-to/bonus? 'A+ 'O-) false)
