(asdf:operate 'asdf:load-op 'cl-svg-turtle)

(in-package :cl-logo-user)

(load "test-examples")

(let ((*ext* "svg"))
  (run))

#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
#+ ecl
(ext:quit)