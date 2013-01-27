(in-package :cl-x11-turtle)

;
; A turtle that display its movement into the console
;

(defclass x11-turtle (cairo-turtle)
  ())


(defmethod turtle:turtle-clear-trail :after ((turtle x11-turtle))
  (x11-surface-update (turtle-surface turtle)))

(defmethod turtle:turtle-add-point-into-trail :after ((turtle x11-turtle))
  (x11-surface-update (turtle-surface turtle)))
  