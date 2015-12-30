(defpackage :cl-turtle.core
  (:use :common-lisp)
  (:nicknames :turtle.core)
  (:export
   ;
   ; surface
   ;
   ; class
   surface
   ; attributes
   surface-width
   surface-height
   surface-color
   surface-mode
   surface-turtle
   surface-trail
   ; primitives
   surface-clear
   surface-reset
   surface-save-as
   surface-destroy
   surface-add-path
   surface-clear-trail
   surface-add-point-into-trail
   ; utilities
   surface-ordered-paths

   ;
   ; turtle
   ;
   ; class
   turtle
   ; attributes
   turtle-x
   turtle-y
   turtle-heading
   turtle-pen-position
   turtle-pen  
   turtle-speed
   turtle-surface
   ; primitives
   turtle-move
   turtle-turn
   turtle-pull-pen
   turtle-goto
   turtle-home
   turtle-turn-to
   turtle-reset

   ;
   ; pen
   ;
   pen
   pen-width
   pen-color
   pen-alpha
   pen-line-cap
   pen-line-join
   pen-miter-limit
   pen-dash-array
   pen-dash-offset
   pen-get-attribute
   pen-clone
   ;
   ; path
   ;
   path
   path-pen
   path-points
   path-ordered-points

   ; utility
   degrees->radians
   radians->degrees
   polar->cartesian
   normalize-angle
   points-distance
   ))
