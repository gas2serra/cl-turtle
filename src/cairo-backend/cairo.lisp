(in-package :cl-cairo-turtle)

(defparameter *max-distance-to-close-path* 1)

;
; plotting a path
;
(defun cairo-plot-path (path width height)
  (labels ((x->pos (x) (+ (/ width 2) x))
	   (y->pos (y) (- (/ height 2) y)))
    (when path 
      (let ((pen (cl-turtle.core:path-pen path))
	    (path (cl-turtle.core:path-ordered-points path)))
	(cairo-set-pen pen)
	(let ((x1 (x->pos (first (car path))))
	      (y1 (y->pos (second (car path)))))
	  (cl-cairo2:move-to  x1 y1)
	  (let ((x x1)
		(y y1))
	    (dolist (point (cdr path))
	      (setf x (x->pos (first point)))
	      (setf y (y->pos (second point)))
	      (cl-cairo2:line-to x y))
	    (when (< (cl-turtle.core:points-distance x1 y1 x y) 
		     *max-distance-to-close-path*)
	      (cl-cairo2:close-path)))
	  (cl-cairo2:stroke))))))

;
; setting cairo stroke style
;
(defun cairo-set-color (color alpha)
  (ctypecase color
    (cl-colors:rgb 
     (if (< alpha 1.0)		  
	 (cl-cairo2:set-source-rgba (cl-colors:rgb-red color) 
				    (cl-colors:rgb-green color) 
				    (cl-colors:rgb-blue color)
				    alpha)
	 (cl-cairo2:set-source-rgb (cl-colors:rgb-red color) 
				   (cl-colors:rgb-green color) 
				   (cl-colors:rgb-blue color))))
    (list
     (let ((n (length color)))
     (ccase n
       (3 
	(if (< alpha 1.0)		  
	    (cl-cairo2:set-source-rgba (first color) 
				       (second color) 
				       (third color)
				       alpha)
	    (cl-cairo2:set-source-rgb (first color) 
				      (second color) 
				      (third color)))))))))

(defun cairo-set-pen (pen)
  (cairo-set-color (cl-turtle.core:pen-color pen) (cl-turtle.core:pen-alpha pen))
  (cl-cairo2:set-operator :over)
  (cl-cairo2:set-line-width (cl-turtle.core:pen-width pen))
  (cl-cairo2:set-line-cap (cl-turtle.core:pen-line-cap pen))
  (cl-cairo2:set-line-join (cl-turtle.core:pen-line-join pen))
  (cl-cairo2:set-miter-limit (cl-turtle.core:pen-miter-limit pen))
  (when (cl-turtle.core:pen-dash-array pen)
    (cl-cairo2:set-dash (cl-turtle.core:pen-dash-offset pen) (cl-turtle.core:pen-dash-array pen))))
