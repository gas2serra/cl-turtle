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
  (turtle-init :width 300 :height 700)
  (set-pen-width 3)
  (set-pen-color 0.5 0.2 0.2 0.3)
  (repeat 5
	  (pen-down)
	  (draw-square 80)
	  (pen-up)
	  (move 10)
	  (turn 72))
  (save-as "a.png")
  (save-as "a.svg")
  (save-as "a.pdf")
  (save-as "a.ps")

  (turtle-destroy))
