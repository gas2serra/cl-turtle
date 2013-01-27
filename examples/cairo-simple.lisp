(ql:quickload "cl-cairo-turtle")

(in-package :cl-logo-user)

(defun draw-square (len)
  (repeat 4
	  (move len)
	  (turn 90)))

(defun test01 ()
  (let ((*turtle-class* 'cl-turtle:turtle)
	(*surface-class* 'cl-turtle:surface))
    (turtle-init)
    (change-pen (new-pen :width 3 :color '(0.8 0.3 0.1 0.4)))
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
    (turtle-destroy)))

(defun run ()
  (test01))

(run)
