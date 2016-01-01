(asdf:operate 'asdf:load-op 'cl-x11-turtle)
(asdf:operate 'asdf:load-op 'cl-turtle-examples)


(in-package :cl-turtle-examples)

(let ((*surface-class* 'cl-x11-turtle:x11-surface))
  (run "png"))

#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
