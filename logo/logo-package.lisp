(defpackage :cl-logo
  (:use :common-lisp)
  (:nicknames :logo)
  (:export
   ; configuration
   *surface-class*
   *turtle-class*
   ; init
   turtle-on
   turtle-off
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
   ; pen control
   pull-pen
   pen-up
   pen-down
   ; drawing style
   change-pen-color
   change-pen-color-by-name
   change-pen-width
   ; utilities
   clear
   save-as-png
   ; language contructes
   repeat
   ))

(defpackage :cl-logo-user
  (:use :common-lisp :cl-logo))
