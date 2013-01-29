(in-package :cl-svg-turtle)

(defparameter *max-distance-to-close-path* 1)

;
; plotting a path
;
(defun svg-plot-path (scene path width height)
  (labels ((x->pos (x) (+ (/ width 2) x))
	   (y->pos (y) (- (/ height 2) y)))
    (when path 
      (let ((pen (cl-turtle:path-pen path))
	    (path (cl-turtle:path-ordered-points path))
	    (svgp (svg:make-path)))
	;(cairo-set-pen pen)
	(let ((x1 (x->pos (first (car path))))
	      (y1 (y->pos (second (car path)))))
	  (svg:with-path svgp (svg:move-to  (round x1) (round y1)))
	  (let ((x x1)
		(y y1))
	    (dolist (point (cdr path))
	      (setf x (x->pos (first point)))
	      (setf y (y->pos (second point)))
	      (svg:with-path svgp (svg::line-to (round x) (round y))))
	    (when (< (turtle:points-distance x1 y1 x y) 
		     *max-distance-to-close-path*)
	      (svg:with-path svgp (svg:close-path)))))
	(if (pen-dash-array pen)
	    (svg:draw scene (:path :d svgp) 
		      :stroke (format nil "rgb(~{~a%~^, ~})" (svg-color (pen-color pen)))
		      :stroke-opacity (pen-alpha pen)
		      :stroke-dasharray (format nil "~{~a%~^, ~})" 
						(map 'list #'(lambda (x) x) (pen-dash-array pen)))
		      :stroke-dashoffset (pen-dash-offset pen)
		      :stroke-linecap (format nil "~(~a~)" (pen-line-cap pen))
		      :stroke-linejoin (format nil "~(~a~)" (pen-line-join pen))
		      :stroke-miterlimit (pen-miter-limit pen)
		      :stroke-width (pen-width pen) 
		      :fill "none")
	    (svg:draw scene (:path :d svgp) 
		      :stroke (format nil "rgb(~{~a%~^, ~})" (svg-color (pen-color pen)))
		      :stroke-opacity (pen-alpha pen)
		      :stroke-linecap (format nil "~(~a~)" (pen-line-cap pen))
		      :stroke-linejoin (format nil "~(~a~)" (pen-line-join pen))
		      :stroke-miterlimit (pen-miter-limit pen)
		      :stroke-width (pen-width pen) 
		      :fill "none"))))))


(defun svg-color (color)
  (ctypecase color
    (cl-colors:rgb 
     (list (coerce (* 100 (cl-colors:rgb-red color)) 'float)
	   (coerce (* 100 (cl-colors:rgb-green color)) 'float)
	   (coerce (* 100 (cl-colors:rgb-blue color)) 'float)))
    (list
     (list (coerce (* 100 (first color)) 'float)
	   (coerce (* 100 (second color)) 'float)
	   (coerce (* 100 (third color)) 'float)))))
