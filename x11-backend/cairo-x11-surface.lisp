(in-package :cl-cairo-x11-turtle)

;
; A gtk surface
;
(defclass cairo-x11-surface (cairo-surface)
  (context2))

(defmethod initialize-instance ((surface cairo-x11-surface) &key)
  (call-next-method)
  (setf (slot-value surface 'context2) 
	(cl-cairo2:create-xlib-image-context (surface-width surface) (surface-height surface) :display-name ":0")))

(defmethod cl-turtle:surface-destroy ((surface cairo-x11-surface))
  (call-next-method)
  (cl-cairo2:destroy (slot-value surface 'context2)))

(defmethod cl-turtle:surface-resize ((surface cairo-x11-surface) width height)
  (call-next-method)
  (cl-cairo2:destroy (slot-value surface 'context2))
  (setf (slot-value surface 'context2) 
	  (cl-cairo2:create-xlib-image-context (surface-width surface) (surface-height surface) :display-name ":0"))
  (surface-clear surface))

(defmethod cl-turtle:surface-clear ((surface cairo-x11-surface))
  (call-next-method)
  (cairo-x11-surface-update surface))

(defmethod cl-turtle:surface-add-path ((surface cairo-x11-surface) path)
  (call-next-method)
  (cairo-x11-surface-update surface))


; updating
(defun cairo-x11-surface-update (surface)
  (cairo:with-context ((slot-value surface 'context2))
    (cl-cairo-turtle::cairo-surface-paint-to surface)))


