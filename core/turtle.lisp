(in-package :cl-turtle)

;
; A turtle
;
(defclass turtle ()
  ((x :initform 0
      :initarg :x
      :reader turtle-x
      :documentation "the x coordinate of the turtle in the surface")
   (y :initform 0
      :initarg :y
      :reader turtle-y
      :documentation "the y coordinate of the turtle in the surface")
   (heading :initform 0
	    :initarg :heading
	    :reader turtle-heading
	    :documentation "the heading of the turtle")
   (pen-position :initform :down
		 :initarg :pen-position
		 :reader turtle-pen-position
		 :type (member :down :up)
		 :documentation "the position of the pen")
   (pen-width :initform 1
	      :initarg :pen-width
	      :reader turtle-pen-width
	      :type number
	      :documentation "the width of the pen")
   (pen-color :initform (cl-colors:add-alpha cl-colors:+darkgoldenrod+ 0.5)
 	      :initarg :pen-color
	      :reader turtle-pen-color
	      :type (or cl-colors:rgb cl-colors:rgba)
	      :documentation "the color of the pen")
   (surface :initform nil
	    :reader turtle-surface
	    :documentation "the surface where the turtle lives"))
  (:documentation "A turtle"))

; heading
(defun turtle-heading/radians (turtle)
  (degrees->radians (turtle-heading turtle))) 
; moving
(defgeneric turtle-move (turtle distance)
  (:method ((turtle turtle) distance)
    (multiple-value-bind (dx dy) 
	(polar->cartesian distance (degrees->radians (turtle-heading turtle)))
      (setf (slot-value turtle 'x) (+ (turtle-x turtle) dx))
      (setf (slot-value turtle 'y) (+ (turtle-y turtle) dy)))))
; turning
(defgeneric turtle-turn (turtle degree)
  (:method ((turtle turtle) degree)
    (setf (slot-value turtle 'heading) 
	  (normalize-angle (+ (turtle-heading turtle) degree)))))
(defun turtle-turn/radians (turtle radians)
  (turtle-turn turtle (radians->degrees radians))) 
; pulling the pen
(defgeneric turtle-pull-pen (turtle pos)
  (:method ((turtle turtle) pos)
    (setf (slot-value turtle 'pen-position) pos)))
; goto
(defgeneric turtle-goto (turtle x y)
  (:method ((turtle turtle) x y)
      (setf (slot-value turtle 'x) x)
      (setf (slot-value turtle 'y) y)))
(defun turtle-home (turtle)
  (setf (slot-value turtle 'heading) 0)
  (if (eq (turtle-pen-position turtle) :up)
      (turtle-goto turtle 0 0)
      (progn 
	(turtle-pull-pen turtle :up)
	(turtle-goto turtle 0 0)
	(turtle-pull-pen turtle :down))))

; drawing style
(defgeneric turtle-pen-change-color (turtle rgb)
  (:method ((turtle turtle) rgb)
    (setf (slot-value turtle 'pen-color) rgb)))

(defgeneric turtle-pen-change-width (turtle width)
  (:method ((turtle turtle) width)
    (setf (slot-value turtle 'pen-width) width)))
