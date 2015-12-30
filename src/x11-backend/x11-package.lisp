(defpackage :cl-x11-turtle
  (:use :cl-cairo-turtle :cl-turtle.core :common-lisp)
  (:nicknames :x11-turtle)
  (:export 
   x11-surface
   ))

(defmacro turtle::with-x11-surface ((&key (width 500) (height 400)) &body code)
  `(let ((turtle::*surface-class* 'cl-x11-turtle:x11-surface))
     (turtle::with-surface (:width ,width :height ,height)
       ,@code)))

(defmacro turtle::x11-surface-init (&key (width 500) (height 400))
  `(let ((turtle::*surface-class* 'cl-x11-turtle:x11-surface))
     (turtle::surface-init :width ,width :height ,height)))

(export 'turtle::with-x11-surface (find-package :turtle))
(export 'turtle::x11-surface-init (find-package :turtle))
