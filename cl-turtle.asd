#|
  This file is a part of cl-turtle-2d project.
  Copyright (c) 2015 Alessandro Serra (gas2serra@gmail.com)
|#

#|
  Author: Alessandro Serra (gas2serra@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-turtle-asd
  (:use :common-lisp :asdf))
(in-package cl-turtle-asd)

(defsystem cl-turtle
    :author "Alessandro Serra (gas2serra@gmail.com)"
    :licence "GPLv3"
    :version "0.1"
    :depends-on ("cl-colors")
    :components (
		 (:module "src/core"
			  :components (
				       (:file "package")
				       (:file "utilities" 
					      :depends-on ("package"))
				       (:file "surface"
					      :depends-on ("package" "utilities" "path"))
				       (:file "path"
					      :depends-on ("package"))
				       (:file "pen"
					      :depends-on ("package"))
				       (:file "turtle" 
					      :depends-on ("package" "utilities" "surface" "path" "pen"))))
		 ;(:module "src/logo"
		;	  :depends-on ("src/core")
		;	  :components (
		;		       (:file "logo-package")
		;		       (:file "logo" :depends-on ("logo-package"))))
		 (:module "src"
			  :depends-on ("src/core" ;"src/logo"
				       )
			  :components (
				       (:file "cl-turtle")
				       (:file "api" :depends-on ("cl-turtle"))))
		 )
    :description ""
    :long-description
    #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
			      :if-does-not-exist nil
			      :direction :input)
	(when stream
	  (let ((seq (make-array (file-length stream)
				 :element-type 'character
				 :fill-pointer t)))
	    (setf (fill-pointer seq) (read-sequence seq stream))
	    seq)))
    :in-order-to ((test-op (test-op cl-turtle-test))))
