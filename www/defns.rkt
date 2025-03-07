#lang racket
(provide (all-defined-out))
(require scribble/core scribble/html-properties scribble/manual)

(define prof1 (link "https://www.cs.umd.edu/~anwar/" "Anwar Mamat"))
(define prof1-pronouns "he/him")
(define prof1-email "anwar@umd.edu")
(define prof1-ohs (list (list "W 1:00-2:00pm" (link "https://umd.zoom.us/j/7932256846?omn=91816199279" "Zoom"))
                        (list "Th 4:00-5:00" "IRB 2248")))
(define prof1-initials "AM")

(define prof2 (link "https://www.cs.umd.edu/people/milijana" "Milijana Surbatovich"))
(define prof2-email "milijana@umd.edu")
(define prof2-pronouns "she/her")
(define prof2-ohs (list (list "F 10:00-11:00am" "IRB 5246")))
(define prof2-initials "MS")


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


(define racket-version "8.15")

(define staff
  (list (list "Pierce Darragh"     "pdarragh@umd.edu")
        (list "Deena Postol"       "dpostol@umd.edu")
        (list "Kalyan Bhetwal"     "kbhetwal@umd.edu")
        (list "Emma Shroyer"       "eshroyer@umd.edu")
        (list "Haohong (Peter) Li" "lih@umd.edu")
        (list "Samuel Badalov"     "sbadalov@terpmail.umd.edu")
        (list "Edward Feng"        "edwfeng@terpmail.umd.edu")
        (list "Eric McKinney"      "ericmckinney.md@gmail.com")
        (list "Sanchay Ravindiran" "sanchay@terpmail.umd.edu")
        ))

(define lecture-schedule1 "TTh, 2:00-3:15pm")
(define lecture-schedule2 "TTh, 3:30-4:45pm")

(define classroom1 "ESJ 2204")
(define classroom2 "IRB 0318")

;(define discord "TBD")
(define piazza "https://piazza.com/umd/spring2025/cmsc430/home")
(define gradescope "https://www.gradescope.com/courses/963811")

(define feedback "https://forms.gle/KQ2WQxSrDGurnzRf7")

(define (assign-deadline i)
  (list-ref '("Tuesday, February 11, 11:59PM"
              "Tuesday, February 18, 11:59PM"
              "Tuesday, March 4, 11:59PM"
              "Tuesday, April 8, 11:59PM"
              "Tuesday, April 22, 11:59PM")
            (sub1 i)))
