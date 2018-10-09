;;; Testing code for checking integrity of the notebook

; The tests to be checked need to be listed in tests.txt in the following format.
; 1. Every line must start with  R corresponding to a rule expression,
;                                M corresponding to an expression with expected output,
;                                E corresponding to an expected output for the expression defined in an immediate previous line with M,
;                                N corresponding to an expression with no expected output.
; 2. After the above symbol, a space (or any number of space) is required before writing rules or expression.
; 3. Every rule must have the label "lbl" for internal use.
; 4. Every rule must have ^keep function for testing the same rule with multiple inputs.
; 5. Every expression must be contained in a single line.

(use-modules (ice-9 textual-ports))
(use-modules (texinfo string-utils))

(use-modules (srfi srfi-64))
(use-modules (opencog)
             (opencog nlp)
             (opencog nlp relex2logic)
             (opencog openpsi)
             (opencog ghost)
             (opencog ghost procedures))

(define (test-func)
	(call-with-input-file "tests.txt"
		(lambda (port)
			(define num-rules 0)
      (define num-frules 0)
			(define num-M 0)
      (define num-fM 0)
      (define num-N 0)
      (define num-fN 0)
      (define num-skpln 0)
			(define rule "")
			(define rule-atom '())
      (define expected "")

			(while #t
				(let ((line (get-line port)) (type "") (res '()))
					(if (eof-object? line) (break))
					(set! line (string-trim line))
					(display (format #f "-> ~a\n"line))

					(set! type (string-ref line 0))
					(set! line (string-trim (substring line 1)))

					(cond
					((equal? type #\R)
						(begin
            (catch #t
              (lambda () (display (test-read-eval-string line)))
              (lambda (key . args)
                (display "\nERROR: possibly syntax error.\n")
                (set! num-frules (+ num-frules 1))
              )
            )
						(display "\n\n")
						(set! num-rules (+ num-rules 1))
						(set! rule line)
						))
					((equal? type #\M)
						(begin
						(set! num-M (+ num-M 1))

            ;;; CHECK FOR EXPECTED OUTPUT
            ; check if the next line begins with E and if it does compare the output of the line with M
            ; to this line and if it doesn't begin with N raise error and return the get-line position back again.
            (catch #t
              (lambda () (set! expected (string-trim (get-line port))))
              (lambda (key . args)
                (display "\nERROR: end of file") ; handles if M is the last statement in the file.
                (set! expected "non")
              )
            )

            (if (equal? (string-ref expected 0) #\E)
                (begin
                  (catch #t
                    (lambda ()
                      (set! expected (string-trim (substring expected 1)))
                      (test-equal (test-read-eval-string expected) (test-read-eval-string line)) ; "expected" is evaluated to obtain the actually expected list.
                      (display (test-read-eval-string expected))
                      (display "\n")
                      (display (center-string (string-upcase (object->string (test-result-kind ))) 24 #\< #\>))
                      (display "\n\n")
                    )
                    (lambda (key . args)
                      (display "\nERROR: possibly syntax error.\n")
                      (set! num-fM (+ num-fM 1))
                    )
                  )

                )
                (begin
                  (display "\nERROR: Missing Expected Statement\n")
                  (set! num-fM (+ num-fM 1))
                  (unread-string (string-append expected (string #\lf)) port) ;return the reading point one line back.
                )
            )
						)
          )

          ((equal? type #\E)
          (begin
						(display "\nERROR: Missing preceding match (M) statement \n       Skipped current line...\n")
						(set! num-skpln (+ num-skpln 1))
						)
          )

					((equal? type #\N) ; execute expressions like (define king "Minilik") which has no expected output.
						(begin
						(set! num-N (+ num-N 1))

            ;;;just execute the line and display it's execution response;;;
            (catch #t
              (lambda () (display (test-read-eval-string line)))
              (lambda (key . args)
                (display "\nERROR: possibly syntax error.\n")
                (set! num-fN (+ num-fN 1))
              )
            )
            (display "\n")
						)
          )

					(#t (begin
						(display "\nERROR: Error in test file format \n       Skipped current line...\n")
            (set! num-skpln (+ num-skpln 1))
						)
          )

					)
				)
			)

    (display (format #f "\n\n# of total executions: ~a\n" (+ num-rules num-M num-N)))
    (display (format #f "# of failed rule executions: ~a\n" num-frules))
    (display (format #f "# of failed non-rule executions: ~a\n" (+ num-fM num-fN)))
    (display (format #f "# of Skipped lines: ~a\n" num-skpln))
    (display (format #f "# of tested executions: ~a\n" (- num-M num-fM)))
		)
	)
)

(test-begin "on tests.txt")
(display "\n")
(test-func)
(test-end "on tests.txt")
