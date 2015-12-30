(asdf:operate 'asdf:load-op 'cl-svg-turtle)

(in-package :cl-turtle)

(load "test-examples")

(let ((*ext* "svg"))
  (run))

#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
#+ ecl
(ext:quit)
