(defpackage :cl-logo
  (:use :common-lisp)
  (:nicknames :logo)
  (:export
   ; moving
   move
   forward
   backward   
   ; turning
   turn
   left
   right
   ; goto 
   goto
   home 
   turn-to
   ; pen control
   pull-pen
   pen-up
   pen-down
   ; status
   pos
   x-cor
   y-cor
   heading
   pen-pos
   ; drawing
   pen
   pen-attr
   clone-pen
   new-pen
   change-pen
   ; utility
   towards
   distance
   ; language contructes
   repeat
   ; surface
   clear
   set-background-color
   save-as
   reset

   ; configuration
   *surface-class*
   *turtle-class*
   ; init
   turtle-init
   turtle-destroy
   ))

(defpackage :cl-logo-user
  (:use :common-lisp :cl-logo))
