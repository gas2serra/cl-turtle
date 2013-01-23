(defpackage #:cl-turtle-system
  (:use :common-lisp :asdf))

(in-package #:cl-turtle-system)

(defsystem cl-turtle
    :author "Alessandro Serra (seralessandro@gmail.com)"
    :licence "GPL"
    :version "0.1"
    :components (
		 (:module "core"
			  :components (
				       (:file "package")
				       (:file "utilities" 
					      :depends-on ("package"))
				       (:file "surface"
					      :depends-on ("package"))
				       (:file "path"
					      :depends-on ("package"))
				       (:file "style"
					      :depends-on ("package"))
				       (:file "turtle" 
					      :depends-on ("utilities" "surface" "path" "style"))))
		 (:module "logo"
			  :components (
				       (:file "logo-package")
				       (:file "logo" :depends-on ("logo-package")))
			  :depends-on ("core")))
    :depends-on ("cl-colors"))
