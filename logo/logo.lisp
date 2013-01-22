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
(defun turtle-on (&key (width 500) (height 400))
  (if *surface*
      (turtle-off))
  (setf *surface* (make-instance *surface-class* :width width :height height))
  (setf *turtle* (make-instance *turtle-class*))
  (turtle:surface-add-turtle *surface* *turtle*))

(defun turtle-off ()
  (turtle:surface-destroy *surface*)
  (setf *surface* nil)
  (setf *turtle* nil)) 

; turning
(defun turn (degree)
  (assert (and (> degree -360) (< degree 360)))
  (turtle:turtle-turn *turtle* degree))
(defun left (degree)
  (assert (and (>= degree 0) (< degree 360)))
  (turn degree))
(defun right (degree)
  (assert (and (>= degree 0) (< degree 360)))
  (turn (- degree)))

; moving
(defun move (len)
  (turtle:turtle-move *turtle* len))
(defun forward (len)
  (assert (>= len 0))
  (move len))
(defun backward (len)
  (assert (>= len 0))
  (move (- len)))

; goto
(defun goto (x y)
  (turtle:turtle-goto *turtle* x y))
(defun home ()
  (turtle:turtle-home *turtle*))

; drawing
(defun pull-pen (pos)
  (assert (member pos '(:up :down)))
  (turtle:turtle-pull-pen *turtle* pos))
(defun pen-up ()
  (pull-pen :up))
(defun pen-down ()
  (pull-pen :down))

; drawing style
(defun change-pen-width (width)
  (assert (>= width 0))
  (turtle:turtle-set-pen-style *turtle* :width width))

(defun change-pen-color-by-name (color &optional alpha)
  (check-type color (or cl-colors:rgb cl-colors:rgba))
  (assert (or (null alpha) (and (>= alpha 0.0) (<= alpha 1.0))))
  (turtle:turtle-set-pen-style *turtle* :color
			       (if alpha 
				   (cl-colors:add-alpha color alpha)
				   color)))
(defun change-pen-color (r g b &optional (a 1.0))
  (assert (every (lambda (x) (and (>= x 0.0) (<= x 1.0))) (list r g b a)))
  (turtle:turtle-set-pen-style *turtle* :color
			       (make-instance 'cl-colors:rgba 
					      :red r :green g 
					      :blue b :alpha a)))
; surface
(defun clear ()
  (turtle:surface-clear *surface*))
; png
(defun save-as-png (filename)
  (turtle:surface-save-as-png *surface* filename))

; language macros
(defmacro repeat (n &rest body)
  (let ((i (gensym "i")))
    `(dotimes (,i ,n)
       ,@body)))

