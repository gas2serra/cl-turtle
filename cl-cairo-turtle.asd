(defpackage #:cl-cairo-turtle-system
  (:use :common-lisp :asdf))

(in-package #:cl-cairo-turtle-system)

(defsystem cl-cairo-turtle
    :author "Alessandro Serra (seralessandro@gmail.com)"
    :licence "GPL"
    :version "0.1"
    :components (
		 (:module "cairo-backend"
			  :components (
				       (:file "cairo-package")
				       (:file "cairo-utilities"
					      :depends-on ("cairo-package"))
				       (:file "cairo-surface"
					      :depends-on ("cairo-utilities"))
				       (:file "cairo-turtle"
					      :depends-on ("cairo-utilities"))
				       (:file "cairo-save" 
					      :depends-on ("cairo-package" "cairo-utilities" "cairo"))
				       (:file "cairo" 
					      :depends-on ("cairo-package")))))
    :depends-on ("cl-turtle" "cl-cairo2"))
