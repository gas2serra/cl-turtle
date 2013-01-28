(asdf:operate 'asdf:load-op 'cl-cairo-turtle)

(in-package :cl-logo-user)

(defvar *ext* "png")
(defvar *sleep-secs* 0)

(load "test-examples")

(let ((*turtle-class* 'cl-turtle:turtle)
      (*surface-class* 'cl-turtle:surface)
      (*sleep-secs* 0))
  (run))

#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
