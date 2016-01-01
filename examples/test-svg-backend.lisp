(asdf:operate 'asdf:load-op 'cl-svg-turtle)
(asdf:operate 'asdf:load-op 'cl-turtle-examples)


(in-package :cl-turtle-examples)

(run "svg")

#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
#+ ecl
(ext:quit)
