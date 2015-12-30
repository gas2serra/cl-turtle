(in-package :cl-user)

(defpackage cl-turtle
  (:nicknames :turtle)
  (:use :cl)
;  (:import-from :cl-turtle.core
;		:turtle)
  (:export
   ;; enviroment
   *turtle*
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
   ;; status
   pos
   x-coordinate
   y-coordinate
   heading
   pen-pos
   towards
   distance
   ;; language macro
   repeat
   ))
