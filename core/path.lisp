(in-package :cl-turtle)

;
; path struct
;

(defstruct path 
  "a path is a sequence of points that must be drow with a specific style"
  (style nil :type list)
  (points nil :type list))

(defun path-add-point (path point)
  (push point (path-points path)))