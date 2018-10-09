; loading srfi-64 module
(use-modules (srfi srfi-64))
; loading opencog modules
(use-modules (ice-9 readline)) (activate-readline)
(add-to-load-path "/usr/local/share/opencog/scm")
(add-to-load-path ".")
(use-modules (opencog)
	     (opencog query)
	     (opencog exec)
             (opencog nlp)
             (opencog nlp relex2logic)
             (opencog openpsi)
             (opencog ghost)
             (opencog ghost procedures))

; starting the test
(test-begin "OpenCog_GHOST_test")

(ghost-parse "u: (hello) hello there! ^keep")
(test-equal `() (test-ghost "hi"))
(test-equal (list (WordNode "hello") (WordNode "there") (WordNode "!")) (test-ghost "hello"))
(test-equal (list "hello" "there" "!") (map cog-name (test-ghost "hello")))
;;;;;;; on trial ;;;;;;;;;;

; first hand on ghost
;(ghost-parse "u: (hello) hello there!")
;(test-equal (list (WordNode "hello") (WordNode "there") (WordNode "!")) (test-ghost "hello"))
;(test-equal (list "hello" "there" "!") (map cog-name (test-ghost "hello")))
;(test-equal `() (test-ghost "hi"))

; test on rules with the same pattern but different goal strength. The one with the higher goal strength will be selected (in ourcase, the 0.5 one will be selected). This test can also be a test for the tests "first hand on ghost", "GOAL".
(ghost-parse "#goal: (goal1=0.5) u: (hi) hi there ^keep")
(ghost-parse "#goal: (goal1=0.7) u: (hi) hello there ^keep")
(test-equal (list (WordNode "hi") (WordNode "there")) (test-ghost "hi"))

