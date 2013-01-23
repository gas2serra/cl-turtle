(in-package :cl-turtle)

;
; saving
;

(defvar *ext->save-as-fn* (make-hash-table :test #'equal) 
  "the mapping between the ext type of filename and the function that saves it")

;
; A surface where turtles can play
;
(defclass surface ()
  ((width 
    :initform 400
    :initarg :width 
    :reader surface-width
    :documentation "the width of the surface")
   (height 
    :initform 400
    :initarg :height
    :reader surface-height
    :documentation "the height of the surface")
   (color
    :initform cl-colors:+whitesmoke+
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

(defmethod initialize-instance :after ((surface surface) &key)
  )

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
