(in-package :cl-logo-user)

(defun line-cap-picture ()
  (repeat 8
	  (forward 20)
	  (pen-down)
	  (forward 150)
	  (pen-up)
	  (turn 180)
	  (forward 170)
	  (turn 180)
	  (turn (/ 360 8))))

(defun line-join-picture ()
  (repeat 4
	  (forward 30)
	  (pen-down)
	  (repeat 4
		  (forward 140)
		  (turn (/ 360 4)))
	  (pen-up)
	  (turn 180)
	  (forward 30)
	  (turn 180)
	  (turn (/ 360 4))))

(defun width-picture ()
  (repeat 6
	  (pen-down)
	  (repeat 4
		  (forward 130)
		  (turn 90))
	  (pen-up)
	  (turn (/ 360 6))
	  (change-pen (clone-pen :width (+ 1 (pen-attr :width))))))


(defun dash-picture ()
  (repeat 8
	  (forward 20)
	  (pen-down)
	  (forward 150)
	  (pen-up)
	  (turn 180)
	  (forward 170)
	  (turn 180)
	  (turn (/ 360 8))))
		      

(defun color-picture (c1 c2 n)
  (dotimes (i n)
    (change-pen (clone-pen :color (cl-colors:rgb-combination c1 c2 (/ i n))))
    (pen-down)
    (repeat 4
	    (forward 130)
	    (turn 90))
    (pen-up)
    (turn (/ 270 n))))


(defmacro with-floor (filename &body code)
  `(progn
     (turtle-init)
     (set-speed *speed*)
     ,@code
     (save-as (merge-pathnames ,filename (make-pathname :type *ext*)))
     (sleep *sleep-secs*)
     (turtle-destroy)))


(defun test-line-cap ()
  (with-floor #p"pictures/line-cap-round"
	      (change-pen (new-pen :width 10 :line-cap :round))
	      (format t "~A~%" (pen))
	      (line-cap-picture))
  (with-floor #p"pictures/line-cap-butt"
	      (change-pen (new-pen :width 10 :line-cap :butt))
	      (line-cap-picture))
  (with-floor #p"pictures/line-cap-square"
	      (change-pen (new-pen :width 10 :line-cap :square))
	      (line-cap-picture)))

(defun test-line-join ()
  (with-floor #p"pictures/line-join-round"
	      (change-pen (new-pen :width 10 :line-join :round))
	      (line-join-picture))
  (with-floor #p"pictures/line-join-miter"
	      (change-pen (new-pen :width 10 :line-join :miter))
	      (line-join-picture))
  (with-floor #p"pictures/line-join-bevel"
	      (change-pen (new-pen :width 10 :line-join :bevel))
	      (line-join-picture)))

(defun test-width ()
  (with-floor #p"pictures/width"
	      (change-pen (new-pen :width 1 :line-join :round))
	      (width-picture)))

(defun test-dash ()
  (with-floor #p"pictures/dash"
	      (change-pen (new-pen :width 5 :dash-array #(10 5 10 2) :dash-offset 2))
	      (set-background-color cl-colors:+yellow+)
	      (dash-picture)))

(defun test-color ()
  (with-floor #p"pictures/color01"
	      (color-picture cl-colors:+blueviolet+ cl-colors:+blue1+ 50))
  (with-floor #p"pictures/color02"
	      (color-picture cl-colors:+gold+ cl-colors:+red+ 50)))

(defun run ()
  (test-line-cap)
  (test-line-join)
  (test-width)
  (test-dash)
  (test-color))

