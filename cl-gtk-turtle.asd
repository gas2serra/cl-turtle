(defpackage #:cl-gtk-turtle-system
  (:use :common-lisp :asdf))

(in-package #:cl-gtk-turtle-system)

(defsystem cl-gtk-turtle
    :author "Alessandro Serra (seralessandro@gmail.com)"
    :licence "GPL"
    :version "0.1"
    :components (
		 (:module "gtk-backend"
			  :components (
				       (:file "gtk-package")
				       (:file "gtk-window"
					      :depends-on ("gtk-package"))
				       (:file "gtk-surface"
					      :depends-on ("gtk-window"))
				       (:file "gtk-turtle"
					      :depends-on ("gtk-surface")))))
    :depends-on ("cl-cairo-turtle" "cl-gtk2-gtk" "cl-gtk2-cairo"))
