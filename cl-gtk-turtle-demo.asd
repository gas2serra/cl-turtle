(defpackage #:cl-gtk-turtle-demo-system
  (:use :common-lisp :asdf))

(in-package #:cl-gtk-turtle-demo-system)

(defsystem cl-gtk-turtle-demo
    :author "Alessandro Serra (seralessandro@gmail.com)"
    :licence "GPL"
    :version "0.1"
    :components (
		 (:module "gtk-backend"
			  :components (
				       (:file "gtk-demo"))))
    :depends-on ("cl-gtk-turtle"))
