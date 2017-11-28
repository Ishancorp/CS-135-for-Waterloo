;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname creditcheck) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 3, Problem 3
;; **********************************************

(define-struct date (year month day))
;; A Date is a (make-date Nat Nat Nat)
;; requires: year/month/day corresponds to a valid date
;; (in the Gregorian calendar)
(define-struct transaction (tdate amount category))
;; A Transaction is a (make-transaction Date Num Sym)
(define-struct account (name expires limit threshold exception))
;; An Account is a (make-account Str Date Num Num Sym)
;; requires: 0 < threshold < limit

;; (date<=? date1 date2) determines whether date1 is before
;;                       or equal to date2
;; date<=?: Date Date -> Bool

;; Example:
(check-expect (date<=? (make-date 2011 1 1) (make-date 2017 12 31)) true)

(define (date<=? date1 date2)
  (cond
    [(> (date-year date1) (date-year date2)) false]
    [(< (date-year date1) (date-year date2)) true]
    [(> (date-month date1) (date-month date2)) false]
    [(< (date-month date1) (date-month date2)) true]
    [(> (date-day date1) (date-day date2)) false]
    [(< (date-day date1) (date-day date2)) true]
    [else true]))

;; Tests:
(check-expect (date<=? (make-date 2018 1 1) (make-date 2017 12 31)) false)
(check-expect (date<=? (make-date 2017 1 1) (make-date 2017 12 31)) true)
(check-expect (date<=? (make-date 2017 2 1) (make-date 2017 1 31)) false)
(check-expect (date<=? (make-date 2017 2 1) (make-date 2017 2 31)) true)
(check-expect (date<=? (make-date 2017 2 3) (make-date 2017 2 1)) false)
(check-expect (date<=? (make-date 2017 2 3) (make-date 2017 2 3)) true)

;; (approve? transact account) determines whether a transaction can be done
;; approve? Transaction Account -> bool

;; Example:
(check-expect (approve? (make-transaction (make-date 2018 1 1) 100 'bribe) (make-account "Ishan Sharma" (make-date 2011 1 1) 10 5 'food)) false)

(define (approve? transact account)
  (and (date<=? (transaction-tdate transact) (account-expires account))
       (>= (account-limit account) (transaction-amount transact))))

;; Tests
(check-expect (approve? (make-transaction (make-date 2010 1 1) 100 'bribe) (make-account "Ishan Sharma" (make-date 2011 1 1) 10 5 'food)) false)
(check-expect (approve? (make-transaction (make-date 2010 1 1) 100 'bribe) (make-account "Ishan Sharma" (make-date 2011 1 1) 10 5 'food)) false)
(check-expect (approve? (make-transaction (make-date 2010 1 1) 1 'bribe) (make-account "Ishan Sharma" (make-date 2011 1 1) 10 5 'food)) true)

;; (alert? transact account) determines whether the transaction will not throw an alert
;; alert?: Transaction Account -> Bool

;; Example:
(check-expect (alert? (make-transaction (make-date 2010 1 1) 6 'bribe) (make-account "Ishan Sharma" (make-date 2011 1 1) 10 5 'food)) true)

(define (alert? transact account)
  (and (not (symbol=? (transaction-category transact) (account-exception account)))
   (>= (transaction-amount transact) (account-threshold account))
   (approve? transact account)))

;; Tests:
(check-expect (alert? (make-transaction (make-date 2010 1 1) 100 'food) (make-account "Ishan Sharma" (make-date 2011 1 1) 10 5 'food)) false)
(check-expect (alert? (make-transaction (make-date 2010 1 1) 6 'food) (make-account "Ishan Sharma" (make-date 2011 1 1) 10 5 'food)) false)
(check-expect (alert? (make-transaction (make-date 2010 1 1) 100 'weed) (make-account "Ishan Sharma" (make-date 2011 1 1) 10 5 'food)) false)
