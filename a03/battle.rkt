;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname battle) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; **********************************************
;;  Ishan Sharma (20728279)
;;  CS 135 Fall 2017
;;  Assignment 3, Problem 4
;; **********************************************

(define-struct card (strength colour))
;; A Card is a (make-card Nat Sym)
;; requires: 1 <= strength <= 9
;; color is one of: â€™red â€™yellow â€™green â€™blue â€™purple â€™brown
(define-struct hand (c1 c2 c3))
;; A Hand is a (make-hand Card Card Card)


;; (colour? hand) determines if a hand is only a colour
;; colour?: Hand -> Bool

;; Example:
(check-expect (colour? (make-hand (make-card 1 'red) (make-card 5 'red) (make-card 9 'red))) true)

(define (colour? hand)
  (and (symbol=? (card-colour (hand-c1 hand)) (card-colour (hand-c2 hand))) (symbol=? (card-colour (hand-c2 hand)) (card-colour (hand-c3 hand)))))

;; (run? hand) determines whether a hand is only a run
;; run?: Hand -> Bool

;; Example:
(check-expect (run? (make-hand (make-card 2 'red) (make-card 3 'green) (make-card 4 'red))) true)

(define (run? hand)
  (or (= (card-strength (hand-c1 hand)) (+ (card-strength (hand-c2 hand)) 1) (+ (card-strength (hand-c3 hand)) 2))
      (= (card-strength (hand-c1 hand)) (+ (card-strength (hand-c3 hand)) 1) (+ (card-strength (hand-c2 hand)) 2))
      (= (card-strength (hand-c2 hand)) (+ (card-strength (hand-c1 hand)) 1) (+ (card-strength (hand-c3 hand)) 2))
      (= (card-strength (hand-c2 hand)) (+ (card-strength (hand-c3 hand)) 1) (+ (card-strength (hand-c1 hand)) 2))
      (= (card-strength (hand-c3 hand)) (+ (card-strength (hand-c1 hand)) 1) (+ (card-strength (hand-c2 hand)) 2))
      (= (card-strength (hand-c3 hand)) (+ (card-strength (hand-c2 hand)) 1) (+ (card-strength (hand-c1 hand)) 2))))

;; (three-of-a-kind? hand) determines whether a hand is three-of-a-kind
;; three-of-a-kind?: Hand -> bool

;; Example:
(check-expect (three-of-a-kind? (make-hand (make-card 2 'red) (make-card 2 'green) (make-card 2 'red))) true)

(define (three-of-a-kind? hand)
  (= (card-strength (hand-c1 hand)) (card-strength (hand-c2 hand)) (card-strength (hand-c3 hand))))

;; (summation hand) determines a hand's sum
;; summation: Hand -> Nat

;; Example:
(check-expect (summation (make-hand (make-card 1 'red) (make-card 3 'green) (make-card 4 'red))) 8)

(define (summation hand)
  (+ (card-strength (hand-c1 hand)) (card-strength (hand-c2 hand)) (card-strength (hand-c3 hand))))


;; (battle hand1 hand2) determines who wins a battle of Schotten Totten
;; battle: Hand Hand -> Sym
;; required: Sym is either 'player1 or 'player2

; Example:
(check-expect (battle (make-hand (make-card 1 'red) (make-card 2 'red) (make-card 3 'red))
                      (make-hand (make-card 1 'red) (make-card 9 'red) (make-card 3 'red))) 'player1)

(define (battle hand1 hand2)
  (cond
    [(and (colour? hand1) (run? hand1) (not (and (colour? hand2) (run? hand2)))) 'player1]
    [(and (colour? hand2) (run? hand2) (not (and (colour? hand1) (run? hand1)))) 'player2]
    [(and (three-of-a-kind? hand1) (not (three-of-a-kind? hand2))) 'player1]
    [(and (three-of-a-kind? hand2) (not (three-of-a-kind? hand1))) 'player2]
    [(and (colour? hand1) (not (colour? hand2))) 'player1]
    [(and (colour? hand2) (not (colour? hand1))) 'player2]
    [(and (run? hand1) (not (run? hand2))) 'player1]
    [(and (run? hand2) (not (run? hand1))) 'player2]
    [(>= (summation hand1) (summation hand2)) 'player1]
    [else 'player2]))

;; Tests:
(check-expect (battle (make-hand (make-card 1 'red) (make-card 9 'red) (make-card 3 'red))
                      (make-hand (make-card 1 'red) (make-card 2 'red) (make-card 3 'red))) 'player2)
(check-expect (battle (make-hand (make-card 1 'red) (make-card 1 'red) (make-card 1 'red))
                      (make-hand (make-card 1 'red) (make-card 2 'red) (make-card 4 'red))) 'player1)
(check-expect (battle (make-hand (make-card 1 'red) (make-card 2 'red) (make-card 4 'red))
                      (make-hand (make-card 1 'red) (make-card 1 'red) (make-card 1 'red))) 'player2)
(check-expect (battle (make-hand (make-card 4 'red) (make-card 2 'red) (make-card 1 'red))
                      (make-hand (make-card 1 'blue) (make-card 2 'red) (make-card 4 'red))) 'player1)
(check-expect (battle (make-hand (make-card 1 'blue) (make-card 2 'red) (make-card 4 'red))
                      (make-hand (make-card 4 'red) (make-card 2 'red) (make-card 1 'red))) 'player2)
(check-expect (battle (make-hand (make-card 3 'blue) (make-card 2 'red) (make-card 1 'red))
                      (make-hand (make-card 1 'blue) (make-card 2 'red) (make-card 4 'red))) 'player1)
(check-expect (battle (make-hand (make-card 1 'blue) (make-card 2 'red) (make-card 4 'red))
                      (make-hand (make-card 3 'blue) (make-card 2 'red) (make-card 1 'red))) 'player2)
(check-expect (battle (make-hand (make-card 3 'blue) (make-card 2 'red) (make-card 5 'red))
                      (make-hand (make-card 1 'blue) (make-card 2 'red) (make-card 2 'red))) 'player1)
(check-expect (battle (make-hand (make-card 1 'blue) (make-card 2 'red) (make-card 2 'red))
                      (make-hand (make-card 1 'blue) (make-card 2 'red) (make-card 2 'red))) 'player1)
(check-expect (battle (make-hand (make-card 1 'blue) (make-card 2 'red) (make-card 2 'red))
                      (make-hand (make-card 3 'blue) (make-card 2 'red) (make-card 5 'red))) 'player2)
