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
	(let ((x1 (x->pos (first (car path))))
	      (y1 (y->pos (second (car path)))))
	  (svg:with-path svgp (svg:move-to  (round x1) (round y1)))
	  (let ((x x1)
		(y y1))
	    (dolist (point (cdr path))
	      (setf x (x->pos (first point)))
	      (setf y (y->pos (second point)))
	      (svg:with-path svgp (svg::line-to (round x) (round y))))
	    (when (< (turtle:points-distance x1 y1 x y) *max-distance-to-close-path*)
	      (svg:with-path svgp (svg:close-path)))))
	(cl-svg:add-element scene (cl-svg::make-svg-element :path (append (list :d svgp) (svg-pen pen))))))))

(defun svg-pen (pen)
  (let ((props 
	 (list 
	  :stroke (format nil "rgb(~{~a%~^, ~})" (svg-color (pen-color pen)))
	  :stroke-opacity (pen-alpha pen)
	  :stroke-linecap (format nil "~(~a~)" (pen-line-cap pen))
	  :stroke-linejoin (format nil "~(~a~)" (pen-line-join pen))
	  :stroke-miterlimit (pen-miter-limit pen)
	  :stroke-width (pen-width pen) 
	  :fill "none")))
    (if (pen-dash-array pen)
	(append 
	 (list 
	  :stroke-dasharray (format nil "~{~a%~^, ~})" 
				    (map 'list #'(lambda (x) x) (pen-dash-array pen)))
	  :stroke-dashoffset (pen-dash-offset pen))
	 props)
	props)))

(defun svg-color (color)
  (mapcar #'(lambda (x) (coerce (* 100 x) 'float))
	  (ctypecase color
	    (cl-colors:rgb 
	     (list (cl-colors:rgb-red color)
		   (cl-colors:rgb-green color)
		   (cl-colors:rgb-blue color)))
	    (list
	     color))))
