(in-package :cl-user)

(defpackage cl-turtle-examples
  (:use :cl
        :cl-turtle
	:cl-turtle.picture)
  (:export
   :*ext*
   :run
   :run-recursive
   :run-style
   :run-tree
   ))


(in-package :cl-turtle-examples)

(defvar *ext* "svg")

(defvar *examples-path*
  (merge-pathnames #p"examples/"
		   (asdf:system-source-directory :cl-turtle-examples)))

(defun run (ext)
  (let ((*ext* ext))
    (run-recursive)
    (run-style)
    (run-tree)))
