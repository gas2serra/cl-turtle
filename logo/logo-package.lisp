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
   ; drawing style
   set-pen-style
   set-pen-width
   set-pen-color-by-name
   set-pen-color
   ; status
   pos
   x-cor
   y-cor
   heading
   pen-pos
   pen-downp
   pen-style
   ; utility
   towards
   distance
   ; language contructes
   repeat
   ; surface
   clear
   set-background-color
   save-as

   ; configuration
   *surface-class*
   *turtle-class*
   ; init
   turtle-init
   turtle-destroy
   ))

(defpackage :cl-logo-user
  (:use :common-lisp :cl-logo))
