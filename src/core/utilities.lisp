(in-package :cl-turtle.core)

(defun degrees->radians (degree)
  "Transforms an angle in degree into radiant"
  (* pi (/ degree 180)))

(defun radians->degrees (radians)
  "Transforms an angle in radian into degree"
  (/ (* 180 radians) pi))

(defun polar->cartesian (dist angle)
  "Transforms a polar coordinate into cartesian coordinate"
  (values (* dist (cos angle))
	  (* dist (sin angle))))

(defun normalize-angle (angle)
  "0 <= angle <= 360"
  (if (< angle 0) 
      (normalize-angle (+ 360 angle))
      (rem angle 360)))

(defun points-distance (x1 y1 x2 y2) 
  "Returns the distance between [x1,y1] and [x2,y2]"
  (sqrt (+ (expt (- x1 x2) 2)
	   (expt (- y1 y2) 2))))

