(defpackage #:cl-svg-turtle-system
  (:use :common-lisp :asdf))

(in-package #:cl-svg-turtle-system)

(defsystem cl-svg-turtle
    :author "Alessandro Serra (gas2serra@gmail.com)"
    :licence "GPL"
    :version "0.1"
    :components (
		 (:module "svg-backend"
			  :components (
				       (:file "svg-package")
				       (:file "svg-save" 
					      :depends-on ("svg-package" "svg"))
				       (:file "svg" 
					      :depends-on ("svg-package")))))
    :depends-on ("cl-turtle" "cl-svg"))