; the next test can fail since the numbers included can change on run time.
(ghost-parse "u: lbl (ghost) Ghost is a behavior scripting tool ^keep")
(test-equal (ImplicationLink (stv 0.9 0.9)
   (AndLink
      (SatisfactionLink
         (VariableList
            (TypedVariableLink
               (GlobNode "wildcard-$688035174194-EIhTeyGZBhG2M3qnLRBah9tp")
               (TypeSetLink
                  (TypeNode "WordNode")
                  (IntervalLink
                     (NumberNode "0.000000")
                     (NumberNode "-1.000000")
                  )
               )
            )
            (TypedVariableLink
               (GlobNode "wildcard-$688035218697-GJv7NnXNhOFCWrP1yJ7IJGY7")
               (TypeSetLink
                  (TypeNode "WordNode")
                  (IntervalLink
                     (NumberNode "0.000000")
                     (NumberNode "-1.000000")
                  )
               )
            )
            (TypedVariableLink
               (VariableNode "ghost-$688035412922-SNgoMycf2OZ32MePd0E16iYB")
               (TypeNode "WordNode")
            )
            (TypedVariableLink
               (VariableNode "ghost-$688035450765-SYNSXfzCALDL1w6QlFChtHYG")
               (TypeNode "WordInstanceNode")
            )
            (TypedVariableLink
               (GlobNode "wildcard-$688035540802-dMMSaZrBoex0RHnTPt9ho9Cv")
               (TypeSetLink
                  (TypeNode "WordNode")
                  (IntervalLink
                     (NumberNode "0.000000")
                     (NumberNode "-1.000000")
                  )
               )
            )
            (TypedVariableLink
               (GlobNode "wildcard-$688035569933-8vQGsMJcfnYDAO6rI3LwkAWs")
               (TypeSetLink
                  (TypeNode "WordNode")
                  (IntervalLink
                     (NumberNode "0.000000")
                     (NumberNode "-1.000000")
                  )
               )
            )
            (TypedVariableLink
               (VariableNode "$S")
               (TypeNode "SentenceNode")
            )
            (TypedVariableLink
               (VariableNode "$P")
               (TypeNode "ParseNode")
            )
         )
         (AndLink
            (WordInstanceLink
               (VariableNode "ghost-$688035450765-SYNSXfzCALDL1w6QlFChtHYG")
               (VariableNode "$P")
            )
            (EvaluationLink
               (GroundedPredicateNode "scm: ghost-lemma?")
               (ListLink
                  (VariableNode "ghost-$688035412922-SNgoMycf2OZ32MePd0E16iYB")
                  (WordNode "ghost")
               )
            )
            (EvaluationLink
               (PredicateNode "GHOST Lemma Sequence")
               (ListLink
                  (VariableNode "$S")
                  (ListLink
                     (GlobNode "wildcard-$688035218697-GJv7NnXNhOFCWrP1yJ7IJGY7")
                     (WordNode "ghost")
                     (GlobNode "wildcard-$688035569933-8vQGsMJcfnYDAO6rI3LwkAWs")
                  )
               )
            )
            (ParseLink
               (VariableNode "$P")
               (VariableNode "$S")
            )
            (ReferenceLink
               (VariableNode "ghost-$688035450765-SYNSXfzCALDL1w6QlFChtHYG")
               (VariableNode "ghost-$688035412922-SNgoMycf2OZ32MePd0E16iYB")
            )
            (EvaluationLink
               (PredicateNode "GHOST Word Sequence")
               (ListLink
                  (VariableNode "$S")
                  (ListLink
                     (GlobNode "wildcard-$688035174194-EIhTeyGZBhG2M3qnLRBah9tp")
                     (VariableNode "ghost-$688035412922-SNgoMycf2OZ32MePd0E16iYB")
                     (GlobNode "wildcard-$688035540802-dMMSaZrBoex0RHnTPt9ho9Cv")
                  )
               )
            )
            (StateLink
               (AnchorNode "GHOST Currently Processing")
               (VariableNode "$S")
            )
         )
      )
      (TrueLink
         (ExecutionOutputLink
            (GroundedSchemaNode "scm: ghost-execute-action")
            (ListLink
               (WordNode "Ghost")
               (WordNode "is")
               (WordNode "a")
               (WordNode "behavior")
               (WordNode "scripting")
               (WordNode "tool")
            )
         )
         (PutLink
            (StateLink
               (AnchorNode "GHOST Last Executed")
               (VariableNode "$x")
            )
            (ConceptNode "lbl")
         )
         (ExecutionOutputLink
            (GroundedSchemaNode "scm: ghost-record-executed-rule")
            (ListLink
               (ConceptNode "lbl")
            )
         )
         (PutLink
            (StateLink
               (AnchorNode "GHOST Current Topic")
               (VariableNode "$x")
            )
            (ConceptNode "GHOST Default Topic")
         )
      )
   )
   (ConceptNode "GHOST Default Goal")
) (ghost-get-rule "lbl"))
;;; GOAL
; Top level GOAL
(ghost-parse "goal: (please_user=0.8)")
(ghost-parse "u: lbl1 (hello) Hello sweet wonderful human")
(ghost-parse "u: lbl2 (what are you doing) Chating with you")
(ghost-parse "u: lbl3 (how do you know to caht) I learned it from you humans")
; test if the three rules have the same goal and strength
(test-equal (stv 0.800000 0.900000) (ghost-rule-tv "lbl1"))
(test-equal (stv 0.800000 0.900000) (ghost-rule-tv "lbl2"))
(test-equal (stv 0.800000 0.900000) (ghost-rule-tv "lbl3"))
; ordered-goal
(ghost-parse "ordered-goal: (please_user=0.6)")
(ghost-parse "u: lbl4 (selam) selam! How are you")
(ghost-parse "u: lbl5 (hi) hi! How are you doing")
; test if the relationship between the order and the weight forms a geometric sequence with a factor of half.
(test-equal (stv 0.300000 0.900000) (ghost-rule-tv "lbl4"))
(test-equal (stv 0.150000 0.900000) (ghost-rule-tv "lbl5"))
; Rule level GOAL (jumped)
;;; Lemma
; test on rules with words in canonical form.
(ghost-parse "u: (dog) I have a cat ^keep")
(test-equal (list "I" "have" "a" "cat") (map cog-name (test-ghost "I like dogs")))
(test-equal (list "I" "have" "a" "cat") (map cog-name (test-ghost "I like dog")))
; test on rules with words in non-canonical form.
(ghost-parse "u: (cats) I have a dog ^keep")
(test-equal (list "I" "have" "a" "dog") (map cog-name (test-ghost "I like cats")))
(test-equal `() (map cog-name (test-ghost "I like cat")))
; test on rules with verbs in canonical form.
(ghost-parse "u: (what be *1) I don't know ^keep")
(test-equal (list "I" "don't" "know") (map cog-name (test-ghost "What is it?")))
(test-equal (list "I" "don't" "know") (map cog-name (test-ghost "What are you?")))
(test-equal (list "I" "don't" "know") (map cog-name (test-ghost "What am I?")))
;;; PHRASE and CHOICE
(ghost-parse "u: (you [eat ingest \"binge and purge\" (feed my face ) ] meat) I love meat ^keep")
(test-equal (list "I" "love" "meat") (map cog-name (test-ghost "do you feed my face meat")))
(test-equal (list "I" "love" "meat") (map cog-name (test-ghost "do you binge and purge meat")))
(test-equal (list "I" "love" "meat") (map cog-name (test-ghost "do you eat meat")))
;;; CONCEPT
(ghost-parse "concept: ~eat [eat ingest \"binge and purge\"]")
(ghost-parse "u: (I ~eat meat) Do you really? I am a vegan. ^keep")
(test-equal (list "Do" "you" "really" "?" "I" "am" "a" "vegan" ".") (map cog-name (test-ghost "I ingest meat")))
(test-equal (list "Do" "you" "really" "?" "I" "am" "a" "vegan" ".") (map cog-name (test-ghost "I eat meat")))
(test-equal (list "Do" "you" "really" "?" "I" "am" "a" "vegan" ".") (map cog-name (test-ghost "I binge and purge meat")))

;;; OPTIONAL
(ghost-parse "u: (define {word concept} hate) Sorry. I don't know it. ^keep")
(test-equal (list "Sorry" "." "I" "don't" "know" "it" ".") (map cog-name (test-ghost "define word hate")))
(test-equal (list "Sorry" "." "I" "don't" "know" "it" ".") (map cog-name (test-ghost "define concept hate")))
(test-equal (list "Sorry" "." "I" "don't" "know" "it" ".") (map cog-name (test-ghost "define hate")))

(ghost-parse "u: ( define { \"the word\" (the meaning of) } love ) Sorry. I don’t know it. ^keep")
(test-equal (list "Sorry" "." "I" "don’t" "know" "it" ".") (map cog-name (test-ghost "define the word love")))
(test-equal (list "Sorry" "." "I" "don’t" "know" "it" ".") (map cog-name (test-ghost "define the meaning of love")))
(test-equal (list "Sorry" "." "I" "don’t" "know" "it" ".") (map cog-name (test-ghost "define love")))

;;; INDEFININTE WILDCARD
(ghost-parse "u: (when * you * home) I go home tomorrow ^keep")
(test-equal (list "I" "go" "home" "tomorrow") (map cog-name (test-ghost "When will you go home")))
(test-equal (list "I" "go" "home" "tomorrow") (map cog-name (test-ghost "When Roger is with you, will there be anyone at home?")))
(test-equal (list "I" "go" "home" "tomorrow") (map cog-name (test-ghost "When you home?")))

;;; PRECISE WILDCARD
(ghost-parse "u: (when *1 you go to school) I went to school yesterday ^keep")
(test-equal (list "I" "went" "to" "school" "yesterday") (map cog-name (test-ghost "When did you go to school?")))
; test failure on precise wildcard
(test-equal `() (map cog-name (test-ghost "When and why you go to school?")))
(test-equal `() (map cog-name (test-ghost "When you go to school?")))

;;;  RANGE-RESTRICTED WILDCARD
(ghost-parse "u: (you *~2 go *~2 gym) I often go to that gym. ^keep")
(test-equal (list "I" "often" "go" "to" "that" "gym" ".") (map cog-name (test-ghost "You can go to gym")))
(test-equal (list "I" "often" "go" "to" "that" "gym" ".") (map cog-name (test-ghost "You should not go to gym")))
(test-equal (list "I" "often" "go" "to" "that" "gym" ".") (map cog-name (test-ghost "You go gym")))
; test failure on range-restricted wildcard
(test-equal `() (map cog-name (test-ghost "You be ready to go to gym")))

