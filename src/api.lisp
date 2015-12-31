(in-package :cl-turtle)

;;;;
;;;; Turtle API
;;;;

(declaim (inline move-forward move-backward))
(declaim (inline turn-left turn-right))
(declaim (inline pull-pen-up pull-pen-down))
(declaim (inline pos))

;;;
;;; environment
;;;

(defvar *turtle* nil "The default turtle.")

;;;
;;; moving
;;;

(defun move (distance &optional (turtle *turtle*))
  "Move the turtle forward (distance>0) or backward (distance<0) by the specified distance, in the direction the turtle is headed."
  (turtle.core:turtle-move turtle distance))

(defun move-forward (distance &optional (turtle *turtle*))
  "Move the turtle forward by the specified distance, in the direction the turtle is headed."
  (assert (>= distance 0))
  (move distance turtle))

(defun move-backward (distance &optional (turtle *turtle*))
 "Move the turtle backward by the specified distance, in the direction the turtle is headed."
  (assert (>= distance 0))
  (move (- distance) turtle))

;;;
;;; turning
;;;

(defun turn (angle &optional (turtle *turtle*))
  "Turn the turtle right (angle>0) or left (angle<0) by angle degrees."
  (assert (and (> angle -360) (< angle 360)))
  (turtle.core:turtle-turn turtle angle))

(defun turn-left (angle &optional (turtle *turtle*))
  "Turn the turtle left by angle degrees."
  (assert (and (>= angle 0) (< angle 360)))
  (turn (- angle) turtle))

(defun turn-right (angle &optional (turtle *turtle*))
  "Turn the turtle right by angle degrees."
  (assert (and (>= angle 0) (< angle 360)))
  (turn angle turtle))

;;;
;;; go/turn to
;;;

(defun go-to (x y &optional (turtle *turtle*))
  "Move the turtle to the absolute position (x,y)."
  (turtle.core:turtle-goto turtle x y))
  
(defun go-home (&optional (turtle *turtle*))
  "Move turtle to the origin and set its heading to its start-orientation."
  (turtle.core:turtle-home turtle))
  
(defun turn-to (angle &optional (turtle *turtle*))
  "Set the orientation of the turtle to angle."
  (turtle.core:turtle-turn-to turtle angle))

;;;
;;; pen controll
;;;

