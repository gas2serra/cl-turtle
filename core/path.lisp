(in-package :cl-turtle)

;
; a path 
;

(defclass path  ()
  ((style 
    :initform nil
    :initarg :style
    :reader path-style
    :type list
    :documentation "the style used to draw the path of points")
   (points
    :initform nil 
    :initarg :points 
    :accessor path-points
    :type list
    :documentation "the reverse sequence of points"))
  (:documentation "a path is a sequence of points that must be drow with a specific style"))

(defun path-add-point (path point)
  (push point (path-points path)))

(defun path-ordered-points (path)
  (reverse (path-points path)))
