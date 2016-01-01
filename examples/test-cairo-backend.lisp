(asdf:operate 'asdf:load-op 'cl-cairo-turtle)
(asdf:operate 'asdf:load-op 'cl-turtle-examples)

(in-package :cl-turtle-examples)

(run "png")
(run "svg")
(run "pdf")
(run "ps")


#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
