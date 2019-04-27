;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "beginner-reader.rkt" "deinprogramm" "sdp")((modname dillo) (read-case-sensitive #f) (teachpacks ()) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ())))
; Ein Gürteltier hat folgende Eigenschaften:
; - Gewicht (in g)
; - lebendig oder tot
(define-record-functions dillo
  make-dillo
  (dillo-weight natural)
  (dillo-alive? boolean))

(: make-dillo (natural boolean -> dillo))
(: dillo-weight (dillo -> natural))
(: dillo-alive? (dillo -> boolean))

(define d1 (make-dillo 55000 #t)) ; 55 kg, lebendig 
(define d2 (make-dillo 58000 #f)) ; 58 kg, tot
(define d3 (make-dillo 60000 #t)) ; 60 kg, lebendig
(define d4 (make-dillo 63000 #f)) ; 63 kg, tot

; Gürteltier mit 500g Futter füttern
(: feed-dillo (dillo -> dillo))

(check-expect (feed-dillo d1) (make-dillo 55500 #t))
(check-expect (feed-dillo d2) d2)

#;(define feed-dillo
  (lambda (d)
    (if (dillo-alive? d)
        (make-dillo (+ (dillo-weight d) 500)
                    #t)
        d)))

(define feed-dillo
  (lambda (d)
    (make-dillo (if (dillo-alive? d)
                    (+ (dillo-weight d) 500)
                    (dillo-weight d))
                (dillo-alive? d))))


; Gürteltier überfahren
(: run-over-dillo (dillo -> dillo))

(check-expect (run-over-dillo d1) (make-dillo 55000 #f))
(check-expect (run-over-dillo d2) d2)
(check-expect (run-over-dillo d2) d2)

(define run-over-dillo
  (lambda (d)
    (make-dillo (dillo-weight d)
                #f)))