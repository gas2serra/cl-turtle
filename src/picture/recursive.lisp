(in-package :cl-turtle.picture)

(defun %c-curve (size level)
  (if (= level 0)
      (move-forward size)
      (progn
	(turn 45)
	(%c-curve (* size (sqrt 0.5)) (- level 1))
	(turn -90)
	(%c-curve (* size (sqrt 0.5)) (- level 1))
	(turn 45))))

(defun c-curve (size level &optional (turtle *turtle*))
  (with-turtle (turtle)
    (with-pen-down ()
      (%c-curve size level)))) 

(defun %sierpinski-triangle (size level)
    (unless (= level 0)
      (repeat 3
	      (%sierpinski-triangle (/ size 2) (- level 1))
	      (move-forward size)
	      (turn 120))))

(defun sierpinski-triangle (size level &optional (turtle *turtle*))
  (with-turtle (turtle)
    (with-pen-down ()
      (%sierpinski-triangle size level)))) 

(defun snowflake (size level)
  (if (= level 0)
      (move-forward size)
      (progn
	(snowflake (/ size 3) (- level 1))
	(turn 60)
	(snowflake (/ size 3) (- level 1))
	(turn -120)
	(snowflake (/ size 3) (- level 1))
	(turn 60)
	(snowflake (/ size 3) (- level 1)))))

(defun left-dragon (size level)
  (if (= level 0) 
      (move-forward size)
      (progn 
	(left-dragon size (- level 1))
	(turn 90)
	(right-dragon size (- level 1)))))

(defun right-dragon (size level)
  (if (= level 0) 
      (move-forward size)
      (progn 
	(left-dragon size (- level 1))
	(turn -90)
	(right-dragon size (- level 1)))))

(defun peano (size level &optional (alpha 90))
  (unless (< level 0)
    (progn
      (turn (- alpha))
      (peano size (- level 1) (- alpha))
      (move-forward size)
      (peano size (- level 1) alpha)
      (move-forward size)
      (peano size (- level 1) (- alpha))
      (turn alpha))))

