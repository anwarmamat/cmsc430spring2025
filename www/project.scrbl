#lang scribble/manual
@(require "defns.rkt"
          "notes/ev.rkt"
          racket/runtime-path
          (for-label (except-in racket compile ...) a86))

@title[#:tag "Project" #:style '(unnumbered)]{Project}

The final assessment for this course consists of an individually completed
project that is split into two parts: implementing some extensions to functions
(worth 40% of the final project grade) and implementing the new features of
exceptions and exception handling (worth 60% of the final project grade).

We will provide you with more detailed instructions and starter code for the
function extension part, while purposefully having higher-level instructions and
minimal starter code for the exception handling part. This decision is
purposeful, to give @bold{you} the opportunity to exercise your compiler design
chops and good judgment.

The starter code, which is based on Loot, is available on ELMS in the Final
Project assignment text. Note that you do not need to bring forward features
from past assignments, and in most cases we have already provided the necessary
AST and parser code with a matching interpreter so you can focus on implementing
the compiler.

Please be sure to read the entire problem description before starting. We've
included a number of @secref[#:tag-prefixes '("proj-") "suggestions"] on how to
approach the assignment near the end.

@bold{Due: @final-date, @final-end-time}


@section[#:style 'unnumbered]{Arity Checking, Rest Arguments, and Apply}

@(define-runtime-path loot-plus "loot-plus/")

@(ev `(current-directory ,loot-plus))
@(for-each (λ (f) (ev `(require (file ,f))))
           '("ast.rkt" "parse.rkt" "interp.rkt"))

This part of the project asks you to extend a modified Loot compiler with the
following features:

@itemlist[

 @item{Run-time arity checking for function calls (i.e., raising a error when a
  function is called with an incompatible number of arguments).}

 @item{Variadic (variable-arity) functions using a ``rest parameter''.}

 @item{The @racket[apply] function, which allows for applying a function to a
  dynamically computed list of arguments.}

 ]


@subsection[#:tag-prefix "proj-" #:style 'unnumbered #:tag "arity"]{Checking arity}

In @seclink["Iniquity"]{Iniquity}, we implemented a language with function
definitions and calls. We noted that bad things can happen when a function is
called with the incorrect number of arguments. While it's possible to statically
check this property of Iniquity programs, it's not possible in more expressive
languages, so arity checking must be done at run-time. You are tasked with
implementing such a run-time arity checking mechanism.

Here is the basic idea: You need to add a run-time checking mechanism that will
cause the following program to signal an error:

@#reader scribble/comment-reader
(racketblock
(define (f x y) (+ x y))
(f 1))

The function call knows how many arguments are given, and the function
definition knows how many arguments are expected. The generated code should
check that these two quantities match when the function call is executed.

A simple way to do this is to pick a designated register that will be used for
communicating arity information. The caller should set the register to the
number of arguments before jumping to the function. The function should check
this number against the expected number and signal an error when they don't
match.

Since we're using @seclink["Loot"]{Loot} for this project, there are two places
to update the caller code: @racket[compile-app-tail] and
@racket[compile-app-nontail]. These two functions are responsible for generating
the jumps into a function body, so these are where we will update our designated
arity checking register with the number of arguments received at run-time.

The function body definition will also need to be updated. In Loot, this will be
done in @racket[compile-lambda-define].

No changes need to be made to the parser, and the interpreter has been updated
to perform arity checking; you only need to make changes in the compiler. We
have left @tt{TODO} comments for you in the places where you need to make
changes. (You are allowed to make other changes if you see fit.)


@subsection[#:tag-prefix "proj-" #:style 'unnumbered #:tag "rest"]{Variadic functions}

Many programming languages, such as JavaScript, C, and Racket, provide
facilities for defining functions that take a variable number of arguments, also
called ``variadic functions''. Most commonly, this is implemented by somehow
distinguishing the final parameter in the function's parameter list. When the
function is called, the normal parameters are bound in the normal way, but all
the additional arguments beyond those necessary for binding the normal
parameters are bound to the distinguished parameter as some kind of collection
that can be used as a single value within the body of the function. We will
follow Racket's example and use a list to accumulate these values.

Here are some examples:

@itemlist[

 @item{The function @racket[(define (f . xs) ...)] takes @emph{any} number of
  arguments and binds @racket[xs] toa list containing all of them.}

 @item{The function @racket[(define (f x . xs) ...)] takes @emph{at least} one
  argument, binding @racket[x] to the first argument and @racket[xs] to a list
  containing the rest. It's an error to call this function with zero arguments.}

 @item{The function @racket[(define (f x y z . xs) ...)] takes @emph{at least}
  three arguments, binding @racket[x], @racket[y], and @racket[z] to the first
  three arguments and @racket[xs] to a list containing the rest. It's an error
  to call this function with 0, 1, or 2 arguments.}

 ]

Here are some examples using these function templates in Racket to get a sense
of the behavior:

@ex[
 (define (f . xs) (list xs))
 (f)
 (f 1)
 (f 1 2)
 (f 1 2 3)
 (f 1 2 3 4)
 (define (f x . xs) (list x xs))
 (eval:error (f))
 (f 1)
 (f 1 2)
 (f 1 2 3)
 (f 1 2 3 4)
 (define (f x y z . xs) (list x y z xs))
 (eval:error (f))
 (eval:error (f 1))
 (eval:error (f 1 2))
 (f 1 2 3)
 (f 1 2 4)
 ]

The code generated for a function @emph{call} should not change, aside from what
you did for @secref[#:tag-prefixes '("proj-") "arity"]: it should pass all of
the arguments on the stack along with information about the number of arguments.

The compilation of function @emph{definitions} for variadic functions should
generate code that checks that the given number of arguments is acceptable and
should generate code to pop all ``extra'' arguments off the stack and construct
a @emph{list} from them, binding that list to the rest parameter.

It is worth remembering that arguments are pushed on the stack in such a way
that the @emph{last} argument is the element most recently pushed onto the stack
(i.e., it's ``on top'' of the stack). This has the benefit of making it easy to
pop off the extra arguments and to construct a list with the elements in the
proper order.

@bold{HINT:} The function definition knows the number of ``required'' arguments,
i.e., the minimum number of arguments the function can be called with --- call
this @math{m} --- and the caller communicates how many arguments have actually
been supplied --- call this @math{n}. The compiler needs to generate a loop that
pops @math{n - m} times, constructing a list with the popped elements, and then
finally pushes the resulting list onto the stack to bind it to the rest
parameter.

The parser and interpreter have been updated with these changes; you only need
to implement the changes in the compiler. We have left @tt{TODO} comments for
you in the places where you need to make changes. (You are allowed to make other
changes if you see fit.)


@subsection[#:tag-prefix "proj-" #:style 'unnumbered #:tag "apply"]{Apply}

Dynamic function application is the yin to the yang of variadic functions (or
maybe it's the other way around). Whereas a rest parameter lets a function take
arbitrarily many ``extra'' arguments and packages them as a list, @racket[apply]
will apply a function @emph{to} a list as though the elements of the list were
given as arguments normally.

@ex[
 (define (f x y) (+ x y))
 (apply f (list 1 2))
 (define (flatten ls)
   (apply append ls))
 (flatten (list (list 1 2) (list 3 4 5) (list 6)))
 (define (sum ls)
   (apply + ls))
 (sum (list 5 6 7 8))
 ]

In these examples, you can see @racket[apply] taking two things: a function, and
a single argument, which is a list. The @racket[apply] function is calling the
given function, using the elements in the list as the arguments.

As it turns out, @racket[apply] can also take additional arguments in addition
to the list, and it passes them along to the function being called as well:

@ex[
 (define (f x y) (+ x y))
 (apply f 1 (list 2))
 (apply list 1 2 3 4 (list 5 6 7))
 ]

Note that if the function expects a certain number of arguments and the list has
a different number of elements, it results in an arity error:

@ex[
 (define (f x y) (+ x y))
 (eval:error (apply f (list 1 2 3)))
 ]

The concrete syntax for an @racket[apply] expression is:

@#reader scribble/comment-reader
(racketblock
(apply _ef _e0 ... _en)
)

Note that an @racket[apply] expression consists of two or more sub-expressions.
The first sub-expression @racket[_ef] must evaluate to a function, and the final
sub-expression @racket[_en] must evaluate to a list (it is an error if it
evaluates to anything other than a list). Any additional sub-expressions
@racket[_e0 ...] can evaluate to anything at all.

While it's allowable to have only the function and the list argument, it's a
syntax error to leave off a list argument altogether:

@ex[
 (parse-e '(apply f xs))
 (parse-e '(apply f))
 ]

(Note that the second example above returns an @racket[App] AST node rather than
an @racket[Apply] node, meaning that unless the user has defined a function that
is named @tt{apply}, this code will fail at compile-time due to generating a
reference to an undeclared label. It does not literally raise an error in
Racket, although it would in a more advanced parser.)

The interpreter has been updated to handle all of this already:

@ex[
 (interp (parse '(define (f x y) (cons y x))
                '(apply f (cons 1 (cons 2 '())))))
 ]

When used with variadic functions, @racket[apply] makes it possible to write
many functions you may like to use:

@#reader scribble/comment-reader
(ex
(interp
  (parse
    ;; an append that works on any number of lists
    '(define (append . xss)
       (if (empty? xss)
           '()
           (if (empty? (car xss))
               (apply append (cdr xss))
               (cons (car (car xss))
                     (apply append (cdr (car xss)) (cdr xss))))))
    ;; the list function!
    '(define (list . xs) xs)

    '(append (list 1 2 3) (list 4) (list 5 6 7)))))

In @tt{compile.rkt}, the @racket[compile-e] function now has an added case for
@racket[Apply] AST nodes that calls @racket[compile-apply]. Your job is to
complete the implementation of @racket[compile-apply] in accordance with the
above specification.

@bold{HINT:} The @racket[apply] function is @emph{very} similar to a normal
function call, but with some changes. The implementation should:

@itemlist[

 @item{Generate a label for the return point and push that onto the stack.}

 @item{Evaluate the first argument @racket[_ef] and check that it evaluates to a
  procedure.}

 @item{Evaluate the regular arguments @racket[_e0 ...] and push them onto the
 stack.}

 @item{Evaluate the list argument @racket[_en], and then traverse the list at
 run-time, pushing the elements onto the stack until the end of the list is
 reached.}

 @item{Execute the function in the first argument.}

]


@section[#:tag-prefix "proj-" #:style 'unnumbered #:tag "exceptions"]{Exceptions and Exception Handling}

Exceptions and exception handling mechanisms are widely used in modern
programming languages. Implement Racket’s @racket[raise] and
@racket[with-handlers] forms to add exception handling.

Here are the key features that need to be added:

@itemlist[

 @item{@racket[(raise _e)] will evaluate @racket[_e] and then ``raise'' the
 value, side-stepping the usual flow of control and instead jumping to the most
 recently installed compatible exception handler.}

 @item{@racket[(with-handlers ([_p1 _f1] ...) _e)] will install a new exception
  handler during the evaluation of @racket[_e]. If @racket[_e] raises an
  exception that is not caught, the predicates @racket[_p1 ...] should be
  applied to the raised value until finding the first @racket[_pi] that returns
  a true value, at which point the corresponding function @racket[_fi] is called
  with the raised value and the result of that application is the result of the
  entire with-handlers expression. If @racket[_e] does not raise an error, its
  value becomes the value of the with-handler expression.}

 ]

Here are some examples to help illustrate:

@ex[
(with-handlers ([string? (λ (s) (cons "got" s))])
  (raise "a string!"))

(with-handlers ([string? (λ (s) (cons "got" s))]
                [number? (λ (n) (+ n n))])
  (raise 10))

(with-handlers ([string? (λ (s) (cons "got" s))]
                [number? (λ (n) (+ n n))])
  (+ (raise 10) 30))

(let ((f (λ (x) (raise 10))))
  (with-handlers ([string? (λ (s) (cons "got" s))]
                  [number? (λ (n) (+ n n))])
    (+ (f 10) 30)))

(with-handlers ([string? (λ (s) (cons "got" s))]
                [number? (λ (n) (+ n n))])
  'nothing-bad-happens)

(with-handlers ([symbol? (λ (s) (cons 'reraised s))])
  (with-handlers ([string? (λ (s) (cons "got" s))]
                  [number? (λ (n) (+ n n))])
    (raise 'not-handled-by-inner-handler)))
 ]

Notice that when a value is raised, the enclosing context is discarded. In the
third example, the surrounding @racket[(+ [] 30)] part is ignored and instead
the raised value, @racket[10], is given the exception handler predicates,
selecting the appropriate handler.

Thinking about the implementation, what this means is that a portion of the
stack needs to be discarded --- namely, the area between the current top of the
stack and the stack that was in place when the @racket[with-handlers] expression
was evaluated.

This suggests that a @racket[with-handlers] expression should stash away the
current value of @racket['rsp]. When a @racket[raise] happens, it grabs the
stashed away value and installs it as the current value of @racket['rsp],
effectively rolling back the stack to its state at the point at which the
exception handler was installed. It should then jump to code that will carry out
the applying of the predicates and right-hand-side functions.

Since @racket[with-handlers] can be nested, you will need to maintain an
arbitrarily large collection of exception handlers, each of which has a pointer
into the stack and a label for the code to handle the exception. This collection
should operate like a stack: each @racket[with-handlers] expression adds a new
handler to the handler stack. If the body expression returns normally, the
top-most handler should be removed. When a @racket[raise] happens, the top-most
handler is popped and used.

@bold{HINT:} Go slowly --- these features are tricky to implement. We have
provided some small stubs, but it's not much. In @racket[compile-with-handlers],
you should evaluate and set up the predicate-handler pairs and then execute the
body. In @racket[compile-raise], you should handle the process of looking
through the available handlers (in the proper order!) to see if one matches your
raised value and, if it does, executing the corresponding handler function.


@section[#:tag-prefix "proj-" #:style 'unnumbered #:tag "starter-code"]{Starter code changes}

@emph{We have updated the base Loot AST and parser for you.} Some of these
changes might be challenging to understand at first glance, so here is a brief
summary of those changes with some rationale.

@bold{Arity checking} does not require any changes in the AST or parser --- it's
entirely implemented in the interpreter and compiler.

@bold{Variadic functions} require a new function form that uses the special dot
notation to distinguish the ``rest parameter'' from the others. To handle this,
and to make distinguishing the different functions easier, we now have
@emph{two} top-level function definition forms and @emph{two} lambda forms in
the AST:

@#reader scribble/comment-reader
(racketblock
;; type Defn = (Defn Id Fun)
(struct Defn (f fun) #:prefab)

;; type Fun = (FunPlain [Listof Id] Expr)
;;          | (FunRest [Listof Id] Id Expr)
(struct FunPlain (xs e)   #:prefab)
(struct FunRest  (xs x e) #:prefab)

;; type Expr = ...
;;           | (LamPlain Id (Listof Id) Expr)
;;           | (LamRest Id (Listof Id) Id Expr)
...
(struct LamPlain (f xs e) #:prefab)
(struct LamRest (f xs x e) #:prefab)
)

What used to be represented as @racket[(Defn _f _xs _e)] is now represented as
@racket[(Defn _f (FunPlain _xs _e))]. Similarly, what used to be represented as
@racket[(Lam _f _xs _e)] is now represented as @racket[(LamPlain _f _xs _e)].

The parser has been updated to handle these forms:

@ex[
 (parse-define '(define (f x) x))
 (parse-define '(define (f . xs) xs))
 (parse-define '(define (f x y z . xs) xs))
 (parse-e '(λ (x) x))
 (parse-e '(λ xs xs))
 (parse-e '(λ (x y z . xs) xs))
 ]

@bold{Apply} requires a new corresponding AST node and an extension to the
parser. The new AST node has the following definition:

@#reader scribble/comment-reader
(racketblock
;; type Expr = ...
;;           | (Apply Expr (Listof Expr) Expr)
...
(struct Apply (ef es e) #:prefab)
)

The parser has been updated to handle concrete syntax of the form:

@#reader scribble/comment-reader
(racketblock
(apply _ef _e0 ... _en)
)

For example:

@ex[
 (parse-e '(apply f x y zs))
 (parse-e '(apply f '()))
 (parse-e '(apply f 1 (cons 2 '())))
 ]

@bold{Exceptions and exception handling} require new AST nodes and an extension
to the parser. The new AST nodes have the following definitions:

@#reader scribble/comment-reader
(racketblock
;; type Expr = ...
;;           | (Raise Expr)
;;           | (WithHandlers (Listof Expr) (Listof Expr) Expr)
...
(struct Raise (e) #:prefab)
(struct WithHandlers (ps hs e) #:prefab)
)

The parser has been updated to handle concrete syntax of the form:

@#reader scribble/comment-reader
(racketblock
(raise _e)
)

as well as:

@#reader scribble/comment-reader
(racketblock
(with-handlers ([_p _h] ...) _e)
)

For example:

@ex[
 (parse-e '(raise 42))
 (parse-e '(with-handlers () #t))
 (parse-e '(with-handlers ([(λ (x) (= x 42)) (λ (x) (+ x 17))]) (raise 42)))
 ]


@section[#:tag-prefix "proj-" #:style 'unnumbered #:tag "suggestions"]{Suggestions}

This is a tricky project. The amount of code you have to write is relatively
small, but you may spend a long time slogging through the project if your
approach is to hack first and think later. Here are some suggestions for how to
approach the project. We recommend making sure you get each of the pieces
working before moving on.

@itemlist[

 @item{Start with @secref[#:tag-prefixes '("proj-") "arity"]; this should be
  the easiest part. Make sure to get it working for plain function definitions.}

 @item{Move on to @secref[#:tag-prefixes '("proj-") "rest"]. You could start by
  emitting code that checks that the number of required arguments is acceptable.
  Then, iterate over the remaining arguments, popping the appropriate number off
  and ignoring their values, and then pushing the empty list as a temporary
  solution to bind to the rest parameter. This will work like a proper variadic
  function in that it should accept any number of arguments beyond the required
  minimum, but the rest parameter itself will always be bound to the empty list.
  Once this is working, modify the code to build a list as you pop the extra
  arguments and bind this list to the rest parameter instead. Test that it
  works.}

 @item{For @secref[#:tag-prefixes '("proj-") "apply"], at first don't worry
  about arity checking. Instead, consider the case where there are no explicit
  arguments given, i.e., focus first on @racket[(apply _ef _en)]. Once you have
  that working, consider the more general case of @racket[(apply _ef _e0 ...
  _en)]. Then figure out how to add in the arity checking part. Finally, make
  sure you're detecting error cases such as when @racket[_ef] is not a procedure
  and @racket[_en] is not a proper list.}

 @item{After getting the rest working, implement @secref[#:tag-prefixes
 '("proj-") "exceptions"]. A good idea might be to open the Racket REPL and work
 through some examples of @racket[raise] and @racket[with-handlers] to make sure
 you really understand the semantics of what you're implementing. Implement the
 compiler, but try to take logical, discrete steps in the implementation process
 (e.g., make it work for exactly one exception handler first, then generalize to
 arbitrarily many, and so on).}

 ]


@section[#:tag-prefix "proj-" #:style 'unnumbered]{Submitting}

Submit a @tt{.zip} file containing your work to Gradescope. Use @tt{make
submit.zip} from within the @tt{loot-plus} directory to create a zip file with
the proper structure.
