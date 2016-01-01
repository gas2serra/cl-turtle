#|
  This file is a part of cl-turtle project.
  Copyright (c) 2015 Alessandro Serra (gas2serra@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-turtle-examples-asd
  (:use :cl :asdf))
(in-package :cl-turtle-examples-asd)

(defsystem cl-turtle-examples
  :author "Alessandro Serra"
  :license "GPLv3"
  :depends-on (:cl-turtle :cl-svg-turtle)
  :components ((:module "examples"
                :components
                ((:file "recursive-pictures" :depends-on ("cl-turtle-examples"))
		 (:file "style" :depends-on ("cl-turtle-examples"))
		 (:file "trees" :depends-on ("cl-turtle-examples"))
		 (:file "cl-turtle-examples"))))
  :description "Examples for cl-turtle")
