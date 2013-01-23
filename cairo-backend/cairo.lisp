
(in-package :cl-cairo-turtle)

(defun set-source-color (color)
  (if (typep color 'cl-colors:rgba)
      (cl-cairo2:set-source-rgba (cl-colors:red color) 
				 (cl-colors:green color) 
				 (cl-colors:blue color)
				 (cl-colors:alpha color))
      (cl-cairo2:set-source-rgb (cl-colors:red color) 
				(cl-colors:green color) 
				(cl-colors:blue color))))



(defun cairo-save-as-png (surface filename)
  (let* ((surf (cl-cairo2:create-image-surface :ARGB32
					       (surface-width surface)
					       (surface-height surface)))
	 (context (cl-cairo2:create-context surf)))
    (let ((cl-cairo2:*context* context))
      (set-source-color (surface-color surface))
      (cl-cairo2:paint)
      (dolist (turtle (surface-turtles surface))
	(plot-turtle turtle (surface-width surface) (surface-height surface))))
    (cl-cairo2:surface-write-to-png surf filename)
    (cl-cairo2:destroy context)
    (cl-cairo2:destroy surf)))
	   

(defun plot-turtle (turtle width height)
  (dolist (path (reverse (cl-turtle::turtle-trail turtle)))
    (plot-path path width height)))

(defun plot-path (path width height)
  (labels ((x->pos (x)
	     (+ (/ width 2) x))
	   (y->pos (y)
	     (- (/ height 2) y)))
    (let ((style (cl-turtle::path-style path))
	  (path (reverse (cl-turtle::path-points path))))
      (set-source-color (getf style :color))
      (cl-cairo2:set-line-width (getf style :width))
      (cl-cairo2:move-to  (x->pos (first (car path)))
			  (y->pos (second (car path))))
      (dolist (point (cdr path))
	(cl-cairo2:line-to (x->pos (first point))
			   (y->pos (second point))))
      (cl-cairo2:stroke))))

(setf 
 (gethash "png" turtle::*ext->save-as-fn*) 
 #'cairo-save-as-png)