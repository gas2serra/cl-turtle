(in-package :cl-logo)

;
; logo environment
;
(defvar *turtle* nil)
(defvar *surface* nil)
(defvar *turtle-class* 'turtle:turtle)
(defvar *surface-class* 'turtle:surface)


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
  (setf *turtle* (turtle:surface-turtle *surface*)))

(defun surface-destroy ()
  "Destroy the surface and all its turtles"
  (when *surface* 
    (turtle:surface-destroy *surface*))
  (setf *surface* nil)
  (setf *turtle* nil))

; moving
(defun move (len &optional (turtle *turtle*))
  "Moves the turtle forwards (len>0) or backwards (len<0)"
  (turtle:turtle-move turtle len))
(defun forward (len &optional (turtle *turtle*))
  "Moves the turtle forwards"
  (assert (>= len 0))
  (move len turtle))
(defun backward (len &optional (turtle *turtle*))
  "Moves the turtle backwards"
  (assert (>= len 0))
  (move (- len) turtle))

; turning
(defun turn (degree &optional (turtle *turtle*))
  "Turns the turtle right (degree>0) or left (degree<0)"
  (assert (and (> degree -360) (< degree 360)))
  (turtle:turtle-turn turtle degree))
(defun left (degree &optional (turtle *turtle*))
  "Turns the turtle left"
  (assert (and (>= degree 0) (< degree 360)))
  (turn (- degree) turtle))
(defun right (degree &optional (turtle *turtle*))
  "Turns the turtle right"
  (assert (and (>= degree 0) (< degree 360)))
  (turn degree turtle))

; goto
(defun goto (x y &optional (turtle *turtle*))
  "Moves the turtle to the surface coordinates [x y]"
  (turtle:turtle-goto turtle x y))
(defun home (&optional (turtle *turtle*))
  "Moves the turtle to the center of the surface coordinates [0 0], pointing up"
  (turtle:turtle-home turtle))
(defun turn-to (degree &optional (turtle *turtle*))
  "Moves the turtle in order to point to degree"
  (turtle:turtle-turn-to turtle degree))

; pen controll
(defun pull-pen (pos &optional (turtle *turtle*))
  "Pulls down or up the pen of the turtle"
  (assert (member pos '(:up :down)))
  (turtle:turtle-pull-pen turtle pos))
(defun pen-up ( &optional (turtle *turtle*))
  "Lifts up the pen of the turtle"
  (pull-pen :up turtle))
(defun pen-down ( &optional (turtle *turtle*))
  "Puts down the pen of the turtle" 
  (pull-pen :down turtle))

; speed
(defun set-speed (s &optional (turtle *turtle*))
  "Set the speed of the turtle"
  (setf (turtle:turtle-speed turtle) s))

; status
(defun x-cor (&optional (turtle *turtle*))
  "Returns the x coordinate of the turtle"
  (turtle:turtle-x turtle))
(defun y-cor (&optional (turtle *turtle*))
  "Returns the y coordinate of the turtle"
  (turtle:turtle-y turtle))
(defun heading (&optional (turtle *turtle*))
  "Returns the turtle's heading in degrees"
  (turtle:turtle-heading turtle))
(defun pen-pos (&optional (turtle *turtle*))
  "Returns the position of the pen (:down or :up)"
  (turtle:turtle-pen-position turtle))
(defun pos (&optional (turtle *turtle*))
  "Returns the position of the turtle"
  (list (x-cor turtle) (y-cor turtle)))
(defun get-speed (&optional (turtle *turtle*))
  "Returns the speed of the turtle"
  (turtle:turtle-speed turtle))
(defun state (&optional (turtle *turtle*))
  "Returns the full state of the turtle"
  (list :x (x-cor turtle) :y (y-cor turtle) :heading (heading turtle) 
	:pen-pos (pen-pos turtle)))

; utility
(defun towards (x y &optional (turtle *turtle*))
  "Returns the angle between the line from turtle position to position specified by (x,y)"
  (let ((angle (turtle:radians->degrees 
		(acos (/ (- x (x-cor turtle)) (distance x y turtle))))))
    (- (heading turtle) (if (>= y 0.0) angle (- 360 angle)))))
(defun distance (x y &optional (turtle *turtle*))
  "Returns the distance from the turtle to (x,y)"
  (turtle:points-distance x y (x-cor turtle) (y-cor turtle)))

; language macros
(defmacro repeat (n &rest body)
  "Repeats n-times the body"
  (let ((i (gensym "i")))
    `(dotimes (,i ,n)
       ,@body)))

; surface
(defun clear ()
  "clears the surface"
  (turtle:surface-clear *surface*))
(defun reset ()
  "reset the surface"
  (turtle:surface-reset *surface*)
  (state))
(defun save-as (filename)
  "saves the surface as an image"
  (turtle:surface-save-as *surface* filename))
(defun mode ()
  "Returns the surface mode (:batch :interactive)"
  (turtle:surface-mode *surface*))
(defun set-mode (mode)
  "Set the surface mode (:batch :interactive)"
  (setf (turtle:surface-mode *surface*) mode))


; drawing style
(defun pen (&optional (turtle *turtle*))
  "Returns the pen used by the turtle"
  (turtle:turtle-pen turtle))
(defun pen-attr (attr &optional (pen (pen *turtle*)))
  "Returns the value of an attribute of the pen"
  (turtle:pen-get-attribute pen attr))
(defun change-pen (pen &optional (turtle *turtle*))
  "Change the pen style"
  (setf (turtle:turtle-pen turtle) pen))
(defun new-pen (&rest props)
  "Create a new pen style"
  (apply #'make-instance 'turtle:pen props))
(defun clone-pen (&rest props &key (pen (pen)) &allow-other-keys)
  "Create a new pen style"
  (apply #'turtle:pen-clone pen props))
(defun set-background-color (color)
  "Set the backgound color as rgb"
  (setf (turtle:surface-color *surface*) color))

