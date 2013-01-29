(in-package :cl-x11-turtle)

;
; A gtk surface
;
(defclass x11-surface (turtle:surface)
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
    :documentation "the cairo's tmp context")
   (context2))
  (:documentation "A cairo surface"))

(defmacro with-cairo-surface ((s) &body body)
  `(let ((cl-cairo2:*context* (cairo-surface-context ,s)))
     ,@body))

(defmacro with-cairo-tmp-surface ((s) &body body)
  `(let ((cl-cairo2:*context* (cairo-surface-tmp-context ,s)))
     ,@body))


(defmethod initialize-instance ((surface x11-surface) &key)
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
	(cl-cairo2:create-context (cairo-surface-tmp-surface surface)))
  (setf (slot-value surface 'context2) 
	(cl-cairo2:create-xlib-image-context (surface-width surface) (surface-height surface) :display-name ":0")))

(defmethod cl-turtle:surface-destroy ((surface x11-surface))
  (call-next-method)
  (cl-cairo2:destroy (cairo-surface-surface surface))
  (cl-cairo2:destroy (cairo-surface-context surface))
  (cl-cairo2:destroy (cairo-surface-tmp-surface surface))
  (cl-cairo2:destroy (cairo-surface-tmp-context surface))
  (cl-cairo2:destroy (slot-value surface 'context2)))

(defmethod cl-turtle:surface-clear ((surface x11-surface))
  (call-next-method)
  (with-cairo-surface (surface) 
    (cairo:set-operator :clear)
    (cairo:set-source-color (surface-color surface))
    (cairo:paint))
  (with-cairo-tmp-surface (surface)
    (cairo:set-operator :clear)
    (cairo:paint))
  (x11-surface-update surface))

(defmethod cl-turtle:surface-add-path ((surface x11-surface) path)
  (call-next-method)
  (with-cairo-surface (surface) 
    (cairo-turtle::cairo-plot-path path (surface-width surface) (surface-height surface)))
  (x11-surface-update surface))


(defmethod turtle:surface-clear-trail :after ((surface x11-surface))
  ;(x11-surface-update surface))
  )

(defmethod turtle:surface-add-point-into-trail :after ((surface x11-surface) x y)
  (x11-surface-update surface))
  
(defmethod turtle:surface-add-point-into-trail ((surface x11-surface) x y)
  (call-next-method)
  (with-cairo-tmp-surface (surface)
    (cairo:set-operator :clear)
    (cairo:paint)
    (cairo-turtle::cairo-plot-path (cl-turtle:surface-trail surface) 
				   (surface-width surface) 
				   (surface-height surface))))


(defmethod turtle:surface-clear-trail ((surface x11-surface))
  (call-next-method)
  (with-cairo-tmp-surface (surface)
    (cairo:set-operator :clear)
    (cairo:paint)))


; updating
(defun x11-surface-update (surface)
  (cairo:with-context ((slot-value surface 'context2))
    (cairo-surface-paint-to surface)))


(defgeneric cairo-surface-paint-to (surface)
  (:method ((surface x11-surface))
    (cairo-turtle::cairo-set-color (surface-color surface) 1.0)
    (cairo:set-operator :source)
    (cairo:paint)
    (cairo:set-source-surface 
     (cairo-surface-surface surface) 0 0)
    (cairo:set-operator :over)
    (cairo:paint)
    (cairo:set-source-surface 
     (cairo-surface-tmp-surface surface) 0 0)
    (cairo:set-operator :over)
    (cairo:paint)))

