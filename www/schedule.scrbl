#lang scribble/manual
@(require scribble/core racket/list)
@(require "defns.rkt")

@title[#:style 'unnumbered]{Schedule}

@;(TuTh 9:30-10:45, IRB 0318)

@(define (wk d) (nonbreaking (bold d)))

@; for unreleased assignments, switch to seclink when ready to release
@(define (tbaseclink lnk txt) txt)

@(define (day s) @elem[s])


@;{ Fall }
@;{
@tabular[#:style 'boxed
         #:sep @hspace[1]
         #:row-properties '(bottom-border)
         (list (list @bold{Week}
                     @;bold{Due}
                     @bold{Tuesday}
                     @bold{Thursday})

               (list @wk{8/27}
                     #;""
                     @secref["Intro"]
                     @elem{@secref["OCaml to Racket"]})


               (list @wk{9/3}
                     @;seclink["Assignment 1"]{A1}
                     @elem{@secref["a86"]}
                     @elem{@secref["a86"]})

               (list @wk{9/10}
                     @;seclink["Assignment 2"]{A2}
                     @itemlist[@item{@secref["Abscond"]}
                                    @item{@secref["Blackmail"]}]
                     @itemlist[@item{@secref["Con"]}
                                    @item{@secref["Dupe"]}])

               (list @wk{9/17}
                     @;""
                     @secref["Dodger"]
                     @secref["Evildoer"])

               (list @wk{9/24}
                     @;elem{A3}
                     @;elem{@seclink["Assignment 2"]{A2}}
                     @secref["Evildoer"]
                     @secref{Extort})

               (list @wk{10/1}
                     @;""
                     @secref{Extort}
                     @secref{Fraud})

               (list @wk{10/8}
                     @;elem{A4}
                     @secref{Fraud}
                     @secref["Midterm_1"])

               (list @wk{10/15}
                     @;""
                     @secref{Fraud}
                     @secref{Hustle})
               (list @wk{10/22}
                     @;""
                     @secref{Hustle}
                     @secref{Hustle})

               (list @wk{10/22}
                     @;elem{A5}
                     @;elem{@seclink["Assignment 4"]{A4}}
                     @secref{Hoax}
                     @secref{Iniquity})

               (list @wk{10/29}
                     @;""
                     @secref{Iniquity}
                     @secref{Iniquity})


               (list @wk{11/5}
                     @;elem{A6}
                     @secref{Knock}
                     @secref["Midterm_2"])


               (list @wk{11/12}
                     @;""
                     @secref{Jig}
                     @secref{Loot})

               (list @wk{11/19}
                     @;elem{A7}
                     @;elem{@seclink["Assignment 5"]{A5}}
                     @secref{Loot}
                     @secref{Mug})

               (list @wk{11/26}
                     @;""
                     @secref{Neerdowell}
                     @elem{No class})

               (list @wk{12/3}
                     @;""
                     @secref{Outlaw}
                     @elem{@secref{Outlaw}, cont.})

               )]}

@;{ Spring }
@tabular[#:style 'boxed
         #:sep @hspace[1]
         #:row-properties '(bottom-border)
         (list (list @bold{Week} @bold{Date} @bold{Topic} @bold{Assignment Released})

               @; Week 1
               (list "Week 1"
                     @day{01/28}
                     @secref{Intro}
                     @seclink["Assignment 1"]{A1})
               (list ""
                     @day{01/30}
                     @secref["OCaml to Racket"]
                     "Quiz 1")

               @; Week 2
               (list "Week 2"
                     @day{02/04}
                     @secref["a86"]
                     "")
               (list ""
                     @day{02/06}
                     @secref["a86"]
                     @seclink["Assignment 1"]{A2})

               @; Week 3
               (list "Week 3"
                     @day{02/11}
                     @secref["Abscond"]
                     "Quzi 2")
                  (list ""
                     @day{02/13}
                     @secref["Blackmail"]
                     "Quiz 3")
              @; Week 4
               (list "Week 4"
                     @day{02/18}
                     @secref["Con"]
                     @seclink["Assignment 3"]{A3})
                  (list ""
                     @day{02/20}
                     @secref["Dupe"]
                     "")

              @; Week 5
               (list "Week 5"
                     @day{02/25}
                     @secref["Dodger"]
                     "Quiz 4")
                  (list ""
                     @day{02/27}
                     @secref["Evildoer"]
                     "")
            @; Week 6
               (list "Week 6"
                     @day{03/04}
                     @secref["Extort"]
                     "Quiz 5")
                  (list ""
                     @day{03/6}
                     @secref["Fraud"]
                     "Practice Midterm 1")
             @; Week 7
               (list "Week 7"
                     @day{03/11}
                     @secref["Fraud"]
                     "")
                  (list ""
                     @day{03/13}
                     @secref["Midterm_1"]
                     "")
             @; Week 8
               (list "Week 8"
                     @day{03/17-03/21}
                     "Spring Break"
                     "")
               )]
@;{
@tabular[#:style 'boxed
         #:sep @hspace[1]
         #:row-properties '(bottom-border)
         (list (list @bold{Date} @bold{Topic} @bold{Due})
               (list @day{5/30} @secref["Intro"] "")
               (list @day{5/31} @secref["OCaml to Racket"] "")
               (list @day{6/1}  @secref["a86"] "")
               (list @day{6/2}  @secref["Abscond"] @seclink["Assignment 1"]{A1})
               (list @day{6/5}  @itemlist[@item{@secref["Blackmail"]} @item{@secref["Con"]}] @seclink["Assignment 2"]{A2})
               (list @day{6/6}  @itemlist[@item{@secref["Dupe"]} @item{@secref{Dodger}}] "")
               (list @day{6/7}  @secref["Evildoer"] "")
               (list @day{6/8}  @secref["Extort"] "")
               (list @day{6/9}  @secref["Fraud"] "")
               (list @day{6/12} @secref["Hustle"] @seclink["Assignment 3"]{A3})
               (list @day{6/13} @secref["Hoax"] "")
               (list @day{6/14} "Midterm 1" @secref["Midterm_1"])
               (list @day{6/15} @secref["Iniquity"] "")
               (list @day{6/16} @elem{@secref["Iniquity"], cont.} "")
               (list @day{6/19} @elem{Juneteenth Holiday} "")
               (list @day{6/20} @secref["Jig"] @seclink["Assignment 4"]{A4})
               (list @day{6/21} @secref["Knock"] "")
               (list @day{6/22} @elem{@secref["Knock"], cont.} "")
               (list @day{6/23} @secref["Loot"] "")
               (list @day{6/26} @elem{@secref["Loot"], cont.} "")
               (list @day{6/27} @elem{GC} @seclink["Assignment 5"]{A5})
               (list @day{6/28} @secref["Mug"] "")
               (list @day{6/29} "Midterm 2" @secref["Midterm_2"])
               (list @day{6/30} @secref["Mountebank"] "")
               (list @day{7/3}  @secref["Neerdowell"] @seclink["Assignment 6"]{A6})
               (list @day{7/4} "Independence Day Holiday" "")
               (list @day{7/5} @secref["Outlaw"] "")
               (list @day{7/6} @elem{@secref["Outlaw"], cont.} "")
               (list @day{7/7} "Slack" @secref{Project})
               )
         ]
}

@bold{Final project assessment: @|final-date|.}
