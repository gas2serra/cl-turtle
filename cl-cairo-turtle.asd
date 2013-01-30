(defpackage #:cl-cairo-turtle-system
  (:use :common-lisp :asdf))

(in-package #:cl-cairo-turtle-system)

(defsystem cl-cairo-turtle
    :author "Alessandro Serra (gas2serra@gmail.com)"
    :licence "GPLv3"
    :version "0.1"
    :components (
		 (:module "cairo-backend"
			  :components (
				       (:file "cairo-package")
				       (:file "cairo-save" 
					      :depends-on ("cairo-package" "cairo"))
				       (:file "cairo" 
					      :depends-on ("cairo-package")))))
    :depends-on ("cl-turtle" "cl-cairo2"))
