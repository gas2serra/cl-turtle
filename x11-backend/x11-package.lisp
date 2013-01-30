(defpackage :cl-x11-turtle
  (:use :cl-cairo-turtle :cl-turtle :common-lisp)
  (:nicknames :x11-turtle)
  (:export 
   x11-surface
   ))

(defmacro logo::with-x11-surface ((&key (width 500) (height 400)) &body code)
  `(let ((logo::*surface-class* 'cl-x11-turtle:x11-surface))
     (logo:with-surface (:width ,width :height ,height)
       ,@code)))

(defmacro logo::x11-surface-init (&key (width 500) (height 400))
  `(let ((logo::*surface-class* 'cl-x11-turtle:x11-surface))
     (logo:surface-init :width ,width :height ,height)))

(export 'logo::with-x11-surface (find-package :logo))
(export 'logo::x11-surface-init (find-package :logo))
