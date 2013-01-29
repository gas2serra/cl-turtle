(in-package :cl-turtle)

; default slots of the surface
(defconstant +default-surface-width+ 400)
(defconstant +default-surface-height+ 400)
(defconstant +default-surface-color+ cl-colors:+whitesmoke+)

;
; A surface where turtles can play
;
(defclass surface ()
  ((width 
    :initform +default-surface-width+
    :initarg :width 
    :reader surface-width
    :documentation "the width of the surface")
   (height 
    :initform +default-surface-height+
    :initarg :height
    :reader surface-height
    :documentation "the height of the surface")
   (color
    :initform +default-surface-color+
    :initarg :color
    :accessor surface-color
    :type cl-colors:rgb
    :documentation "the color of the surface")
   (turtle
    :initform nil
    :initarg :turtle
    :reader surface-turtle
    :type turtle
    :documentation "the turtle playing in this surface")
   (trail 
    :initform nil
    :type path
    :reader surface-trail
    :documentation "an incomplete path")
   (paths
    :initform nil
    :type list
    :reader surface-paths
    :documentation "the paths to be drawn in the surface"))
  (:documentation "A surface"))

; saving
(defvar *ext->save-as-fn* (make-hash-table :test #'equal) 
  "the mapping between the ext type of filename and the function that saves it")

; initializing
(defmethod initialize-instance :after ((surface surface) &key)
  (setf (slot-value (surface-turtle surface) 'surface) surface)
  nil)

; paths adding
(defgeneric surface-add-path (surface path)
  (:method ((surface surface) path)
    (push path (slot-value surface 'paths))))
(defun surface-ordered-paths (surface)
  (reverse (surface-paths surface)))

; incomplete path
(defgeneric surface-clear-trail (surface)
  (:method ((surface surface))
    (setf (slot-value surface 'trail) nil)))
(defgeneric surface-add-point-into-trail (surface x y)
  (:method ((surface surface) x y)
    (path-add-point (surface-trail surface) (list x y))))
(defgeneric surface-new-trail (surface pen x y)
  (:method ((surface surface) pen x y)
    (setf (slot-value surface 'trail) 
	  (make-instance 'path :pen pen
			 :points (list (list x y))))))
(defgeneric surface-trail-completed (surface)
  (:method ((surface surface))
    (let ((path (surface-trail surface)))
      (when path
	(surface-clear-trail surface)
	(surface-add-path surface path)))))

    
; clearing and saving
(defgeneric surface-clear (surface)
  (:method ((surface surface))
    (setf (slot-value surface 'paths) nil)
    (surface-clear-trail surface)))
(defgeneric surface-reset (surface)
  (:method ((surface surface))
    (surface-clear surface)
    (turtle-reset (surface-turtle surface))))
(defgeneric surface-save-as (surface filename)
  (:method ((surface surface) filename)
    (let ((fn (gethash (pathname-type (pathname filename)) *ext->save-as-fn*)))
      (if fn
	  (funcall fn surface filename)
	  (error "Impossible to save the surface into ~A of type ~A" filename (pathname-type (pathname filename)))))))

; destroing
(defgeneric surface-destroy (surface)
  (:method ((surface surface))
    (setf (slot-value (surface-turtle surface) 'surface) nil)
    (setf (slot-value surface 'turtle) nil)))
