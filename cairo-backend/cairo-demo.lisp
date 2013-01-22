(defpackage :cl-cairo-turtle-demo
  (:use :cl-cairo-turtle :cl-logo :common-lisp)
  (:export 
   run))

(in-package :cl-cairo-turtle-demo)

(defun draw-square (len)
  (repeat 4
	  (move len)
	  (turn 90)))

(defun run ()
  (let ((*turtle-class* 'cl-turtle:turtle)
	(*surface-class* 'cl-turtle:surface))
    (turtle-on)
;    (clear)
    (change-pen-width 3)
    (change-pen-color 0.5 0.2 0.2 0.3)
    (repeat 5
	    (pen-down)
	    (draw-square 80)
	    (pen-up)
	    (change-pen-width 5)
	    (move 10)
	    (turn 72))
    (cl-cairo-turtle::cairo-save-as-png "a.png" logo::*surface*)
    (format t "~A~%" (turtle::turtle-trail logo::*turtle*))
    (turtle-off)))
