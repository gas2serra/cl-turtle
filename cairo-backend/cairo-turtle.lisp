(in-package :cl-cairo-turtle)

;
; A turtle that display its movement into the console
;
(defclass cairo-turtle (turtle)
  ())

(defmethod turtle:turtle-add-point-into-trail ((turtle cairo-turtle))
  (call-next-method)
  (let ((surface (turtle-surface turtle)))
    (with-cairo-tmp-surface (surface)
      (cairo:set-operator :clear)
      (cairo:paint)
      (dolist (turtle (cl-turtle:surface-turtles surface))
	(cairo-plot-path (cl-turtle:turtle-trail turtle) 
			 (surface-width surface) (surface-height surface))))))


(defmethod turtle:turtle-clear-trail ((turtle cairo-turtle))
  (call-next-method)
  (let ((surface (turtle-surface turtle)))
    (with-cairo-tmp-surface (surface)
      (cairo:set-operator :clear)
      (cairo:paint)
      (dolist (turtle (cl-turtle:surface-turtles surface))
	(cairo-plot-path (cl-turtle:turtle-trail turtle) 
			 (surface-width surface) (surface-height surface))))))
