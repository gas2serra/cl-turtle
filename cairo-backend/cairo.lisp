
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


(defun cairo-save-as (surf surface) 
  (let ((cl-cairo2:*context* (cl-cairo2:create-context surf)))
    (set-source-color (surface-color surface))
    (cl-cairo2:paint)
;    (dolist (turtle (surface-turtles surface))
;      (plot-turtle turtle (surface-width surface) (surface-height surface)))
    (dolist (path (cl-turtle::surface-ordered-paths surface))
      (plot-path path (surface-width surface) (surface-height surface)))
    (cl-cairo2:destroy cl-cairo2:*context*)))

(defun cairo-save-as-png (surface filename)
  (let* ((surf (cl-cairo2:create-image-surface :ARGB32
					       (surface-width surface)
					       (surface-height surface))))
    (cairo-save-as surf surface)
    (cl-cairo2:surface-write-to-png surf filename)
    (cl-cairo2:destroy surf)))

(defun cairo-save-as-svg (surface filename) 
  (let* ((surf (cl-cairo2:create-svg-surface filename
					     (surface-width surface)
					     (surface-height surface))))
    (cairo-save-as surf surface)
    (cl-cairo2:destroy surf)))

(defun cairo-save-as-pdf (surface filename) 
  (let* ((surf (cl-cairo2:create-pdf-surface filename
					     (surface-width surface)
					     (surface-height surface))))
    (cairo-save-as surf surface)
    (cl-cairo2:destroy surf)))

(defun cairo-save-as-ps (surface filename) 
  (let* ((surf (cl-cairo2:create-ps-surface filename
					    (surface-width surface)
					    (surface-height surface))))
    (cairo-save-as surf surface)
    (cl-cairo2:destroy surf)))


(defun plot-turtle (turtle width height)
  (dolist (path (reverse (cl-turtle::turtle-trail turtle)))
    (plot-path path width height)))

(defun plot-path (path width height)
  (labels ((x->pos (x)
	     (+ (/ width 2) x))
	   (y->pos (y)
	     (- (/ height 2) y)))
    (let ((style (cl-turtle:path-style path))
	  (path (cl-turtle:path-ordered-points path)))
      (set-source-color (cl-turtle::style-color style))
      (cl-cairo2:set-line-width (cl-turtle::style-width style))
      (cl-cairo2:set-line-cap (cl-turtle::style-linecap style))
      (cl-cairo2:set-line-join (cl-turtle::style-linejoin style))
      (cl-cairo2:set-miter-limit (cl-turtle::style-miterlimit style))
      (when (cl-turtle::style-dasharray style)
	(cl-cairo2:set-dash (cl-turtle::style-dashoffset style) (cl-turtle::style-dasharray style)))
      (cl-cairo2:move-to  (x->pos (first (car path)))
			  (y->pos (second (car path))))
      (dolist (point (cdr path))
	(cl-cairo2:line-to (x->pos (first point))
			   (y->pos (second point))))
      (cl-cairo2:stroke))))

(progn
  (setf 
   (gethash "png" turtle::*ext->save-as-fn*) 
   #'cairo-save-as-png 
   (gethash "pdf" turtle::*ext->save-as-fn*) 
   #'cairo-save-as-pdf 
   (gethash "ps" turtle::*ext->save-as-fn*) 
   #'cairo-save-as-ps 
   (gethash "svg" turtle::*ext->save-as-fn*) 
   #'cairo-save-as-svg))
  