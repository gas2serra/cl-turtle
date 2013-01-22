(in-package :cl-turtle)

(defun degrees->radians (degree)
  (* pi (/ degree 180)))

(defun radians->degrees (radians)
  (/ (* 180 radians) pi))

(defun polar->cartesian (dist angle)
  (values (* dist (cos angle))
	  (* dist (sin angle))))

(defun normalize-angle (angle)
  "0 <= angle <= 360"
  (if (< angle 0) 
      (normalize-angle (+ 360 angle))
      (rem angle 360)))
