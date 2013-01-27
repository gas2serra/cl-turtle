(in-package :cl-gtk-turtle)

(defparameter *src-location* 
  (asdf:component-pathname (asdf:find-system :cl-gtk-turtle)))

(defclass turtle-window ()
  ((surface
    :initarg :surface
    :reader turtle-window-surface)
   (scale-factor 
    :initform 1.0
    :accessor turtle-window-scale-factor)
   (scale-fn 
    :reader turtle-window-scale-fn)
   (quit-fn
    :reader turtle-window-quit-fn)
   (update-surface-fn
    :reader turtle-window-update-surface-fn)
   (update-turtle-fn
    :reader turtle-window-update-turtle-fn)))



(defmethod initialize-instance :after ((window turtle-window) &key)
  (gtk:within-main-loop
   (let ((builder (make-instance 'gtk:builder)))
      (gtk:builder-add-from-file builder 
				 (namestring 
				  (merge-pathnames 
				   "gtk-backend/turtle.ui" *src-location*)))
     ; building
     (gtk:builder-connect-signals-simple
      builder
      (append 
       (turtle-window-build-window window builder)
       (turtle-window-build-surface window builder)
       (turtle-window-build-surface-tootbar window builder)
       (turtle-window-build-turtle-tootbar window builder)
       (turtle-window-build-dialog-page window builder)))
     (let ((w (gtk:builder-get-object builder "window")))
       (gtk:widget-show w)))))
       
; callback
(defun turtle-window-update-surface (window)
  (if (slot-boundp window 'update-surface-fn)
      (funcall (turtle-window-update-surface-fn window))))
(defun turtle-window-update-turtle (window)
  (if (slot-boundp window 'update-turtle-fn)
      (funcall (turtle-window-update-turtle-fn window))))
(defun turtle-window-quit (window)
  (funcall (turtle-window-quit-fn window)))
(defun turtle-window-scale (window)
  (funcall (turtle-window-scale-fn window)))

;
; building
;
(defun turtle-window-build-window (window builder)
  (let ((w (gtk:builder-get-object builder "window")))
    (gobject:connect-signal w "destroy" 
			    (lambda (w) (declare (ignore w))
				    (gtk:leave-gtk-main)))
    (gobject:connect-signal w "delete-event" 
			    (lambda (w e) (declare (ignore w e)) 
				    (surface-destroy 
				     (turtle-window-surface window))
				    nil))
    (setf (slot-value window 'quit-fn) 
	  (lambda ()
	    (gtk:within-main-loop (gtk:object-destroy w)))))
  nil)
    
; surface
(defun turtle-window-build-surface (window builder)
  (let ((d (gtk:builder-get-object builder "drawingarea1")))
    (setf (slot-value window 'scale-fn) 
	  (lambda ()
	    (gtk:within-main-loop
	      (setf (gtk:widget-width-request d) 
		    (round (* (turtle-window-scale-factor window)
			      (surface-width (turtle-window-surface window)))))
	      (setf (gtk:widget-height-request d) 
		    (round (* (turtle-window-scale-factor window)
			      (surface-height (turtle-window-surface window))))))))
    (turtle-window-scale window)
    (setf (slot-value window 'update-surface-fn) 
	  (lambda () 
	    (gtk:within-main-loop (gtk:widget-queue-draw d))))
    (gobject:connect-signal d "expose-event" 
			    (lambda (widget event)
			      (declare (ignore event))
			      (turtle-window-expose window widget))))
  nil)
; expose
(defun turtle-window-expose (window widget)
  (cl-gtk2-cairo:with-gdk-context (ctx (gtk:widget-window widget))
    (cairo:with-context (ctx)
      (let ((s (turtle-window-scale-factor window)))
	(cairo:scale s s)
	(cl-cairo-turtle::cairo-surface-paint-to (turtle-window-surface window))
	nil))))
; surface toolbar
(defun turtle-window-build-surface-tootbar (window builder)
  
  (list (list "on_toolbutton-clear_clicked"
	      (lambda (b)
		(declare (ignore b))
		(surface-clear (turtle-window-surface window))))
	(list "on_toolbutton-save-as_clicked"
	      (lambda (b)
		(declare (ignore b))
		(let* ((filter (make-instance 'gtk:file-filter))
		       (d (make-instance 'gtk:file-chooser-dialog 
					 :action :save 
					 :title "Choose a png file to save"
					 :filter filter)))
		  (gtk:file-filter-add-pattern filter "*.png")
		  (gtk:dialog-add-button d "gtk-save" :accept)
		  (gtk:dialog-add-button d "gtk-cancel" :cancel)
		  (when (eq (gtk:dialog-run d) :accept)
		    (surface-save-as (turtle-window-surface window) 
				     (gtk:file-chooser-filename d)))
		  (gtk:object-destroy d))))
	(list "on_toolbutton-normal-size_clicked"
	      (lambda (b)
		(declare (ignore b))
		(setf (turtle-window-scale-factor window) 1.0)
		(turtle-window-scale window)
		(turtle-window-update-surface window)))
	(list "on_toolbutton-zoom-in_clicked"
	      (lambda (b)
		(declare (ignore b))
		(setf (turtle-window-scale-factor window) 
		      (* 1.5 (turtle-window-scale-factor window)))
		(turtle-window-scale window)
		(turtle-window-update-surface window)))
	(list "on_toolbutton-zoom-out_clicked"
	      (lambda (b)
		(declare (ignore b))
		(setf (turtle-window-scale-factor window) 
		      (* (/ 1 1.5) (turtle-window-scale-factor window)))
		(turtle-window-scale window)
		(turtle-window-update-surface window)))
	(list "on_toolbutton-best-fit_clicked"
	      (lambda (b)
		(declare (ignore b))
		(setf (turtle-window-scale-factor window) 
		      (/ (- (gtk:gtk-window-size 
			     (gtk:builder-get-object builder "window")) 40)
			 (surface-width (turtle-window-surface window))))
		(turtle-window-scale window)
		(turtle-window-update-surface window)))
	(list "on_colorbutton-background_color_set"
	      (lambda (b)
		(let ((c (gtk:color-button-color b)))
		  (setf (surface-color (turtle-window-surface window))
			(make-instance 'cl-colors:rgb 
				       :red (/ (gdk:color-red c) 65535)
				       :green (/ (gdk:color-green c) 65535)
				       :blue (/ (gdk:color-blue c) 65535))))))
	(list "on_toolbutton-quit_clicked"
	      (lambda (b)
		(declare (ignore b))
		(logo:turtle-destroy)))
		;(surface-destroy 
		; (turtle-window-surface window))))
	(list "on_toolbutton-page_clicked"
	      (lambda (b)
		(declare (ignore b))
		(let ((d (gtk:builder-get-object builder "dialog-page")))
		  (when (eq (gtk:dialog-run d) :accpet)
		    (format t "ACCEPT~%"))
		  (gtk:widget-hide d :all nil))))))
; turtle toolbar
(defun turtle-window-build-turtle-tootbar (window builder)
  (let ((aw (gtk:builder-get-object builder "adjustment3")))
    (setf (gtk:adjustment-lower aw) 1)
    (setf (gtk:adjustment-upper aw) 20)
    (setf (gtk:adjustment-step-increment aw) 1))
  (setf (slot-value window 'update-turtle-fn) 
	(lambda () 
	  (gtk:within-main-loop 
	    (when logo::*turtle*
	      (let ((pdb (gtk:builder-get-object 
			  builder "toggletoolbutton-pen-pos"))
		    (pd (turtle-pen-position 
			 (car (surface-turtles 
			       (turtle-window-surface window))))))
		(setf (gtk:toggle-tool-button-active pdb) (eq pd :down)))))))
  (list 
   (list "on_button-execute_clicked"
	 (let ((script (gtk:builder-get-object builder "textview-script")))
	   (lambda (b)
	     (HANDLER-CASE
		 (progn 
		   (let ((*package* (find-package :cl-logo-user)))
		     (with-input-from-string (strm 
					      (gtk:text-buffer-text 
					       (gtk:text-view-buffer script)))
		       (loop for f = (read strm nil :break)
			  until (eq f :break)
			  do (eval f)))))
	       (error (x) (progn
			    (let ((d (gtk:builder-get-object builder "dialog-lisperror"))
				  (msg (gtk:builder-get-object builder "textview-error")))
			      (setf (gtk:text-buffer-text 
				     (gtk:text-view-buffer msg)) (format nil "~A" x))
			      (gtk:dialog-run d)
			      (gtk:widget-hide d :all nil))))))))
   (list "on_toggletoolbutton-pen-pos_toggled"
	 (lambda (b)
	   (turtle-pull-pen 
	    (car (surface-turtles (turtle-window-surface window)))
	    (if (gtk:toggle-tool-button-active b) :down :up))))
   (list "on_toolbutton-home_clicked"
	 (lambda (b)
	   (declare (ignore b))
	   (turtle-home (car (surface-turtles (turtle-window-surface window))))))))

(defun turtle-window-build-dialog-page (window builder)
  (declare (ignore window))
  (let ((aw (gtk:builder-get-object builder "adjustment1"))
	(ah (gtk:builder-get-object builder "adjustment2")))
    (setf (gtk:adjustment-lower aw) 10)
    (setf (gtk:adjustment-lower ah) 10)
    (setf (gtk:adjustment-upper aw) 10000)
    (setf (gtk:adjustment-upper ah) 10000)
    (setf (gtk:adjustment-step-increment aw) 10)
    (setf (gtk:adjustment-step-increment ah) 10)
    (setf (gtk:adjustment-value aw) (surface-width (turtle-window-surface window)))
    (setf (gtk:adjustment-value ah) (surface-height (turtle-window-surface window)))
    (setf (gtk:adjustment-page-size aw) 0)
    (setf (gtk:adjustment-page-size ah) 0)
    (let ((d (gtk:builder-get-object builder "dialog-page")))
      (gobject:connect-signal d "response"
			      (lambda (dialog response-id)
				(if (eql response-id -3)
				    (surface-resize
				     (turtle-window-surface window)
				     (round (gtk:adjustment-value aw))
				     (round (gtk:adjustment-value ah))))))))
  nil)

  
			      

