#lang racket
(provide (all-defined-out))
(require scribble/core scribble/html-properties scribble/manual) 

;(define prof1 (link "https://jmct.cc" "José Manuel Calderón Trilla"))
;(define prof1-pronouns "he/him")
;(define prof1-email "jmct@cs.umd.edu")
;(define prof1-initials "JMCT")

(define prof1 (link "https://www.cs.umd.edu/~anwar/" "Anwar Mamat"))
(define prof2 (link "https://www.cs.umd.edu/people/milijana" "Milijana Surbatovich"))
(define prof1-pronouns "he/him")
(define prof1-email "dvanhorn@cs.umd.edu")
(define prof1-initials "AM")

(define semester "spring")
(define year "2025")
(define courseno "CMSC 430")

(define lecture-dates "" #;"Jan 28 -- Dec 13, 2025")

(define IRB "IRB") 
(define AVW "AVW")
(define KEY "KEY")

(define office-hour-location (elem AVW " " "4122"))


(define m1-date "March 13")
(define m2-date "April 17")
(define midterm-hours "24")
(define final-date "Monday, May 19")
(define final-end-time "12:30PM")
(define elms-url "https://umd.instructure.com/courses/1368381")


(define racket-version "8.13")

(define staff
  (list (list "Pierce Darragh" "pdarragh@umd.edu")
        (list "Kalyan Bhetwal" "kbhetwal@umd.edu")
        ;(list "Justin Frank" "jpfrank@umd.edu")
	(list "Deena Postol" "dpostol@umd.edu")
        ;(list "Caspar Popova" "caspar@umd.edu")
        (list "Emma Shroyer" "eshroyer@umd.edu")
	;(list "Kazi Tasnim Zinat" "kzintas@umd.edu")

        ))


(define lecture-schedule1 "TTh, 2:00-3:15pm")

(define classroom1 "LEF 2205")

;(define discord "TBD")
(define piazza "https://piazza.com/umd/spring2025/cmsc430/home")
(define gradescope "https://www.gradescope.com/courses/963811")

(define feedback "https://forms.gle/A6U3CCR2KyA86UTh6")

(define (assign-deadline i)
  (list-ref '("Tuesday, September 10, 11:59PM"
              "Thursday, September 12, 11:59PM"
              "Thursday, October 3, 11:59PM"
              "Thursday, October 31, 11:59PM"
              "Tuesday, November 26, 11:59PM")            
            (sub1 i)))
