
sbcl: dir
	sbcl --load "test-cairo-backend"

clisp: dir
	clisp -i test-cairo-backend.lisp

sbcl-x11: dir
	sbcl --load "test-x11-backend"

sbcl-svg: dir
	sbcl --load "test-svg-backend"

clisp-svg: dir
	clisp -i test-svg-backend.lisp

ecl-svg: dir
	/opt/common-lisp/bin/ecl -load test-svg-backend.lisp

dir:
	mkdir -p pictures

clean:
	rm -rf pictures