(defpackage :cl-turtle
  (:use :common-lisp)
  (:nicknames :turtle)
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
   surface-turtles
   surface-paths
   surface-ordered-paths
   ; adding/removing
   surface-add-turtle
   surface-remove-turtle
   surface-add-path
   ; primitives
   surface-clear
   surface-reset
   surface-save-as
   surface-destroy
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
   turtle-surface
   turtle-trail
   ; moving
   turtle-move
   ; turning
   turtle-turn
   ; pulling
   turtle-pull-pen
   ; goto
   turtle-goto
   turtle-home
   turtle-turn-to
   ; trail
   ;...

   ;
   ; style
   ;
   pen
   pen-width
   pen-color
   pen-linecap
   pen-linejoin
   pen-miterlimit
   pen-dasharray
   pen-dashoffset
   pen-get-attribute
   pen-clone
   ;
   ; path
   ;
   path
   path-pen
   path-ordered-points

   ; utility
   radians->degrees
   points-distance
   ))
