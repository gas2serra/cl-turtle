(asdf:operate 'asdf:load-op 'cl-svg-turtle)

(in-package :cl-logo-user)

(defvar *ext* "svg")
(defvar *sleep-secs* 0)
(defvar *speed* -1)

(load "test-examples")

(let ((*turtle-class* 'cl-turtle:turtle)
      (*surface-class* 'cl-turtle:surface)
      (*sleep-secs* 0))
  (run))

#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
#+ ecl
(ext:quit)