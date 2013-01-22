;(ql:quickload "cl-turtle-graphics")

(in-package :cl-logo-user)

(defun draw-square (len)
  (repeat 4
	  (move len)
	  (turn 90)))

(defun test-draw-square (len)
  (turtle-on)
  (pen-down)
  (draw-square len)
  (turtle-off))
  
(defun test01 ()
  (let ((*turtle-class* 'console-turtle:console-turtle)
	(*field-class* 'console-turtle:console-field))
    (test-draw-square 10)))

(defun test02 ()
  (let ((*turtle-class* 'cairo-turtle:cairo-turtle)
	(*field-class* 'cairo-turtle:cairo-field))
    (test-draw-square 50)))


(defun test03 ()
  (let ((*turtle-class* 'gtk-turtle:gtk-turtle)
	(*field-class* 'gtk-turtle:gtk-field))
    (turtle-on)
    (pen-down)
    (draw-square 50)))
