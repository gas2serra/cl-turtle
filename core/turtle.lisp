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
   (pen-position :initform :up
		 :initarg :pen-position
		 :reader turtle-pen-position
		 :type (member :down :up)
		 :documentation "the position of the pen")
   (pen-style :initform (make-instance 'style)
	      :initarg :pen-style
	      :reader turtle-pen-style
	      :type style
	      :documentation "the style of the pen")
   (surface :initform nil
	    :reader turtle-surface
	    :documentation "the surface where the turtle lives")
   (trail :initform nil
	  :accessor turtle-trail
	  :documentation "the trail of the turtle"))
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
      (setf (slot-value turtle 'y) (+ (turtle-y turtle) dy))
      (when (eq (turtle-pen-position turtle) :down)
	(add-point-to-path turtle)))))

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
    (if (eq pos :down)
      (add-new-trail-path turtle)
      (when (turtle-trail turtle)
	(surface-add-path (turtle-surface turtle) (turtle-trail turtle))))
    (setf (slot-value turtle 'pen-position) pos)))
; goto
(defgeneric turtle-goto (turtle x y)
  (:method ((turtle turtle) x y)
     (setf (slot-value turtle 'x) x)
     (setf (slot-value turtle 'y) y)
     (when (eq (turtle-pen-position turtle) :down)
       (add-point-to-path turtle))))

(defun turtle-home (turtle)
  (setf (slot-value turtle 'heading) 0)
  (if (eq (turtle-pen-position turtle) :up)
      (turtle-goto turtle 0 0)
      (progn 
	(turtle-pull-pen turtle :up)
	(turtle-goto turtle 0 0)
	(turtle-pull-pen turtle :down))))

; drawing style
(defgeneric turtle-get-pen-style (turtle attr)
  (:method ((turtle turtle) attr)
    (style-get-attribute (turtle-pen-style turtle) attr)))

(defgeneric turtle-set-pen-style (turtle attr value)
  (:method ((turtle turtle) attr value)
    (style-set-attribute (turtle-pen-style turtle) attr value)))

; 
(defun turtle-position (turtle)
  (list (turtle-x turtle) (turtle-y turtle)))

; trail
(defun turtle-clear-trail (turtle)
  (setf (slot-value turtle 'trail) nil)
  (turtle-pull-pen turtle :up))
(defun add-new-trail-path (turtle)
  (setf (slot-value turtle 'trail)
	(make-instance 'path 
		       :style (style-clone (turtle-pen-style turtle))
		       :points (list (turtle-position turtle)))))
(defun add-point-to-path (turtle)
  (path-add-point 
   (turtle-trail turtle)
   (turtle-position turtle)))
