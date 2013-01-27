(in-package :cl-gtk-turtle)

;
; A turtle that display its movement into the console
;
(defclass gtk-turtle (cairo-turtle)
  ())

; moving
(defmethod turtle:turtle-move :around ((turtle gtk-turtle) distance)
  (call-next-method)
  (if (eq (turtle-pen-position turtle) :down)
      (gtk-surface-update (turtle-surface turtle))
      (gtk-surface-update-turtle (turtle-surface turtle) turtle)))

; turning
(defmethod turtle:turtle-turn :after ((turtle gtk-turtle) degree)
  (gtk-surface-update-turtle (turtle-surface turtle) turtle))

(defmethod turtle-pull-pen :after ((turtle gtk-turtle) pos)
  (gtk-surface-update-turtle (turtle-surface turtle) turtle))

(defmethod turtle-goto :after ((turtle gtk-turtle) x y)
  (gtk-surface-update-turtle (turtle-surface turtle) turtle))

(defmethod turtle-pen-change-color :after ((turtle gtk-turtle) rgb)
  (gtk-surface-update-turtle (turtle-surface turtle) turtle))

(defmethod turtle-pen-change-width :after ((turtle gtk-turtle) width)
  (gtk-surface-update-turtle (turtle-surface turtle) turtle))
  