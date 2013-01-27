(in-package :cl-gtk-turtle)

;
; A gtk surface
;
(defclass cairo-x11-surface (cairo-surface)
  (context))

(defmethod initialize-instance ((surface cairo-x11-surface) &key)
  (call-next-method)
  (setf (slot-value surface 'context) 
	(cl-cairo2:create-xlib-image-context (surface-width surface) (surface-height surface) :display-name ":0")))

(defmethod surface-destroy ((surface cairo-x11-surface))
  (cl-cairo2:destroy (slot-value surface 'context))
  (call-next-method))

(defmethod surface-resize ((surface cairo-x11-surface) width height)
  (call-next-method)
  (cl-cairo2:destroy (slot-value surface 'context))
  (setf (slot-value surface 'context) 
	  (cl-cairo2:create-xlib-image-context (surface-width surface) (surface-height surface) :display-name ":0"))
  (surface-clear surface))

(defmethod surface-clear ((surface gtk-surface))
  (call-next-method)
  (cairo-x11-surface-update surface)
  (cairo-x11-surface-update-turtle surface nil))

; updating
(defun cairo-x11-surface-update (surface)
  (cairo:with-context ((slot-value surface 'context))
    (cairo:set-source-surface 
     (cairo-surface-surface surface 0 0))
    (cairo:paint)
    (cairo:set-source-surface 
     (cl-cairo-turtle::cairo-surface-tmp-surface surface) 0 0)
    (cairo:paint)))

(defun cairo-x11-surface-update-turtle (surface turtle)
  )

