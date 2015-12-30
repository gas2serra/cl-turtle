(in-package :cl-svg-turtle)

;
; saving functions
;

(defun svg-save-as-svg (surface filename)
  (let ((scene (svg:make-svg-toplevel 'svg:svg-1.1-toplevel 
				      :height (surface-height surface) 
				      :width (surface-width surface)
				      :viewbox (format nil "0 0 ~A ~A"
						       (surface-width surface)
						       (surface-height surface)))))
    (svg-save-as scene surface)
    (with-open-file (s filename :direction :output :if-exists :supersede)
      (svg:stream-out s scene))))

;
; cairo-save-as
;
(defun svg-save-as (scene surface) 
  (let ((group (svg:make-group scene ())))
    (svg:draw group (:rect :x 0 :y 0 
			   :height (surface-height surface) 
			   :width (surface-width surface)
			   :fill (format nil "rgb(~{~a%~^, ~})" (svg-color (surface-color surface)))))
    (dolist (path (cl-turtle.core:surface-ordered-paths surface))
      (svg-plot-path group path (surface-width surface) (surface-height surface)))
    (svg-plot-path group (surface-trail surface)
		   (surface-width surface) (surface-height surface))))

;
; register saving functions
;
(progn
  (setf 
   (gethash "svg" turtle.core::*ext->save-as-fn*) 
   #'svg-save-as-svg))
  
