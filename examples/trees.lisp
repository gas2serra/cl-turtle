(in-package :cl-turtle-examples)

; draw a tree with 2 branches
(defun tree (len level &key (alpha-left 60) (alpha-right 60) (ratio-left 0.7) (ratio-right 0.7) penseq)
  (unless (= level 0)
    (when penseq
      (change-pen (car penseq)))    
    (pull-pen-down)  
    (move-forward len)
    (pull-pen-up)
    (turn alpha-right)
    (tree (* len ratio-right) (- level 1) 
	  :alpha-left alpha-left :alpha-right alpha-right 
	  :ratio-left ratio-left :ratio-right ratio-right :penseq (cdr penseq))
    (turn (- (+ alpha-right alpha-left)))
    (tree (* len ratio-left) (- level 1) 
	  :alpha-left alpha-left :alpha-right alpha-right 
	  :ratio-left ratio-left :ratio-right ratio-right :penseq (cdr penseq))
    (turn alpha-left)
    (move-backward len)))

; generates a sequence of pens
(defun make-pen-seq (max-level width ratio-width alpha ratio-alpha c1 c2)
  (labels ((pen-style-r (level)
	     (if (= level 0) 
		 nil
		 (cons 
		  (new-pen :color (cl-colors:rgb-combination c2 c1 (/ level max-level))
			   :alpha (* alpha (expt ratio-alpha (- max-level level)))
			   :width (* width (expt ratio-width (- max-level level))))
		  (pen-style-r (- level 1))))))
    (pen-style-r max-level)))

(defparameter *len* 120)
(defparameter *depth* 13)
(defparameter *penseq* (make-pen-seq *depth* 10 0.8 0.9 0.9 cl-colors:+saddlebrown+ cl-colors:+green+))

(defun tree-picture-01 ()
  (with-image ("pictures/tree-01" :width 600 :height 600 :ext *ext*)
    (go-to 0 -200)
    (tree *len* *depth* :alpha-left 10 :alpha-right 10 :ratio-left 0.7 :ratio-right 0.7 :penseq *penseq*)))

(defun tree-picture-02 ()
  (with-image ("pictures/tree-02" :width 600 :height 600 :ext *ext*)
    (go-to 0 -200)
    (tree *len* *depth* :alpha-left 20 :alpha-right 20 :ratio-left 0.7 :ratio-right 0.7 :penseq *penseq*)))

(defun tree-picture-03 ()
  (with-image ("pictures/tree-03" :width 600 :height 600 :ext *ext*)
    (go-to 0 -200)
    (tree *len* *depth* :alpha-left 30 :alpha-right 30 :ratio-left 0.7 :ratio-right 0.7 :penseq *penseq*)))

(defun tree-picture-04 ()
  (with-image ("pictures/tree-04" :width 600 :height 600 :ext *ext*)
    (go-to 0 -200)
    (tree *len* *depth* :alpha-left 40 :alpha-right 20 :ratio-left 0.7 :ratio-right 0.7 :penseq *penseq*)))

(defun tree-picture-05 ()
  (with-image ("pictures/tree-05" :width 600 :height 600 :ext *ext*)
    (go-to 0 -200)
    (tree *len* *depth* :alpha-left 10 :alpha-right 2 :ratio-left 0.7 :ratio-right 0.7 :penseq *penseq*)))

(defun tree-picture-06 ()
  (with-image ("pictures/tree-06" :width 600 :height 600 :ext *ext*)
    (go-to 0 -200)
    (tree *len* *depth* :alpha-left 30 :alpha-right 20 :ratio-left 0.75 :ratio-right 0.6 :penseq *penseq*)))

(defun run-tree ()
  (let ((*DEFAULT-PATHNAME-DEFAULTS* *examples-path*))
    (tree-picture-01)
    (tree-picture-02)
    (tree-picture-03)
    (tree-picture-04)
    (tree-picture-05)
    (tree-picture-06)))
