(in-package :cl-cairo-turtle)

;
; A turtle that display its movement into the console
;
(defclass cairo-turtle (turtle)
  ())

; moving
(defmethod turtle:turtle-move :around ((turtle cairo-turtle) distance)
      (call-next-method)
      (let ((surface (turtle-surface turtle)))
	(with-cairo-tmp-surface (surface)
	  (plot-path (turtle-trail turtle) (surface-width surface) (surface-height surface)))))
