(in-package :cl-turtle)

;
; the style of the pen (immutable object)
;

(defclass pen ()
  ((width :initform 1
	  :initarg :width
	  :reader pen-width
	  :type integer
	  :documentation "")
   (color :initform (cl-colors:add-alpha cl-colors:+darkgoldenrod+ 0.5)
	  :initarg :color
	  :reader pen-color
	  :type (or cl-colors:rgba cl-colors:rgb)
	  :documentation "")
   (linecap :initform :butt
	    :initarg :linecap
	    :reader pen-linecap
	    :type (member :butt :round :square)
	    :documentation "")
   (linejoin :initform :miter
	     :initarg :linejoin
	     :reader pen-linejoin
	     :type (member :miter :round :bevel)
	     :documentation "")
   (miterlimit :initform 4
	       :initarg :miterlimit
	       :reader pen-miterlimit
	       :type integer
	       :documentation "")
   (dasharray :initform nil ;#(5 1 3 3)
	      :initarg :dash-array
	      :reader pen-dasharray
	      :type array
	      :documentation "")
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
  (make-instance 'pen 
		 :width (or (getf props :width) (pen-width pen))
		 :color (or (getf props :color) (pen-color pen))
		 :linecap (or (getf props :linecap) (pen-linecap pen))
		 :linejoin (or (getf props :linejoin) (pen-linejoin pen))
		 :miterlimit (or (getf props :miterlimit) (pen-miterlimit pen))
		 :dashoffset (or (getf props :dashoffset) (pen-dashoffset pen))))
