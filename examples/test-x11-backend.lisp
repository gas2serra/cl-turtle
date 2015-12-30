(asdf:operate 'asdf:load-op 'cl-x11-turtle)

(in-package :cl-turtle)

(load "test-examples")

(let ((*surface-class* 'cl-x11-turtle:x11-surface)
      (*ext* "png"))
  (run))

#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
