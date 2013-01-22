(ql:quickload "cl-cairo-turtle")

(in-package :cl-logo-user)

(defun draw-square (len)
  (repeat 4
	  (move len)
	  (turn 90)))

(defun test01 ()
  (let ((*turtle-class* 'cl-cairo-turtle:cairo-turtle)
	(*surface-class* 'cl-cairo-turtle:cairo-surface))
    (turtle-on)
    (clear)
    (change-pen-width 3)
    ;(change-pen-color-by-name cl-colors:+red+ 0.7)
    ;(change-pen-color-by-name cl-colors:+red+)
    (change-pen-color 0.5 0.2 0.2 0.3)
    (repeat 5
	    (pen-down)
	    (draw-square 80)
	    (pen-up)
	    (move 10)
	    (turn 72))
    (save-as-png "a.png")
    (turtle-off)))
