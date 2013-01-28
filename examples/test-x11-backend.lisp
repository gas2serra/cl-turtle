(asdf:operate 'asdf:load-op 'cl-x11-turtle)

(in-package :cl-logo-user)

(defvar *ext* "png")
(defvar *sleep-secs* 0)

(load "test-examples")

(let ((*turtle-class* 'cl-x11-turtle:x11-turtle)
      (*surface-class* 'cl-x11-turtle:x11-surface)
      (*sleep-secs* 3))
  (run))

#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
