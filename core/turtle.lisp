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
   (heading :initform 90
	    :initarg :heading
	    :reader turtle-heading
	    :documentation "the heading of the turtle")
   (pen-position :initform :up
		 :initarg :pen-position
		 :reader turtle-pen-position
		 :type (member :down :up)
		 :documentation "the position of the pen")
   (pen :initform (make-instance 'pen)
	      :initarg :pen
	      :accessor turtle-pen
	      :type pen
	      :documentation "the style of the pen")
   (surface :initform nil
	    :reader turtle-surface
	    :documentation "the surface where the turtle lives")
   (trail :initform nil
	  :accessor turtle-trail
	  :documentation "the trail of the turtle"))
  (:documentation "A turtle"))

; moving
(defgeneric turtle-move (turtle distance)
  (:documentation "Moves the turtle forwards (len>0) or backwards (len<0)")
  (:method ((turtle turtle) distance)
    (multiple-value-bind (dx dy) 
	(polar->cartesian distance (degrees->radians (turtle-heading turtle)))
      (setf (slot-value turtle 'x) (+ (turtle-x turtle) dx))
      (setf (slot-value turtle 'y) (+ (turtle-y turtle) dy))
      (when (eq (turtle-pen-position turtle) :down)
	(add-point-to-path turtle)))))
; turning
(defgeneric turtle-turn (turtle degree)
  (:documentation "Turns the turtle right (degree>0) or left (degree<0)")
  (:method ((turtle turtle) degree)
    (setf (slot-value turtle 'heading) 
	  (normalize-angle (- (turtle-heading turtle) degree)))))
; goto
(defgeneric turtle-goto (turtle x y)
  (:documentation "Moves the turtle to the surface coordinates [x y]")
  (:method ((turtle turtle) x y)
     (setf (slot-value turtle 'x) x)
     (setf (slot-value turtle 'y) y)
     (when (eq (turtle-pen-position turtle) :down)
       (add-point-to-path turtle))))
(defgeneric turtle-home (turtle)
  (:documentation "Moves the turtle to the center of the surface coordinates [0 0], pointing up")
  (:method ((turtle turtle))
    (setf (slot-value turtle 'heading) 90)
    (if (eq (turtle-pen-position turtle) :up)
	(turtle-goto turtle 0 0)
	(progn 
	  (turtle-pull-pen turtle :up)
	  (turtle-goto turtle 0 0)
	  (turtle-pull-pen turtle :down)))))
(defgeneric turtle-turn-to (turtle degree)
  (:documentation "Moves the turtle in order to point to degree")
  (:method ((turtle turtle) degree)
    (setf (slot-value turtle 'heading) degree)))
; pulling the pen
(defgeneric turtle-pull-pen (turtle pos)
  (:documentation "Pulls down or up the pen of the turtle")
  (:method ((turtle turtle) pos)
    (if (eq pos :down)
      (add-new-trail-path turtle)
      (when (turtle-trail turtle)
	(surface-add-path (turtle-surface turtle) (turtle-trail turtle))))
    (setf (slot-value turtle 'pen-position) pos)))
; reset
(defgeneric turtle-reset (turtle)
  (:documentation "")
  (:method ((turtle turtle))
    (turtle-home turtle)
    ; set defaults 
    ))

; trail
(defun turtle-clear-trail (turtle)
  (setf (slot-value turtle 'trail) nil)
  (turtle-pull-pen turtle :up))
(defun add-new-trail-path (turtle)
  (setf (slot-value turtle 'trail)
	(make-instance 'path 
		       :pen (turtle-pen turtle)
		       :points (list 
				(list (turtle-x turtle) (turtle-y turtle))))))
(defun add-point-to-path (turtle)
  (path-add-point 
   (turtle-trail turtle)
   (list (turtle-x turtle) (turtle-y turtle))))

