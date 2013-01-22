(in-package :cl-cairo-turtle)

; turtle pos into cairo surface positions
(defun x->pos (tr)
  (+ (/ (surface-width (turtle-surface tr)) 2) (turtle-x tr)))

(defun y->pos (tr)
  (- (/ (surface-height (turtle-surface tr)) 2) (turtle-y tr)))

(defun set-source-color (color)
  (if (typep color 'cl-colors:rgba)
      (cl-cairo2:set-source-rgba (cl-colors:red color) 
				 (cl-colors:green color) 
				 (cl-colors:blue color)
				 (cl-colors:alpha color))
      (cl-cairo2:set-source-rgb (cl-colors:red color) 
				(cl-colors:green color) 
				(cl-colors:blue color))))

