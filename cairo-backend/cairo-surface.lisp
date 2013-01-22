(in-package :cl-cairo-turtle)

;
; A cairo surface
;
(defclass cairo-surface (surface)
  ((surface
    :initform nil
    :reader cairo-surface-surface
    :documentation "the cairo's surface")
   (context 
    :initform nil
    :reader cairo-surface-context
    :documentation "the cairo's context"))
  (:documentation "A cairo surface"))

; initialize
(defmethod initialize-instance ((surface cairo-surface) &key)
  (call-next-method)
  (setf (slot-value surface 'surface) 
	(cl-cairo2:create-image-surface :ARGB32
					(surface-width surface)
					(surface-height surface)))
  (setf (slot-value surface 'context)
	(cl-cairo2:create-context (cairo-surface-surface surface))))
 
(defmacro with-cairo-surface ((surface) &body body)
  `(let ((cl-cairo2:*context* (cairo-surface-context ,surface)))
     ,@body))

(defmethod surface-destroy ((surface cairo-surface))
  (cl-cairo2:destroy (cairo-surface-surface surface))
  (cl-cairo2:destroy (cairo-surface-context surface))
  (call-next-method))

(defmethod surface-clear ((surface cairo-surface))
  (with-cairo-surface (surface) 
    (set-source-color (surface-color surface))
    (cl-cairo2:paint)))

(defmethod surface-resize ((surface cairo-surface) width height)
  (call-next-method)
  (cl-cairo2:destroy (cairo-surface-surface surface))
  (cl-cairo2:destroy (cairo-surface-context surface))
  (setf (slot-value surface 'surface) 
	(cl-cairo2:create-image-surface :ARGB32
					(surface-width surface)
					(surface-height surface)))
  (setf (slot-value surface 'context)
	(cl-cairo2:create-context (cairo-surface-surface surface))))

(defmethod surface-save-as-png ((surface cairo-surface) filename)
  (cl-cairo2:surface-write-to-png 
   (cairo-surface-surface surface)
   filename))
