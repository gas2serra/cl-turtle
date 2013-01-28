(in-package :cl-cairo-turtle)

;
; saving functions
;
(defun cairo-save-as-png (surface filename)
  (let* ((cairo-surface (cl-cairo2:create-image-surface :ARGB32
					       (surface-width surface)
					       (surface-height surface))))
    (cairo-save-as cairo-surface surface)
    (cl-cairo2:surface-write-to-png cairo-surface (namestring filename))
    (cl-cairo2:destroy cairo-surface)))
(defun cairo-save-as-svg (surface filename) 
  (let* ((cairo-surface (cl-cairo2:create-svg-surface (namestring filename)
						      (surface-width surface)
						      (surface-height surface))))
    (cairo-save-as cairo-surface surface)
    (cl-cairo2:destroy cairo-surface)))
(defun cairo-save-as-pdf (surface filename) 
  (let* ((cairo-surface (cl-cairo2:create-pdf-surface (namestring filename)
						      (surface-width surface)
						      (surface-height surface))))
    (cairo-save-as cairo-surface surface)
    (cl-cairo2:destroy cairo-surface)))
(defun cairo-save-as-ps (surface filename) 
  (let* ((cairo-surface (cl-cairo2:create-ps-surface (namestring filename)
						     (surface-width surface)
						     (surface-height surface))))
    (cairo-save-as cairo-surface surface)
    (cl-cairo2:destroy cairo-surface)))

;
; cairo-save-as
;
(defun cairo-save-as (cairo-surface surface) 
  (let ((cl-cairo2:*context* (cl-cairo2:create-context cairo-surface)))
    (cairo-set-color (surface-color surface))
    (cl-cairo2:paint)
    (dolist (path (cl-turtle:surface-ordered-paths surface))
      (cairo-plot-path path (surface-width surface) (surface-height surface)))
    (dolist (turtle (cl-turtle:surface-turtles surface))
      (cairo-plot-path (cl-turtle:turtle-trail turtle) (surface-width surface) (surface-height surface)))
    (cl-cairo2:destroy cl-cairo2:*context*)))

;
; register saving functions
;
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
  