;;; MATCH VARIABLE
(ghost-parse "u: ( do you eat _* ) No, I hate '_0. ^keep")
(test-equal (list "No" "," "I" "hate" "beef" ".")(map cog-name (test-ghost "do you eat beef")))
; test _0 returns canoncal form of the matching word
(ghost-parse "u: ( do you like _* ) I eat _0.")
(test-equal (list "I" "eat" "cake" ".") (map cog-name (test-ghost "do you like cakes")))
; test with multiple match variables
(ghost-parse "u: ( do you love _* or _* ) I don’t like '_0 so I guess that means I prefer '_1.")
(test-equal (list "I" "don’t" "like" "tea" "so" "I" "guess" "that" "means" "I" "prefer" "coffee" ".") (map cog-name (test-ghost "do you love tea or coffee")))

;;; USER VARIABLE
(ghost-parse "u: ( I eat _*1 ) $food = '_0 I eat oysters.")
(map cog-name (test-ghost "I eat bread"))
(ghost-parse "u: (what do I eat) You eat $food ^keep")
(test-equal (list "You" "eat" "bread") (map cog-name (test-ghost "what do I eat")))

;;; SENTENCE BOUNDARY
; test on matching end of sentence
(ghost-parse "u: lblelephant (what is an elephant > ) An elephant is a pachyderm. ^keep")
(test-equal (list "An" "elephant" "is" "a" "pachyderm" ".") (map cog-name (test-ghost "Tell me what is an elephant")))
; test on matching end of sentence and a must be included word.
(ghost-parse "u: ( Aksum obelisk > find ) In northern Ethiopia. ^keep")
(test-equal (list "In" "northern" "Ethiopia" ".") (map cog-name (test-ghost "Where can i find the aksum obelisk.")))
; test on matching begining of sentence
(ghost-parse "u: (< I am not ) me too. ^keep")
(test-equal (list "me" "too" ".") (map cog-name (test-ghost "I am not ready for the match but am not afraid.")))
; test on matching begining of sentence and a must be included word.
(ghost-parse "u: ( dream < I have ) I have dreams too. ^keep")
(test-equal (list "I" "have" "dreams" "too" ".") (map cog-name (test-ghost "I have dream to change the world")))

