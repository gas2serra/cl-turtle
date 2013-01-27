(in-package :cl-cairo-turtle)

;
; plotting a path
;
(defun cairo-plot-path (path width height)
  (labels ((x->pos (x) (+ (/ width 2) x))
	   (y->pos (y) (- (/ height 2) y)))
    (when path 
      (let ((pen (cl-turtle:path-pen path))
	    (path (cl-turtle:path-ordered-points path)))
	(cairo-set-pen pen)
	(cl-cairo2:move-to  (x->pos (first (car path)))
			    (y->pos (second (car path))))
	(dolist (point (cdr path))
	  (cl-cairo2:line-to (x->pos (first point))
			     (y->pos (second point))))
	(cl-cairo2:stroke)))))

;
; setting cairo stroke style
;
(defun cairo-set-color (color)
  (ctypecase color
    (cl-colors:rgba (cl-cairo2:set-source-rgba (cl-colors:red color) 
					       (cl-colors:green color) 
					       (cl-colors:blue color)
					       (cl-colors:alpha color)))
    (cl-colors:rgb (cl-cairo2:set-source-rgb (cl-colors:red color) 
					    (cl-colors:green color) 
					    (cl-colors:blue color)))
    (list
     (ccase (length color)
       (4 (cl-cairo2:set-source-rgba (first color) 
				     (second color) 
				     (third color)
				     (fourth color)))
       (3 (cl-cairo2:set-source-rgb (first color) 
				    (second color) 
				    (third color)))))))

(defun cairo-set-pen (pen)
  (cairo-set-color (cl-turtle:pen-color pen))
  (cl-cairo2:set-operator :over)
  (cl-cairo2:set-line-width (cl-turtle:pen-width pen))
  (cl-cairo2:set-line-cap (cl-turtle:pen-linecap pen))
  (cl-cairo2:set-line-join (cl-turtle:pen-linejoin pen))
  (cl-cairo2:set-miter-limit (cl-turtle:pen-miterlimit pen))
  (when (cl-turtle:pen-dasharray pen)
    (cl-cairo2:set-dash (cl-turtle:pen-dashoffset pen) (cl-turtle:pen-dasharray pen))))
