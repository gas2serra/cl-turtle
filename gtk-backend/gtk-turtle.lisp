(in-package :cl-gtk-turtle)

;
; A turtle that display its movement into the console
;
(defclass gtk-turtle (cairo-turtle)
  ())


(defmethod turtle:turtle-clear-trail :after ((turtle gtk-turtle))
  (gtk-surface-update (turtle-surface turtle)))

(defmethod turtle:turtle-add-point-into-trail :after ((turtle gtk-turtle))
  (gtk-surface-update (turtle-surface turtle)))
  

(defmethod turtle:turtle-pull-pen :after ((turtle gtk-turtle) pos)
  (gtk-surface-update-turtle (turtle-surface turtle) turtle))