(defun pull-pen (pos &optional (turtle *turtle*))
  "Pull down or up the pen of the turtle."
  (assert (member pos '(:up :down)))
  (turtle.core:turtle-pull-pen turtle pos))

(defun pull-pen-up ( &optional (turtle *turtle*))
  "Pull the pen up."
  (pull-pen :up turtle))

(defun pull-pen-down ( &optional (turtle *turtle*))
  "Pull the pen down." 
  (pull-pen :down turtle))

;;;
;;; speed
;;;

(defun set-speed (s &optional (turtle *turtle*))
  "Set the speed of the turtle"
  (setf (turtle.core:turtle-speed turtle) s))

;;;
;;; status
;;;

(defun x-coordinate (&optional (turtle *turtle*))
  "Return the turtle’s x coordinate."
  (turtle.core:turtle-x turtle))

(defun y-coordinate (&optional (turtle *turtle*))
  "Return the turtle’s y coordinate."
  (turtle.core:turtle-y turtle))

(defun heading (&optional (turtle *turtle*))
  "Return the turtle’s current heading."
  (turtle.core:turtle-heading turtle))

(defun pen-pos (&optional (turtle *turtle*))
  "Return the pen’s current position (:up or :down)."
  (turtle.core:turtle-pen-position turtle))

(defun get-speed (&optional (turtle *turtle*))
  "Return the speed of the turtle."
  (turtle.core:turtle-speed turtle))

(defun pos (&optional (turtle *turtle*))
  "Return the turtle’s current location (x,y)."
  (list (x-coordinate turtle) (y-coordinate turtle)))

(defun state (&optional (turtle *turtle*))
  "Return the full state of the turtle."
  (list :x (x-coordinate turtle) :y (y-coordinate turtle) :heading (heading turtle) 
	:pen-pos (pen-pos turtle) :speed (get-speed turtle)))

(defun towards (x y &optional (turtle *turtle*))
  "Return the angle between the line from turtle position to position specified by (x,y)."
  (let ((angle (turtle.core:radians->degrees 
		(acos (/ (- x (x-coordinate turtle)) (distance x y turtle))))))
    (- (heading turtle) (if (>= y 0.0) angle (- 360 angle)))))

(defun distance (x y &optional (turtle *turtle*))
  "Return the distance from the turtle to (x,y)."
  (turtle.core:points-distance x y (x-coordinate turtle) (y-coordinate turtle)))


;;;;
;;;; Surface API
;;;;

(defvar *surface* nil "The default surface")


;;;;
;;;; Language macro
;;;;

(defmacro repeat (n &body body)
  "Repeat n-times the body"
  (let ((i (gensym "i")))
    `(dotimes (,i ,n)
       ,@body)))



					;
;;;;
;;;; To Fix
;;;;

(defvar *turtle-class* 'turtle.core:turtle)
(defvar *surface-class* 'turtle.core:surface)

; macros

(defmacro with-surface ((&key (width 500) (height 400)) &body code)
  `(progn 
     (surface-init :width ,width :height ,height)
     ,@code
     (surface-destroy)))

(defmacro with-image ((filename &key (width 500) (height 400) (ext nil))  &body code)
  `(with-surface (:width ,width :height ,height)
     ,@code
     ,(if ext 
	  `(save-as (merge-pathnames ,filename (make-pathname :type ,ext)))
	  `(save-as ,filename))))

;
; logo's functions
;

; init
(defun surface-init (&key (width 500) (height 400))
  "Create a surface wuth one turtle"
  (if *surface*
      (surface-destroy))
  (setf *surface* (make-instance *surface-class* 
				 :turtle (make-instance *turtle-class*) 
				 :width width 
				 :height height))
  (setf *turtle* (turtle.core:surface-turtle *surface*)))

(defun surface-destroy ()
  "Destroy the surface and all its turtles"
  (when *surface* 
    (turtle.core:surface-destroy *surface*))
  (setf *surface* nil)
  (setf *turtle* nil))




; utility

; surface
(defun clear ()
  "clears the surface"
  (turtle.core:surface-clear *surface*))
(defun reset ()
  "reset the surface"
  (turtle.core:surface-reset *surface*)
  (state))
(defun save-as (filename)
  "saves the surface as an image"
  (turtle.core:surface-save-as *surface* filename))
(defun mode ()
  "Returns the surface mode (:batch :interactive)"
  (turtle.core:surface-mode *surface*))
(defun set-mode (mode)
  "Set the surface mode (:batch :interactive)"
  (setf (turtle.core:surface-mode *surface*) mode))


; drawing style
(defun pen (&optional (turtle *turtle*))
  "Returns the pen used by the turtle"
  (turtle.core:turtle-pen turtle))
(defun pen-attr (attr &optional (pen (pen *turtle*)))
  "Returns the value of an attribute of the pen"
  (turtle.core:pen-get-attribute pen attr))
(defun change-pen (pen &optional (turtle *turtle*))
  "Change the pen style"
  (setf (turtle.core:turtle-pen turtle) pen))
(defun new-pen (&rest props)
  "Create a new pen style"
  (apply #'make-instance 'turtle.core:pen props))
(defun clone-pen (&rest props &key (pen (pen)) &allow-other-keys)
  "Create a new pen style"
  (apply #'turtle.core:pen-clone pen props))
(defun set-background-color (color)
  "Set the backgound color as rgb"
  (setf (turtle.core:surface-color *surface*) color))

