;;; the mode for editing CLISP *.d files
;;; add the following to your ~/.emacs.el
;;; (setq auto-mode-alist (cons '("\\.d\\'" . d-mode) auto-mode-alist))
;;; (autoload 'd-mode "/usr/local/src/clisp/emacs/d-mode")

(require 'c-mode)

(defun d-mode-modify-lock-1 (form)
  "`d-mode' should highlight #foo not only at the beginning-of-line"
  (if (and (consp form) (stringp (car form))
           (= ?^ (aref (car form) 0))
           (= ?# (aref (car form) 1)))
      (cons (concat "^[ \t]*" (substring (car form) 1)) (cdr form))
      form))

(defvar d-font-lock-keywords-1
  (mapcar #'d-mode-modify-lock-1 c-font-lock-keywords-1))

(defvar d-font-lock-keywords-2
  (mapcar #'d-mode-modify-lock-1 c-font-lock-keywords-2))

(defvar d-font-lock-keywords-3
  (mapcar #'d-mode-modify-lock-1 c-font-lock-keywords-3))

(defvar d-font-lock-keywords d-font-lock-keywords-1)

(defun d-mode-add-font-locking (default)
  (cons (list 'd-font-lock-keywords 'd-font-lock-keywords-1
              'd-font-lock-keywords-2 'd-font-lock-keywords-3)
        (cdr default)))

(defvar d-mode-font-lock-defaults
  (d-mode-add-font-locking
   (if sds-xemacs (get 'c-mode 'font-lock-defaults)
       (cdr (assq 'c-mode font-lock-defaults-alist))))
  "the `font-lock-defaults' for `d-mode'")

(define-derived-mode d-mode c-mode "D"
  "Major mode for editing CLISP source code.
Special commands:
\\{d-mode-map}
Turning on D mode calls the value of the variable `d-mode-hook',
if that value is non-nil.
If you are using Emacs 20.2 or earlier (including XEmacs) and want to
use fontifications, you have to (require 'font-lock) first.  Sorry.
You might want to do also
  (add-to-list 'c-font-lock-extra-types \"object\")
Beware - this will modify the original C-mode too!"
  (set (make-local-variable 'font-lock-defaults)
       d-mode-font-lock-defaults))

(when window-system
  (if sds-xemacs
      (put 'd-mode 'font-lock-defaults d-mode-font-lock-defaults)
      (when (and (> 21 emacs-major-version)
                 (null (assq 'd-mode font-lock-defaults-alist)))
        (setq font-lock-defaults-alist
              (cons (cons 'd-mode d-mode-font-lock-defaults)
                    font-lock-defaults-alist)))))

;; enable CLISP "# foo" comments
(modify-syntax-entry ?# ". 1b" d-mode-syntax-table)
(modify-syntax-entry 32 "- 2b" d-mode-syntax-table) ; space
(modify-syntax-entry ?\n "> b" d-mode-syntax-table)
(modify-syntax-entry ?\f "> b" d-mode-syntax-table)
(modify-syntax-entry ?/ "_ 14" d-mode-syntax-table)

(provide 'd-mode)
