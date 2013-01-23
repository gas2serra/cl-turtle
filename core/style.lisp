(in-package :cl-turtle)

(defclass style ()
  ((width :initform 1
	  :initarg :width
	  :accessor style-width
	  :type integer
	  :documentation "")
   (color :initform (cl-colors:add-alpha cl-colors:+darkgoldenrod+ 0.5)
	  :initarg :color
	  :accessor style-color
	  :type (or cl-colors:rgba cl-colors:rgb)
	  :documentation "")
   (linecap :initform :butt
	    :initarg :linecap
	    :accessor style-linecap
	    :type (member :butt :round :square)
	    :documentation "")
   (linejoin :initform :miter
	     :initarg :linejoin
	     :accessor style-linejoin
	     :type (member :miter :round :bevel)
	     :documentation "")
   (miterlimit :initform 4
	       :initarg :miterlimit
	       :accessor style-miterlimit
	       :type integer
	       :documentation "")
   (dasharray :initform nil ;#(5 1 3 3)
	      :initarg :dash-array
	      :accessor style-dasharray
	      :type array
	      :documentation "")
   (dashoffset :initform 0
	       :initarg :dashoffset
	       :accessor style-dashoffset
	       :type integer
	       :documentation ""))
  (:documentation ""))


(defun style-get-attribute (style attr)
  (case attr
    (:width (style-width style))
    (:color (style-color style))
    (:linecap (style-linecap style))
    (:linejoin (style-linejoin style))
    (:miterlimit (style-miterlimit style))
    (:dasharray (style-dasharray style))
    (:dahsoffset (style-dashoffset style))))
;manca error

(defun style-set-attribute (style attr value)
  (case attr
    (:width (setf (style-width style) value))
    (:color (setf (style-color style) value))
    (:linecap (setf (style-linecap style) value))
    (:linejoin (setf (style-linejoin style) value))
    (:miterlimit (setf (style-miterlimit style) value))
    (:dasharray (setf (style-dasharray style) value))
    (:dahsoffset (setf (style-dashoffset style) value))))
;manca error

(defun style-clone (style)
  (make-instance 'style 
		 :width (style-width style)
		 :color (style-color style)
		 :linecap (style-linecap style)
		 :linejoin (style-linejoin style)
		 :miterlimit (style-miterlimit style)
		 :dashoffset (style-dashoffset style)))
