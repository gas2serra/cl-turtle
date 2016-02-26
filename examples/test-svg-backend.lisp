(asdf:require-system 'cl-svg-turtle)
(asdf:require-system 'cl-turtle-examples)


(in-package :cl-turtle-examples)

(run "svg")

#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
#+ ecl
(ext:quit)
