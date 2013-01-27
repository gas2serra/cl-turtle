(ql:quickload "cl-cairo-turtle")

(in-package :cl-logo-user)

(defun draw-square (len)
  (repeat 4
	  (move len)
	  (turn 90)))

(defun run()
  (let ((*turtle-class* 'cl-cairo-x11-turtle:cairo-x11-turtle)
	(*surface-class* 'cl-cairo-x11-turtle:cairo-x11-surface))
    (turtle-init)
    (change-pen (new-pen :width 3 :color '(0.8 0.3 0.1 0.4)))
    (repeat 5
	    (pen-down)
	    (draw-square 70)
	    (pen-up)
	    (move 10)
	    (turn 72))))

(run)
