(in-package :cl-turtle)

; default slots of the turtle in the home position
(defconstant +default-turtle-home-x+ 0)
(defconstant +default-turtle-home-y+ 0)
(defconstant +default-turtle-home-heading+ 90)
(defconstant +default-turtle-home-pen-position+ :up)
(defconstant +default-turtle-home-pen+ (make-instance 'pen))
(defconstant +default-turtle-speed+ -1)


;
; A turtle
;
(defclass turtle ()
  ((x :initform +default-turtle-home-x+
      :initarg :x
      :reader turtle-x
      :documentation "the x coordinate of the turtle in the surface")
   (y :initform +default-turtle-home-y+
      :initarg :y
      :reader turtle-y
      :documentation "the y coordinate of the turtle in the surface")
   (heading :initform +default-turtle-home-heading+
	    :initarg :heading
	    :reader turtle-heading
	    :documentation "the heading of the turtle")
   (pen-position :initform :+default-turtle-home-pen-position+
		 :initarg :pen-position
		 :reader turtle-pen-position
		 :type (member :down :up)
		 :documentation "the position of the pen")
   (pen :initform +default-turtle-home-pen+
	:initarg :pen
	:accessor turtle-pen
	:type pen
	:documentation "the style of the pen")
   (speed :initform +default-turtle-speed+
	  :initarg :speed
	  :accessor turtle-speed
	  :type integer
	  :documentation "the speed of the turtle")
   (surface :initform nil
	    :reader turtle-surface
	    :documentation "the surface where the turtle lives")
;   (trail :initform nil
;	  :accessor turtle-trail
;	  :documentation "the trail (incomplete path) of the turtle"))
   )
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
	;(turtle-add-point-into-trail turtle)))))
	(surface-add-point-into-trail (turtle-surface turtle)
				      (turtle-x turtle) (turtle-y turtle))))
    (let ((time (/ distance (turtle-speed turtle))))
      (when (> time 0)
	(sleep time)))))

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
       (surface-add-point-into-trail (turtle-surface turtle)
				     (turtle-x turtle) (turtle-y turtle)))))
       ;(turtle-add-point-into-trail turtle))))

(defgeneric turtle-home (turtle)
  (:documentation "Moves the turtle to the center of the surface coordinates [0 0], pointing up")
  (:method ((turtle turtle))
    (setf (slot-value turtle 'heading) +default-turtle-home-heading+)
    (if (eq (turtle-pen-position turtle) :up)
	(turtle-goto turtle +default-turtle-home-x+ +default-turtle-home-y+)
	(progn 
	  (turtle-pull-pen turtle :up)
	  (turtle-goto turtle +default-turtle-home-x+ +default-turtle-home-y+)
	  (turtle-pull-pen turtle :down)))))
(defgeneric turtle-turn-to (turtle degree)
  (:documentation "Moves the turtle in order to point to degree")
  (:method ((turtle turtle) degree)
    (setf (slot-value turtle 'heading) degree)))
; pulling the pen
(defgeneric turtle-pull-pen (turtle pos)
  (:documentation "Pulls down or up the pen of the turtle")
  (:method ((turtle turtle) pos)
    (setf (slot-value turtle 'pen-position) pos)
    (if (eq pos :down)
	(surface-new-trail (turtle-surface turtle) (turtle-pen turtle) 
			   (turtle-x turtle) (turtle-y turtle))
	(surface-trail-completed (turtle-surface turtle)))))

; reset
(defgeneric turtle-reset (turtle)
  (:documentation "Moves the turtle in the home in the default state")
  (:method ((turtle turtle))
;    (turtle-clear-trail)
    (turtle-home turtle)
    (setf (slot-value turtle 'x) +default-turtle-home-x+)
    (setf (slot-value turtle 'y) +default-turtle-home-y+)
    (setf (slot-value turtle 'heading) +default-turtle-home-heading+)
    (setf (slot-value turtle 'pen-position) +default-turtle-home-pen-position+)
    (setf (slot-value turtle 'pen) +default-turtle-home-pen+)))

; trail
#|
(defgeneric turtle-clear-trail (turtle)
  (:method ((turtle turtle))
    (setf (slot-value turtle 'trail) nil)))

(defgeneric turtle-add-point-into-trail (turtle)
  (:method ((turtle turtle))
    (path-add-point 
     (turtle-trail turtle)
     (list (turtle-x turtle) (turtle-y turtle)))))
|#