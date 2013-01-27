(ql:quickload "cl-cairo-turtle")

(in-package :cl-logo-user)

(defun draw-square (len)
  (repeat 4
	  (move len)
	  (turn 90)))

(defun figure-1 ()
  (repeat 5
	  (pen-down)
	  (draw-square 70)
	  (pen-up)
	  (change-pen (clone-pen :width (+ 2 (pen-attr :width))))
	  ;(change-pen (aref *penset i))
	  (move 10)
	  (turn 72)))

(defun run()
  (let ((*turtle-class* 'cl-x11-turtle:x11-turtle)
	(*surface-class* 'cl-x11-turtle:x11-surface)
	;(*penset* (make-sequence 'vector 5))
	;(pen (new-pen :color '(1.0 0.3 0.1))))
	)
    (turtle-init)
    ;(dotimes (i 5)
    ;(setf (aref *penset* i) (clone-pen :pen pen :with (+ 1 i))))
    (change-pen (new-pen :width 3 :color '(0.8 0.3 0.1 0.4)))
    (repeat 5
	    (pen-down)
	    (draw-square 70)
	    (pen-up)
	    (change-pen (clone-pen :width (+ 2 (pen-attr :width))))
	    (move 10)
	    (turn 72))))

(run)