;;; NEGATION
(ghost-parse "u: ( ![ not never rarely ] I * eat meat ) You eat meat. ^keep")
(test-equal (list "You" "eat" "meat" ".") (map cog-name (test-ghost "I eat meat" )))
(test-equal `() (map cog-name (test-ghost "I never eat meat" )))

;;; UNORDERED MATCHING
(ghost-parse "u: ( << I birds love >> ) I love birds too. ^keep")
(test-equal (list "I" "love" "birds" "too" ".") (map cog-name (test-ghost "Birds are what I really love")))

;;; REJOINDER
(ghost-parse "u: (do you have a cake) yes do you want some? a: (yes) here you go. a: (no) your loss. ^keep")
; test the responce for "yes"
(test-equal (list "yes" "do" "you" "want" "some" "?") (map cog-name (test-ghost "do you have a cake")))
(test-equal (list "here" "you" "go" ".") (map cog-name (test-ghost "yes")))
; test the responce for "no"
(test-equal (list "yes" "do" "you" "want" "some" "?") (map cog-name (test-ghost "do you have a cake")))
(test-equal (list "your" "loss" ".") (map cog-name (test-ghost "no")))

;;; FUNCTIONS
; test assuming that ^reuse adds two empty double quotes (i.e "") at the end of the reused ruel's response.
(ghost-parse "u: (do you know about elephant) ^reuse(lblelephant) ^keep")
(test-equal (list "An" "elephant" "is" "a" "pachyderm" "." "" "") (map cog-name (test-ghost "what do you know about elephant")))

; end of test
(test-end "OpenCog_GHOST_test")
(display "!!!!!!TEST COMPLETED!!!!!!\n") 
