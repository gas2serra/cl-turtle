(in-package :cl-gtk-turtle)

;
; A gtk surface
;
(defclass gtk-surface (cairo-surface)
  ((update-fn)
   (update-turtle-fn)
   (window
    :reader gtk-surface-window)))

(defmethod initialize-instance ((surface gtk-surface) &key)
  (call-next-method)
  (setf (slot-value surface 'window) (make-instance 'turtle-window :surface surface)))

(defmethod surface-destroy ((surface gtk-surface))
  (turtle-window-quit (gtk-surface-window surface))
  (call-next-method))

(defmethod surface-resize ((surface gtk-surface) width height)
  (call-next-method)
  (turtle-window-scale (gtk-surface-window surface))
  (surface-clear surface))

(defmethod surface-clear ((surface gtk-surface))
  (call-next-method)
  (gtk-surface-update surface)
  (gtk-surface-update-turtle surface nil))

; updating
(defun gtk-surface-update (surface)
  (turtle-window-update-surface (gtk-surface-window surface)))

(defun gtk-surface-update-turtle (surface turtle)
  (turtle-window-update-turtle (gtk-surface-window surface)))

