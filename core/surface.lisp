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
   (turtles
    :initform nil
    :reader surface-turtles
    :documentation "turtles playing in this surface")
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
  (surface-clear surface))
(defgeneric surface-resize (surface width height)
  (:method ((surface surface) width height)
    (setf (slot-value surface 'width) width)
    (setf (slot-value surface 'height) height)))

; turtles adding and removing
(defgeneric surface-add-turtle (surface turtle)
  (:method ((surface surface) turtle)
    (push turtle (slot-value surface 'turtles))
    (setf (slot-value turtle 'surface) surface)))
(defgeneric surface-remove-turtle (surface turtle)
  (:method ((surface surface) turtle)
    (setf (slot-value surface 'turtles)
	  (delete turtle (slot-value surface 'turtles)))
    (setf (slot-value turtle 'surface) nil)))

; paths adding
(defgeneric surface-add-path (surface path)
  (:method ((surface surface) path)
    (push path (slot-value surface 'paths))))
(defun surface-ordered-paths (surface)
  (reverse (surface-paths surface)))

; clearing and saving
(defgeneric surface-clear (surface)
  (:method ((surface surface))
    (setf (slot-value surface 'paths) nil)
    (dolist (turtle (surface-turtles surface) nil)
      (turtle-clear-trail turtle))))
(defgeneric surface-reset (surface)
  (:method ((surface surface))
    (surface-clear surface)
    (dolist (turtle (surface-turtles surface) nil)
      (turtle-reset turtle))))
(defgeneric surface-save-as (surface filename)
  (:method ((surface surface) filename)
    (let ((fn (gethash (pathname-type (pathname filename)) *ext->save-as-fn*)))
      (if fn
	  (funcall fn surface filename)
	  (error "Impossible to save the surface into ~A of type ~A" filename (pathname-type (pathname filename)))))))

; destroing
(defgeneric surface-destroy (surface)
  (:method ((surface surface))
    (surface-clear surface)
    (dolist (turtle (surface-turtles surface))
      (setf (slot-value turtle 'surface) nil))
    (setf (slot-value surface 'turtles) nil)))
