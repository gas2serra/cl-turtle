(defpackage :cl-gtk-turtle-demo
  (:use :cl-gtk-turtle :cl-logo :common-lisp)
  (:export 
   run
   stop))

(in-package :cl-gtk-turtle-demo)

(defun draw-square (len)
  (repeat 4
	  (move len)
	  (turn 90)))

(defun run()
  (let ((*turtle-class* 'cl-gtk-turtle:gtk-turtle)
	(*surface-class* 'cl-gtk-turtle:gtk-surface))
    (turtle-init)
   ; (clean)
;    (change-pen-color 0.9 0.5 0.5)
    (repeat 5
	    (pen-down)
	    (draw-square 70)
	    (pen-up)
	    (move 10)
	    (turn 72))))

(defun stop ()
  (save-as "a.png")
  (turtle-destroy))
