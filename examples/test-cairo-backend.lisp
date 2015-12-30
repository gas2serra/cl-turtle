(asdf:operate 'asdf:load-op 'cl-cairo-turtle)

(in-package :cl-turtle)

(load "test-examples")

(let ((*ext* "png"))
  (run))
(let ((*ext* "svg"))
  (run))
(let ((*ext* "pdf"))
  (run))
(let ((*ext* "ps"))
  (run))


#+ sbcl
(SB-EXT:QUIT)
#+ clisp
(ext:quit)
