(in-package :cl-cairo-turtle)

;
; A cairo surface
;
(defclass cairo-surface (surface)
  ((surface
    :initform nil
    :reader cairo-surface-surface
    :documentation "the cairo's surface")
   (tmp-surface
    :initform nil
    :reader cairo-surface-tmp-surface
    :documentation "the cairo's tmp surface")
   (context 
    :initform nil
    :reader cairo-surface-context
    :documentation "the cairo's context")
   (tmp-context 
    :initform nil
    :reader cairo-surface-tmp-context
    :documentation "the cairo's tmp context"))
  (:documentation "A cairo surface"))

; initialize
(defmethod initialize-instance ((surface cairo-surface) &key)
  (call-next-method)
  (setf (slot-value surface 'surface) 
	(cl-cairo2:create-image-surface :ARGB32
					(surface-width surface)
					(surface-height surface)))
  (setf (slot-value surface 'context)
	(cl-cairo2:create-context (cairo-surface-surface surface)))
  (setf (slot-value surface 'tmp-surface) 
	(cl-cairo2:create-image-surface :ARGB32
					(surface-width surface)
					(surface-height surface)))
  (setf (slot-value surface 'tmp-context)
	(cl-cairo2:create-context (cairo-surface-tmp-surface surface))))


(defmacro with-cairo-surface ((surface) &body body)
  `(let ((cl-cairo2:*context* (cairo-surface-context ,surface)))
     ,@body))

(defmacro with-cairo-tmp-surface ((surface) &body body)
  `(let ((cl-cairo2:*context* (cairo-surface-tmp-context ,surface)))
     ,@body))

(defmethod surface-resize ((surface cairo-surface) width height)
  (call-next-method)
  (cl-cairo2:destroy (cairo-surface-surface surface))
  (cl-cairo2:destroy (cairo-surface-context surface))
  (cl-cairo2:destroy (cairo-surface-tmp-surface surface))
  (cl-cairo2:destroy (cairo-surface-tmp-context surface))
  (setf (slot-value surface 'surface) 
	(cl-cairo2:create-image-surface :ARGB32
					(surface-width surface)
					(surface-height surface)))
  (setf (slot-value surface 'context)
	(cl-cairo2:create-context (cairo-surface-surface surface)))
  (setf (slot-value surface 'tmp-surface) 
	(cl-cairo2:create-image-surface :ARGB32
					(surface-width surface)
					(surface-height surface)))
  (setf (slot-value surface 'tmp-context)
	(cl-cairo2:create-context (cairo-surface-tmp-surface surface))))

(defmethod surface-destroy ((surface cairo-surface))
  (cl-cairo2:destroy (cairo-surface-surface surface))
  (cl-cairo2:destroy (cairo-surface-context surface))
  (cl-cairo2:destroy (cairo-surface-tmp-surface surface))
  (cl-cairo2:destroy (cairo-surface-tmp-context surface))
  (call-next-method))

(defmethod surface-clear ((surface cairo-surface))
  (call-next-method)
  (with-cairo-surface (surface) 
    (set-source-color (surface-color surface))
    (cl-cairo2:paint))
  (with-cairo-tmp-surface (surface)
    ;(set-source-color (make-instance 'cl-colors:rgba :alpha 1.0))
    ;(cl-cairo2:fill-extents)
    (cl-cairo2:set-operator :clear)
    (cl-cairo2:paint)))

(defmethod surface-add-path ((surface cairo-surface) path)
  (call-next-method)
  (with-cairo-surface (surface) 
    (plot-path path (surface-width surface) (surface-height surface)))
  (with-cairo-tmp-surface (surface)
    ;(set-source-color (make-instance 'cl-colors:rgba :alpha 1.0))
    ;(cl-cairo2:fill-extents)
    (cl-cairo2:set-operator :clear)
    (cl-cairo2:paint)))

