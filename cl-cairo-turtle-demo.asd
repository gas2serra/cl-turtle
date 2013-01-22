(defpackage #:cl-cairo-turtle-demo-system
  (:use :common-lisp :asdf))

(in-package #:cl-cairo-turtle-demo-system)

(defsystem cl-cairo-turtle-demo
    :author "Alessandro Serra (seralessandro@gmail.com)"
    :licence "GPL"
    :version "0.1"
    :components (
		 (:module "cairo-backend"
			  :components (
				       (:file "cairo-demo"))))
    :depends-on ("cl-cairo-turtle"))
