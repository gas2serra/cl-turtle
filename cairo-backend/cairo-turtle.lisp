(in-package :cl-cairo-turtle)

;
; A turtle that display its movement into the console
;
(defclass cairo-turtle (turtle)
  ())

; moving
(defmethod turtle:turtle-move :around ((turtle cairo-turtle) distance)
  (if (eq (turtle-pen-position turtle) :up)
      (call-next-method)
      (let ((x1 (x->pos turtle))
	    (y1 (y->pos turtle)))
	(call-next-method)
	(let ((x2 (x->pos turtle))
	      (y2 (y->pos turtle)))
	  (with-cairo-surface ((turtle-surface turtle)) 
	    (set-source-color (turtle-pen-color turtle))
	    (cl-cairo2:set-line-width (turtle-pen-width turtle))
	    (cl-cairo2:move-to x1 y1)
	    (cl-cairo2:line-to x2 y2)
	    (cl-cairo2:stroke))))))
