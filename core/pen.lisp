(in-package :cl-turtle)

; default values
(defconstant +default-pen-width+ 2)
(defconstant +default-pen-color+ (cl-colors:add-alpha cl-colors:+darkgoldenrod+ 0.5))
(defconstant +default-pen-line-cap+ :butt)
(defconstant +default-pen-line-join+ :miter)
(defconstant +default-pen-miter-limit+ 4)
(defconstant +default-pen-dash-array+ nil)
(defconstant +default-pen-dash-offset+ 0)

;
; The pen used to draw (immutable objects)
;
(defclass pen ()
  ((width :initform +default-pen-width+
	  :initarg :width
	  :reader pen-width
	  :type integer
	  :documentation "the line thickness")
   (color :initform +default-pen-color+
	  :initarg :color
	  :reader pen-color
	  :type (or cl-colors:rgba cl-colors:rgb list)
	  :documentation "the line color")
   (line-cap :initform +default-pen-line-cap+
	     :initarg :line-cap
	     :reader pen-line-cap
	     :type (member :butt :round :square)
	     :documentation "the decoration applied to the ends of unclosed paths segments")
   (line-join :initform +default-pen-line-join+
	      :initarg :line-join
	      :reader pen-line-join
	      :type (member :miter :round :bevel)
	      :documentation "the decoration applied at the intersection of two path segments")
   (miter-limit :initform +default-pen-miter-limit+
		:initarg :miter-limit
		:reader pen-miter-limit
		:type integer
		:documentation "the limit to trim a line join that has a JOIN_MITER decoration")
   (dash-array :initform +default-pen-dash-array+
	       :initarg :dash-array
	       :reader pen-dash-array
	       :type array
	       :documentation "the array representing the lengths of the dash segments")
   (dash-offset :initform +default-pen-dash-offset+
		:initarg :dash-offset
		:reader pen-dash-offset
		:type integer
		:documentation "the starting position of the dash array"))
  (:documentation "the pen used to paint the trail of the turtle"))

(defmethod print-object ((obj pen) stream)
  (print-unreadable-object (obj stream :type t)
    (with-slots (width color line-cap line-join miter-limit dash-array dash-offset) obj
      (format stream "width: ~a  color: ~a  line-cap: ~a  line-join: ~a  miter-limit: ~a  dash-array: ~a  dash-offset: ~a" width color line-cap line-join miter-limit dash-array dash-offset))))

(defun pen-get-attribute (pen attr)
  "Returns the value of the given attribute"
  (case attr
    (:width (pen-width pen))
    (:color (pen-color pen))
    (:line-cap (pen-line-cap pen))
    (:line-join (pen-line-join pen))
    (:miter-limit (pen-miter-limit pen))
    (:dash-array (pen-dash-array pen))
    (:dahs-offset (pen-dash-offset pen))
    (otherwise (error "~A is an invalid pen-style attribute~%" attr))))

(defun pen-clone (pen &rest props)
  "Clones the pen setting properties"
  (let ((p (copy-list props)))
    (remf p :pen)
    (when (null (getf props :width))
      (setf (getf p :width) (pen-width pen)))
    (when (null (getf props :color))
      (setf (getf p :color) (pen-color pen)))
    (when (null (getf props :line-cap))
      (setf (getf p :line-cap) (pen-line-cap pen)))
    (when (null (getf props :line-join))
      (setf (getf p :line-join) (pen-line-join pen)))
    (when (null (getf props :miter-limit))
      (setf (getf p :miter-limit) (pen-miter-limit pen)))
    (when (null (getf props :dash-array))
      (setf (getf p :dash-array) (pen-dash-array pen)))	
    (when (null (getf props :dash-offset))
      (setf (getf p :dash-offset) (pen-dash-offset pen)))
    (apply #'make-instance 'pen p)))
