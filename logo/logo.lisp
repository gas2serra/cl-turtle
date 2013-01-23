(in-package :cl-logo)

;
; logo environment
;
(defvar *turtle* nil)
(defvar *surface* nil)
(defvar *turtle-class* 'turtle:turtle)
(defvar *surface-class* 'turtle:surface)

;
; logo's functions
;

; init
(defun turtle-init (&key (width 500) (height 400))
  "Create a surface wuth one turtle"
  (if *surface*
      (turtle-destroy))
  (setf *surface* (make-instance *surface-class* :width width :height height))
  (setf *turtle* (make-instance *turtle-class*))
  (turtle:surface-add-turtle *surface* *turtle*))

(defun turtle-destroy ()
  "Destroy the surface and all its turtles"
  (turtle:surface-destroy *surface*)
  (setf *surface* nil)
  (setf *turtle* nil)) 

; moving
(defun move (len)
  "Moves the turtle forwards (len>0) or backwards (len<0)"
  (turtle:turtle-move *turtle* len))
(defun forward (len)
  "Moves the turtle forwards"
  (assert (>= len 0))
  (move len))
(defun backward (len)
  "Moves the turtle backwards"
  (assert (>= len 0))
  (move (- len)))

; turning
(defun turn (degree)
  "Turns the turtle left (degree>0) or right (degree<0)"
  (assert (and (> degree -360) (< degree 360)))
  (turtle:turtle-turn *turtle* degree))
(defun left (degree)
  "Turns the turtle left"
  (assert (and (>= degree 0) (< degree 360)))
  (turn degree))
(defun right (degree)
  "Turns the turtle right"
  (assert (and (>= degree 0) (< degree 360)))
  (turn (- degree)))

; goto
(defun goto (x y)
  "Moves the turtle to the surface coordinates [0 0]"
  (turtle:turtle-goto *turtle* x y))
(defun home ()
  "Moves the turtle to the center of the surface coordinates [0 0], pointing up"
  (turtle:turtle-home *turtle*))
(defun turn-to (degree)
  "Moves the turtle in order to point to degree"
  (turtle:turtle-turn *turtle* (- degree (heading))))

; pen controll
(defun pull-pen (pos)
  "Pull down or up the pen of the turtle"
  (assert (member pos '(:up :down)))
  (turtle:turtle-pull-pen *turtle* pos))
(defun pen-up ()
  "Lifts up the pen of the turtle"
  (pull-pen :up))
(defun pen-down ()
  "Puts down the pen of the turtle" 
  (pull-pen :down))

; drawing style
(defun set-pen-style (attr value)
  "Set a style's attribute of the pen"
  (turtle:turtle-set-pen-style *turtle* attr value))
(defun set-pen-width (width)
  "Set the width of the pen"
  (assert (>= width 0))
  (set-pen-style :width width))
(defun set-pen-color (r g b &optional (a 1.0))
  "Set the color as rgb of th pen"
  (assert (every (lambda (x) (and (>= x 0.0) (<= x 1.0))) (list r g b a)))
  (set-pen-style :color (make-instance 'cl-colors:rgba :red r :green g :blue b :alpha a)))

; status
(defun pos ()
  "Return the position of the turtle"
  (list (x-cor) (y-cor)))
(defun x-cor ()
  "Return the x coordinate of the turtle"
  (turtle:turtle-x *turtle*))
(defun y-cor ()
  "Return the y coordinate of the turtle"
  (turtle:turtle-y *turtle*))
(defun heading ()
  "Return the turtle's heading in degrees"
  (turtle:turtle-heading *turtle*))
(defun pen-pos ()
  "Return the position of the pen"
  (turtle:turtle-pen-position *turtle*))
(defun pen-downp ()
  (eq (turtle:turtle-pen-position *turtle*) :down))
(defun pen-style (&optional (attr nil))
  "Return the style of the pen"
  (if attr
      (turtle:turtle-get-pen-style *turtle* attr)
      (turtle:turtle-pen-style *turtle*)))

; utility
(defun towards (x y)
  "Return the angle between the line from turtle position to position specified by (x,y)"
  (let ((angle (turtle::radians->degrees
		(acos (/ (- x (x-cor)) (distance x y))))))
    (- (if (>= y 0.0)
	   angle
	   (- 360 angle))
       (heading))))
(defun distance (x y)
  "Return the distance from the turtle to (x,y)"
  (sqrt (+ (expt (- x (x-cor)) 2)
	   (expt (- y (y-cor)) 2))))

; language macros
(defmacro repeat (n &rest body)
  "Repeat n-times the body"
  (let ((i (gensym "i")))
    `(dotimes (,i ,n)
       ,@body)))

; surface
(defun clear ()
  (turtle:surface-clear *surface*))
(defun set-background-color (r g b &optional (a 1.0))
  "Set the backgound color as rgb of th pen"
  (assert (every (lambda (x) (and (>= x 0.0) (<= x 1.0))) (list r g b a)))
  (setf (turtle:surface-color *surface*) 
	(make-instance 'cl-colors:rgba :red r :green g :blue b :alpha a)))
(defun save-as (filename)
  (turtle:surface-save-as *surface* filename))

;
;
;
; reset - home + clear + reset defaults