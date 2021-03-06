#! /usr/bin/env hy
;----------------------------------------------
; Calchylus 3 - Lambda calculus with Hy
;
; Source:
; https://github.com/markomanninen/calchylus3/
;
; Install:
; $ pip install calchylus3
;
; Open Hy:
; $ hy
;
; Import library:
; (require [calchylus3.lambdas [*]])
;
; Initialize with macros:
; (with-macros λ)
;
; or without macros
; (without-macros λ)
;
; For example church number two:
; ((λ x y [x [x y]]) 'a 'b) -> (a (a b))
;
; or if macros are included, then:
; (TWO 'a 'b) -> (a (a b))
;
; Documentation: http://calchylus3.readthedocs.io/
; Author: Marko Manninen <elonmedia@gmail.com>
; Copyright: Marko Manninen (c) 2019
; Licence: MIT
;----------------------------------------------

(defmacro with-macros [binder &optional [delimitter ""]]
  `(do
    (import hy)
    (init-system ~binder ~delimitter)
    (require [calchylus3.macros [*]])
    (init-macros ~binder)))

(defmacro without-macros [binder &optional [delimitter ""]]
   `(do
     (import hy)
     (init-system ~binder ~delimitter)))

(defmacro init-system [binder delimitter]
  `(do
    (eval-and-compile
      (setv ; lambda expression macro name
            binder '~binder
            ; this is required for pretty print to work or otherwise delimitter is regarded as an unknown symbol
            delimitter '~delimitter)
      ; print nested lists with pretty nested parentheses
      (defn print* [x] (print (repr* x)))
      ; extend output rather than in place. used in macros too
      (defn extend [a b] (.extend a b) a)
      ; reverse ouput rather than in place. used in macros too
      (defn reverse [a] (.reverse a) a)
      ; is instance a function abstraction?
      (defn function? [e] (instance? Function e))
      ; instead of straighforward native apply function, apply*
      ; will take care of the result that is possibly not a function but a list
      ; in that case result will be extended with the remaining arguments
      (defn apply* [a b]
        ; by checking callable instead of function? we will extend the standard lambda
        ; function body to allow native hy/python function calls too
        (while (and (callable a) b)
          (setv a (a (.pop b 0))))
        (if b (extend a b) a))
      ; head normal form of the lambda application
      (defn normalize [e]
        (if (coll? e)
          (if (function? (first e))
            (apply* (first e) (list (rest e)))
            (if (function? e) e
              (do (setv x (list (map normalize e)))
                  (if (function? (first x)) (normalize x) x)))) e))
      ; helper for pretty printter
      (defn repr* [e]
        (if (coll? e) (% "(%s)" (.join " " (map repr* e)))
          ; there might be an anonymous function in the expression, surpress it
          (if (and (not (function? e)) (callable e)) "" (str e))))
      ; prettier lambda function abstraction representation
      (defn repr [e]
        (if (and (coll? e) (not (function? e)))
          (repr* (map str (map repr e))) e))
      ; lambda function abstraction
      (defclass Function [list]
        ; pretty representation of the function. normally function in python / hy doesn't have
        ; any suitable printing format because of the arbitrary content of the function.
        ; in lambda calculus function body is structured in a very strict manner so we can
        ; show the exact content of the function body
        (defn --repr-- [self]
          (% "(%s %s%s%s)" (, '~binder (first self)
            ; one could normalize the second self, but max recursion error are probably impossible
            ; to handle in the self referencing forms
            (if delimitter (% " %s " (, (.strip delimitter "\\"))) " ") (repr (second self)))))
        ; the function body to the normal head form (call by value)
        (defn --call-- [self value &rest args]
          ; if extra arguments are given then they are curryed forward
          ; instead of using apply we use a slightly modified functionality with apply*
          ((fn [x] (if args (apply* x (list args)) x)) (normalize ((last self) value))))))

    ; main lambda macro
    (defmacro ~binder [&rest expr]
      (reduce (fn [body arg]
        `((fn[] (setv ~arg (str '~arg))
          (Function ['~arg ~body (fn [~arg] ~body)])))) (reverse (list expr))))))
