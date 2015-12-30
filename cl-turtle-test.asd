#|
  This file is a part of cl-turtle project.
  Copyright (c) 2015 Alessandro Serra (gas2serra@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-turtle-test-asd
  (:use :cl :asdf))
(in-package :cl-turtle-test-asd)

(defsystem cl-turtle-test
  :author "Alessandro Serra"
  :license "GPLv3"
  :depends-on (:cl-turtle
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "cl-turtle"))))
  :description "Test system for cl-turtle"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
