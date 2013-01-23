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
   ; turtles's primitive
   surface-add-turtle
   surface-remove-turtle
   ; primitives
   surface-clear
   surface-save-as
   surface-destroy
   ;
   ; turtle
   ;
   turtle
   turtle-x
   turtle-y
   turtle-heading
   turtle-heading/radians
   turtle-pen-position
   turtle-pen-style   
   ; moving
   turtle-move
   ; turning
   turtle-turn
   turtle-turn/radians
   ; pulling
   turtle-pull-pen
   ; goto
   turtle-goto
   turtle-home
   turtle-turn-to
   ; style
   turtle-get-pen-style
   turtle-set-pen-style
   ; turtle's sufrace
   turtle-surface

   ;
   ; path
   ;

   ))
