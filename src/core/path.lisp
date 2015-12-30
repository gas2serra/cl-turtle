(in-package :cl-turtle)

;
; a path (immutable)
;
(defclass path  ()
  ((pen
    :initform nil
    :initarg :pen
    :reader path-pen
    :type list
    :documentation "the pen used to draw the path of points")
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
