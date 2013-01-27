(defpackage #:cl-cairo-x11-turtle-system
  (:use :common-lisp :asdf))

(in-package #:cl-cairo-x11-turtle-system)

(defsystem cl-cairo-x11-turtle
    :author "Alessandro Serra (seralessandro@gmail.com)"
    :licence "GPL"
    :version "0.1"
    :components (
		 (:module "cairo-x11-backend"
			  :components (
				       (:file "cairo-x11-package")
				       (:file "cairo-x11-surface"
					      :depends-on ("cairo-x11-package"))
				       (:file "cairo-x11-turtle"
					      :depends-on ("cairo-x11-surface")))))
    :depends-on ("cl-cairo-turtle" "cl-cairo2-xlib"))
