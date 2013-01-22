(in-package :cl-turtle)

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
    :documentation "turtles playing in this surface"))
  (:documentation "A surface"))

(defmethod initialize-instance :after ((surface surface) &key)
  (surface-clear surface))

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

; clearing and saving
(defgeneric surface-clear (surface)
  (:method ((surface surface))
    (dolist (turtle (surface-turtles surface) nil)
      (turtle-clear-trail turtle))))

(defgeneric surface-save-as (surface filename)
  )

; destroing
(defgeneric surface-destroy (surface)
  (:method ((surface surface))
    (surface-clear surface)
    (dolist (turtle (surface-turtles surface))
      (setf (slot-value turtle 'surface) nil))
    (setf (slot-value surface 'turtles) nil)))
