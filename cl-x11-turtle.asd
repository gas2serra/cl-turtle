(defpackage #:cl-x11-turtle-system
  (:use :common-lisp :asdf))

(in-package #:cl-x11-turtle-system)

(defsystem cl-x11-turtle
    :author "Alessandro Serra (gas2serra@gmail.com)"
    :licence "GPL"
    :version "0.1"
    :components (
		 (:module "x11-backend"
			  :components (
				       (:file "x11-package")
				       (:file "x11-surface"
					      :depends-on ("x11-package"))
				       (:file "x11-turtle"
					      :depends-on ("x11-surface")))))
    :depends-on ("cl-cairo-turtle" "cl-cairo2-xlib"))
