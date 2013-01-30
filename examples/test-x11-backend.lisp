(asdf:operate 'asdf:load-op 'cl-x11-turtle)

(in-package :cl-logo-user)

(defvar *ext* "png")
(defvar *sleep-secs* 0)
(defvar *speed* -1)

(load "test-examples")

(let ((*turtle-class* 'cl-turtle:turtle)
      (*surface-class* 'cl-x11-turtle:x11-surface)
      (*sleep-secs* 1)
      (*speed* 1000))
  (run))

#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
