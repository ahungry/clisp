;;; Copyright (C) 2002 by Sam Steingold
;;; This is Free Software, covered by the GNU GPL (v2)
;;; See http://www.gnu.org/copyleft/gpl.html
;;;
;;; Check LISPFUN, LISPFUNN and LISPSPECFORM

(in-package "USER")

(defun make-c-rt (&optional (rt (copy-readtable)))
  (set-syntax-from-char #\, #\Space rt)
  rt)
(defvar *c-rt* (make-c-rt))
(defun get-lisp-def (line st len)
  (let ((*readtable* *c-rt*))
    (read (make-concatenated-stream (make-string-input-stream line len) st))))

(defvar *form-defs* '("subr" "fsubr"))

(defun get-lisp-defs (file)
  (with-open-file (st file :direction :input :external-format charset:utf-8)
    (format t "~&~s: file ~s~%" 'get-lisp-defs file)
    (with-collect (keep)
      (loop (let* ((line (read-line st nil nil)) (len (length line)))
              (unless line (return))
              (cond ((sys::string-beg-with "LISPSPECFORM" line len)
                     (keep (get-lisp-def line st #.(length "LISPSPECFORM"))))
                    ((sys::string-beg-with "LISPFUNN" line len)
                     (keep (get-lisp-def line st #.(length "LISPFUNN"))))
                    ((sys::string-beg-with "LISPFUN" line len)
                     (keep (get-lisp-def line st #.(length "LISPFUN"))))))))))

(defun check-lisp-defs (dir)
  (format t "~&~s: ~s~%" 'check-lisp-defs dir)
  (let ((def-forms
         (delete-duplicates
          (sort (mapcan #'get-lisp-defs
                        (delete-if (lambda (fi)
                                     (member (pathname-name fi) *form-defs*
                                             :test #'string-equal))
                                   (directory (merge-pathnames "*.d" dir))))
                #'string< :key #'car)
          :test #'equal))
        (dec-forms
         (delete-duplicates
          (sort (mapcan #'get-lisp-defs
                        (mapcar (lambda (fi)
                                  (make-pathname :name fi :type "d"
                                                 :defaults dir))
                                *form-defs*))
                #'string< :key #'car)
          :test #'equal))
        kwd (error-count 0))
    (cond ((= (length def-forms) (length dec-forms))
           (format t "~d forms~%" (length def-forms)))
          (t (appease-cerrors
              (cerror "proceed with checks"
                      "# of defined forms ~s != # of declared forms ~s"
                      (length def-forms) (length dec-forms)))
             (incf error-count)))
    (when (set-difference dec-forms def-forms :test #'equal)
      (appease-cerrors
       (cerror "proceed with checks"
               "declaration (subr.d) differs from the definition:~%~s"
               (set-difference dec-forms def-forms :test #'equal)))
      (incf error-count))
    (when (set-difference def-forms dec-forms :test #'equal)
      (appease-cerrors
       (cerror "proceed with checks"
               "definition differs from the declaration (subr.d):~%~s"
               (set-difference def-forms dec-forms :test #'equal)))
      (incf error-count))
    (with-open-file (st (merge-pathnames "subrkw.d" dir)
                        :direction :input :external-format charset:utf-8)
      (format t "~&~s: file ~s~%" 'check-lisp-defs
              (merge-pathnames "subrkw.d" dir))
      (loop (let* ((line (read-line st nil nil)) (len (length line)))
              (unless line (return))
              (cond ((sys::string-beg-with "v" line len)
                     (setq kwd (get-lisp-def line st #.(length "v"))))
                    ((sys::string-beg-with "s" line len)
                     (let ((fn (car (get-lisp-def line st #.(length "s")))))
                       (unless (equal (cdr (member 'key (assoc fn dec-forms)))
                                      kwd)
                         (appease-cerrors
                          (cerror "proceed with checks"
                                  "subrkw.d vs subr.d (~s):~%~s~%~s" fn kwd
                                  (cdr (member 'key (assoc fn dec-forms)))))
                         (incf error-count))))))))
    (when (plusp error-count)
      (error "~d errors" error-count))))

;;; file check-lispfun.lisp ends here
