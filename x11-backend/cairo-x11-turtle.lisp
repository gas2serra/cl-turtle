(in-package :cl-cairo-x11-turtle)

;
; A turtle that display its movement into the console
;

(defclass cairo-x11-turtle (cairo-turtle)
  ())


(defmethod turtle:turtle-clear-trail :after ((turtle cairo-x11-turtle))
  (cairo-x11-surface-update (turtle-surface turtle)))

(defmethod turtle:turtle-add-point-into-trail :after ((turtle cairo-x11-turtle))
  (cairo-x11-surface-update (turtle-surface turtle)))
  