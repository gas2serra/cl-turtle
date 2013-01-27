(in-package :cl-turtle)

;
; the pen (immutable object) used to draw 
;
(defclass pen ()
  ((width :initform 1
	  :initarg :width
	  :reader pen-width
	  :type integer
	  :documentation "the line thickness")
   (color :initform (cl-colors:add-alpha cl-colors:+darkgoldenrod+ 0.5)
	  :initarg :color
	  :reader pen-color
	  :type (or cl-colors:rgba cl-colors:rgb)
	  :documentation "the line color")
   (linecap :initform :butt
	    :initarg :linecap
	    :reader pen-linecap
	    :type (member :butt :round :square)
	    :documentation "The decoration applied to the ends of unclosed paths segments")
   (linejoin :initform :miter
	     :initarg :linejoin
	     :reader pen-linejoin
	     :type (member :miter :round :bevel)
	     :documentation "The decoration applied at the intersection of two path segments")
   (miterlimit :initform 4
	       :initarg :miterlimit
	       :reader pen-miterlimit
	       :type integer
	       :documentation "The limit to trim a line join that has a JOIN_MITER decoration")
   (dasharray :initform nil ;#(5 1 3 3)
	      :initarg :dasharray
	      :reader pen-dasharray
	      :type array
	      :documentation "The array representing the lengths of the dash segments")
   (dashoffset :initform 0
	       :initarg :dashoffset
	       :reader pen-dashoffset
	       :type integer
	       :documentation ""))
  (:documentation ""))

(defmethod print-object ((obj pen) stream)
  (print-unreadable-object (obj stream :type t)
    (with-slots (width color linecap linejoin miterlimit dasharray dashoffset) obj
      (format stream "width: ~a  color: ~a  linecap: ~a  linejoin: ~a  miterlimit: ~a  dasharray: ~a  dashoffset: ~a" width color linecap linejoin miterlimit dasharray dashoffset))))

(defun pen-get-attribute (pen attr)
  "Returns the value of the given attribute"
  (case attr
    (:width (pen-width pen))
    (:color (pen-color pen))
    (:linecap (pen-linecap pen))
    (:linejoin (pen-linejoin pen))
    (:miterlimit (pen-miterlimit pen))
    (:dasharray (pen-dasharray pen))
    (:dahsoffset (pen-dashoffset pen))
    (otherwise (error "~A is an invalid pen-style attribute~%" attr))))

(defun pen-clone (pen props)
  "Clones the pen setting properties"
  (let ((p (copy-list props)))
    (when (null (getf props :width))
      (setf (getf p :width) (pen-width pen)))
    (when (null (getf props :color))
      (setf (getf p :color) (pen-color pen)))
    (when (null (getf props :linecap))
      (setf (getf p :linecap) (pen-linecap pen)))
    (when (null (getf props :linejoin))
      (setf (getf p :linejoin) (pen-linejoin pen)))
    (when (null (getf props :miterlimit))
      (setf (getf p :miterlimit) (pen-miterlimit pen)))
    (when (null (getf props :dasharray))
      (setf (getf p :dasharray) (pen-dasharray pen)))	
    (when (null (getf props :dashoffset))
      (setf (getf p :dashoffset) (pen-dashoffset pen)))
    (apply #'make-instance 'pen p)))


