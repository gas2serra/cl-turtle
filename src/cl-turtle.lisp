(in-package :cl-user)

(defpackage cl-turtle
  (:nicknames :turtle)
  (:use :cl)
;  (:import-from :cl-turtle.core
;		:turtle)
  (:export
   ;; enviroment
   *turtle*
   ;; making
   
   ;; moving
   move
   move-forward
   move-backward
   ;; turning
   turn
   turn-left
   turn-right
   ;;  go/turn to
   go-to
   go-home
   turn-to
   ;; pen control
   pull-pen
   pull-pen-up
   pull-pen-down
   ;; speed
   set-speed
   ;; status
   x-coordinate
   y-coordinate
   heading
   pen-pos
   get-speed
   pos
   state
   towards
   distance
   ;; language macro
   repeat


   ;; to fix
   with-image
   new-pen
   change-pen
   pen-attr
   clone-pen
   set-background-color
   *SURFACE-CLASS*
   ))
