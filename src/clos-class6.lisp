;;;; Common Lisp Object System for CLISP
;;;; Class metaobjects
;;;; Part n-1: Generic functions specified in the MOP.
;;;; Bruno Haible 2004-05-25

(in-package "CLOS")

;;; ===========================================================================

;; Make creation of <class> instances customizable.

;; Installing the accessor methods can only be done after a class has been
;; initialized, but must be done in a _primary_ initialize-instance method,
;; so that it doesn't interfere with :after/:around methods that a user could
;; install. See MOP p. 60.
(defmethod initialize-instance ((class class) &rest args)
  (declare (ignore args))
  (call-next-method) ; == (apply #'shared-initialize class 't args)
  (install-class-direct-accessors class)
  class)

(setf (fdefinition 'initialize-instance-<built-in-class>) #'initialize-instance)
(setf (fdefinition 'make-instance-<built-in-class>) #'make-instance)
(setf (fdefinition 'initialize-instance-<structure-class>) #'initialize-instance)
(setf (fdefinition 'make-instance-<structure-class>) #'make-instance)
(setf (fdefinition 'initialize-instance-<standard-class>) #'initialize-instance)
(setf (fdefinition 'make-instance-<standard-class>) #'make-instance)
(setf (fdefinition 'initialize-instance-<funcallable-standard-class>) #'initialize-instance)
(setf (fdefinition 'make-instance-<funcallable-standard-class>) #'make-instance)

;;; ===========================================================================

;;; Optimized class-xxx accessors.
;;; These are possible thanks to the :fixed-slot-locations class option.

(defun check-class-initialized (class level)
  (unless (>= (class-initialized class) level)
    (error (TEXT "The class ~S has not yet been initialized.")
           class)))

(defun check-class-finalized (class level)
  (check-class-initialized class 2)
  (unless (>= (class-initialized class) level)
    (error (TEXT "The class ~S has not yet been finalized.")
           class)))

;; Not in MOP.
(defun class-classname (class)
  (accessor-typecheck class 'class 'class-classname)
  (sys::%record-ref class *<class>-classname-location*))
(defun (setf class-classname) (new-value class)
  (accessor-typecheck class 'class '(setf class-classname))
  (setf (sys::%record-ref class *<class>-classname-location*) new-value))
;; MOP p. 76
(defgeneric class-name (class)
  (:method ((class class))
    (check-class-initialized class 1)
    (class-classname class)))
; No extended method check because this GF is specified in ANSI CL.
;(initialize-extended-method-check #'class-name)
;; MOP p. 92
(defgeneric (setf class-name) (new-value class)
  (:method (new-value (class class))
    (unless (symbolp new-value)
      (error-of-type 'type-error
        :datum new-value :expected-type 'symbol
        (TEXT "~S: The name of a class must be a symbol, not ~S")
        '(setf class-name) new-value))
    (when (built-in-class-p class)
      (error-of-type 'error
        (TEXT "~S: The name of the built-in class ~S cannot be modified")
        '(setf class-name) class))
    (reinitialize-instance class :name new-value)
    new-value))
(initialize-extended-method-check #'(setf class-name))

;; MOP p. 76
(defgeneric class-direct-superclasses (class)
  (:method ((class class))
    (check-class-initialized class 2)
    (sys::%record-ref class *<class>-direct-superclasses-location*)))
(initialize-extended-method-check #'class-direct-superclasses)
;; Not in MOP.
(defun (setf class-direct-superclasses) (new-value class)
  (accessor-typecheck class 'class '(setf class-direct-superclasses))
  (setf (sys::%record-ref class *<class>-direct-superclasses-location*) new-value))

;; Not in MOP.
(defun class-all-superclasses (class)
  (accessor-typecheck class 'class 'class-all-superclasses)
  (sys::%record-ref class *<class>-all-superclasses-location*))
(defun (setf class-all-superclasses) (new-value class)
  (accessor-typecheck class 'class '(setf class-all-superclasses))
  (setf (sys::%record-ref class *<class>-all-superclasses-location*) new-value))

;; MOP p. 76
(defgeneric class-precedence-list (class)
  (:method ((class class))
    (check-class-finalized class 3)
    (sys::%record-ref class *<class>-precedence-list-location*)))
(initialize-extended-method-check #'class-precedence-list)
;; Not in MOP.
(defun (setf class-precedence-list) (new-value class)
  (accessor-typecheck class 'class '(setf class-precedence-list))
  (setf (sys::%record-ref class *<class>-precedence-list-location*) new-value))

;; Not in MOP.
(defun class-direct-subclasses-table (class)
  (accessor-typecheck class 'class 'class-direct-subclasses-table)
  (sys::%record-ref class *<class>-direct-subclasses-location*))
(defun (setf class-direct-subclasses-table) (new-value class)
  (accessor-typecheck class 'class '(setf class-direct-subclasses-table))
  (setf (sys::%record-ref class *<class>-direct-subclasses-location*) new-value))
;; MOP p. 76
(defgeneric class-direct-subclasses (class)
  (:method ((class class))
    (check-class-initialized class 2)
    (list-direct-subclasses class)))

;; MOP p. 75
(defgeneric class-direct-slots (class)
  (:method ((class class))
    (check-class-initialized class 2)
    (sys::%record-ref class *<class>-direct-slots-location*)))
(initialize-extended-method-check #'class-direct-slots)
;; Not in MOP.
(defun (setf class-direct-slots) (new-value class)
  (accessor-typecheck class 'class '(setf class-direct-slots))
  (setf (sys::%record-ref class *<class>-direct-slots-location*) new-value))

;; MOP p. 77
(defgeneric class-slots (class)
  (:method ((class class))
    (check-class-finalized class 5)
    (sys::%record-ref class *<class>-slots-location*)))
(initialize-extended-method-check #'class-slots)
;; Not in MOP.
(defun (setf class-slots) (new-value class)
  (accessor-typecheck class 'class '(setf class-slots))
  (setf (sys::%record-ref class *<class>-slots-location*) new-value))

;; Not in MOP.
(defun class-slot-location-table (class)
  (accessor-typecheck class 'class 'class-slot-location-table)
  (sys::%record-ref class *<class>-slot-location-table-location*))
(defun (setf class-slot-location-table) (new-value class)
  (accessor-typecheck class 'class '(setf class-slot-location-table))
  (setf (sys::%record-ref class *<class>-slot-location-table-location*) new-value))

;; MOP p. 75
(defgeneric class-direct-default-initargs (class)
  (:method ((class class))
    (check-class-initialized class 2)
    (sys::%record-ref class *<class>-direct-default-initargs-location*)))
(initialize-extended-method-check #'class-direct-default-initargs)
;; Not in MOP.
(defun (setf class-direct-default-initargs) (new-value class)
  (accessor-typecheck class 'class '(setf class-direct-default-initargs))
  (setf (sys::%record-ref class *<class>-direct-default-initargs-location*) new-value))

;; MOP p. 75
(defgeneric class-default-initargs (class)
  (:method ((class class))
    (check-class-finalized class 6)
    (sys::%record-ref class *<class>-default-initargs-location*)))
(initialize-extended-method-check #'class-default-initargs)
;; Not in MOP.
(defun (setf class-default-initargs) (new-value class)
  (accessor-typecheck class 'class '(setf class-default-initargs))
  (setf (sys::%record-ref class *<class>-default-initargs-location*) new-value))

;; Not in MOP.
(defun class-documentation (class)
  (accessor-typecheck class 'class 'class-documentation)
  (sys::%record-ref class *<class>-documentation-location*))
(defun (setf class-documentation) (new-value class)
  (accessor-typecheck class 'class '(setf class-documentation))
  (setf (sys::%record-ref class *<class>-documentation-location*) new-value))

;; Not in MOP.
(defun class-listeners (class)
  (accessor-typecheck class 'class 'class-listeners)
  (sys::%record-ref class *<class>-listeners-location*))
(defun (setf class-listeners) (new-value class)
  (accessor-typecheck class 'class '(setf class-listeners))
  (setf (sys::%record-ref class *<class>-listeners-location*) new-value))

;; Not in MOP.
(defun class-initialized (class)
  (accessor-typecheck class 'class 'class-initialized)
  (sys::%record-ref class *<class>-initialized-location*))
(defun (setf class-initialized) (new-value class)
  (accessor-typecheck class 'class '(setf class-initialized))
  (setf (sys::%record-ref class *<class>-initialized-location*) new-value))

;; Not in MOP.
(defun class-subclass-of-stablehash-p (class)
  (accessor-typecheck class 'slotted-class 'class-subclass-of-stablehash-p)
  (sys::%record-ref class *<slotted-class>-subclass-of-stablehash-p-location*))
(defun (setf class-subclass-of-stablehash-p) (new-value class)
  (accessor-typecheck class 'slotted-class '(setf class-subclass-of-stablehash-p))
  (setf (sys::%record-ref class *<slotted-class>-subclass-of-stablehash-p-location*) new-value))

;; Not in MOP.
(defun class-generic-accessors (class)
  (accessor-typecheck class 'slotted-class 'class-generic-accessors)
  (sys::%record-ref class *<slotted-class>-generic-accessors-location*))
(defun (setf class-generic-accessors) (new-value class)
  (accessor-typecheck class 'slotted-class '(setf class-generic-accessors))
  (setf (sys::%record-ref class *<slotted-class>-generic-accessors-location*) new-value))

;; Not in MOP.
(defun class-direct-accessors (class)
  (accessor-typecheck class 'slotted-class 'class-direct-accessors)
  (sys::%record-ref class *<slotted-class>-direct-accessors-location*))
(defun (setf class-direct-accessors) (new-value class)
  (accessor-typecheck class 'slotted-class '(setf class-direct-accessors))
  (setf (sys::%record-ref class *<slotted-class>-direct-accessors-location*) new-value))

;; Not in MOP.
(defun class-valid-initargs-from-slots (class)
  (accessor-typecheck class 'slotted-class 'class-valid-initargs-from-slots)
  (sys::%record-ref class *<slotted-class>-valid-initargs-from-slots-location*))
(defun (setf class-valid-initargs-from-slots) (new-value class)
  (accessor-typecheck class 'slotted-class '(setf class-valid-initargs-from-slots))
  (setf (sys::%record-ref class *<slotted-class>-valid-initargs-from-slots-location*) new-value))

;; Not in MOP.
(defun class-instance-size (class)
  (accessor-typecheck class 'slotted-class 'class-instance-size)
  (sys::%record-ref class *<slotted-class>-instance-size-location*))
(defun (setf class-instance-size) (new-value class)
  (accessor-typecheck class 'slotted-class '(setf class-instance-size))
  (setf (sys::%record-ref class *<slotted-class>-instance-size-location*) new-value))

;; Not in MOP.
(defun class-names (class)
  (accessor-typecheck class 'structure-class 'class-names)
  (sys::%record-ref class *<structure-class>-names-location*))
(defun (setf class-names) (new-value class)
  (accessor-typecheck class 'structure-class '(setf class-names))
  (setf (sys::%record-ref class *<structure-class>-names-location*) new-value))

;; Not in MOP.
(defun class-kconstructor (class)
  (accessor-typecheck class 'structure-class 'class-kconstructor)
  (sys::%record-ref class *<structure-class>-kconstructor-location*))
(defun (setf class-kconstructor) (new-value class)
  (accessor-typecheck class 'structure-class '(setf class-kconstructor))
  (setf (sys::%record-ref class *<structure-class>-kconstructor-location*) new-value))

;; Not in MOP.
(defun class-current-version (class)
  (accessor-typecheck class 'semi-standard-class 'class-current-version)
  (sys::%record-ref class *<semi-standard-class>-current-version-location*))
(defun (setf class-current-version) (new-value class)
  (accessor-typecheck class 'semi-standard-class '(setf class-current-version))
  (setf (sys::%record-ref class *<semi-standard-class>-current-version-location*) new-value))

;; Not in MOP.
(defun class-funcallablep (class)
  (accessor-typecheck class 'semi-standard-class 'class-instantiated)
  (sys::%record-ref class *<semi-standard-class>-funcallablep-location*))
(defun (setf class-funcallablep) (new-value class)
  (accessor-typecheck class 'semi-standard-class '(setf class-instantiated))
  (setf (sys::%record-ref class *<semi-standard-class>-funcallablep-location*) new-value))

;; Not in MOP.
(defun class-fixed-slot-locations (class)
  (accessor-typecheck class 'semi-standard-class 'class-fixed-slot-locations)
  (sys::%record-ref class *<semi-standard-class>-fixed-slot-locations-location*))
(defun (setf class-fixed-slot-locations) (new-value class)
  (accessor-typecheck class 'semi-standard-class '(setf class-fixed-slot-locations))
  (setf (sys::%record-ref class *<semi-standard-class>-fixed-slot-locations-location*) new-value))

;; Not in MOP.
(defun class-instantiated (class)
  (accessor-typecheck class 'semi-standard-class 'class-instantiated)
  (sys::%record-ref class *<semi-standard-class>-instantiated-location*))
(defun (setf class-instantiated) (new-value class)
  (accessor-typecheck class 'semi-standard-class '(setf class-instantiated))
  (setf (sys::%record-ref class *<semi-standard-class>-instantiated-location*) new-value))

;; Not in MOP.
(defun class-finalized-direct-subclasses-table (class)
  (accessor-typecheck class 'semi-standard-class 'class-finalized-direct-subclasses-table)
  (sys::%record-ref class *<semi-standard-class>-finalized-direct-subclasses-location*))
(defun (setf class-finalized-direct-subclasses-table) (new-value class)
  (accessor-typecheck class 'semi-standard-class '(setf class-finalized-direct-subclasses-table))
  (setf (sys::%record-ref class *<semi-standard-class>-finalized-direct-subclasses-location*) new-value))

;; MOP p. 77
(defgeneric class-prototype (class)
  (:method ((class semi-standard-class))
    (check-class-finalized class 6)
    (or (sys::%record-ref class *<semi-standard-class>-prototype-location*)
        (setf (sys::%record-ref class *<semi-standard-class>-prototype-location*)
              (let ((old-instantiated (class-instantiated class)))
                (prog1
                  (clos::%allocate-instance class)
                  ;; The allocation of the prototype doesn't need to flag the
                  ;; class as being instantiated, because 1. the prototype is
                  ;; thrown away when the class is redefined, 2. we don't want
                  ;; a redefinition with nonexistent or non-finalized
                  ;; superclasses to succeed despite of the prototype.
                  (setf (class-instantiated class) old-instantiated)))))))
(initialize-extended-method-check #'class-prototype)
;; Not in MOP.
(defun (setf class-prototype) (new-value class)
  (accessor-typecheck class 'semi-standard-class '(setf class-prototype))
  (setf (sys::%record-ref class *<semi-standard-class>-prototype-location*) new-value))

;;; ===========================================================================

;;; Class Finalization Protocol

;; MOP p. 76
(defgeneric class-finalized-p (class)
  (:method ((class class))
    (= (class-initialized class) 6))
  ;; CLISP extension: Convenience method on symbols.
  (:method ((name symbol))
    (class-finalized-p (find-class name))))
(initialize-extended-method-check #'class-finalized-p)

;; MOP p. 54
(defgeneric finalize-inheritance (class)
  (:method ((class semi-standard-class))
    (finalize-class class t))
  ;; CLISP extension: No-op method on other classes.
  (:method ((class class))
    class)
  ;; CLISP extension: Convenience method on symbols.
  (:method ((name symbol))
    (finalize-inheritance (find-class name))))
(initialize-extended-method-check #'finalize-inheritance)

;; MOP p. 38
(defgeneric compute-class-precedence-list (class)
  (:method ((class class))
    (compute-class-precedence-list-<class> class)))

;; MOP p. 42
(defgeneric compute-effective-slot-definition (class slotname direct-slot-definitions)
  (:method ((class class) slotname direct-slot-definitions)
    (compute-effective-slot-definition-<class> class slotname direct-slot-definitions)))

;; MOP p. 43
(defgeneric compute-slots (class)
  (:method ((class semi-standard-class))
    (compute-slots-<class>-primary class))
  (:method :around ((class semi-standard-class))
    (compute-slots-<slotted-class>-around class
      #'(lambda (c) (call-next-method c)))))

;; MOP p. 39
(defgeneric compute-default-initargs (class)
  (:method ((class class))
    (compute-default-initargs-<class> class)))

;;; ===========================================================================

;;; Class definition customization

;; MOP p. 47
(defgeneric ensure-class-using-class (class name
                                      &key metaclass
                                           direct-superclasses
                                           direct-slots
                                           direct-default-initargs
                                           documentation
                                           ; CLISP specific extension:
                                           fixed-slot-locations
                                      &allow-other-keys)
  (:method ((class class) name &rest args)
    (apply #'ensure-class-using-class-<t> class name args))
  (:method ((class null) name &rest args)
    (apply #'ensure-class-using-class-<t> class name args)))

;; MOP p. 102
(defgeneric validate-superclass (class superclass)
  (:method ((class class) (superclass class))
    (or (eq superclass <t>)
        (eq (class-of class) (class-of superclass))
        (and (eq (class-of class) <funcallable-standard-class>)
             (eq (class-of superclass) <standard-class>))
        ;; This makes no sense: If the superclass is a
        ;; funcallable-standard-class, it is a subclass of FUNCTION,
        ;; therefore class will become a subclass of FUNCTION too, but there
        ;; is no way to FUNCALL or APPLY it. Where did the MOP authors have
        ;; their brain here?
        (and (eq (class-of class) <standard-class>)
             (eq (class-of superclass) <funcallable-standard-class>))
        ;; Needed for clos-genfun1.lisp:
        (and (eq superclass <function>)
             (eq (class-classname class) 'funcallable-standard-object))
        ;; CLISP specific extension:
        (subclassp (class-of class) (class-of superclass)))))

;;; ===========================================================================

;;; Subclass relationship change notification

;; MOP p. 32
(defgeneric add-direct-subclass (class subclass)
  (:method ((class class) (subclass class))
    (add-direct-subclass-internal class subclass)))

;; MOP p. 90
(defgeneric remove-direct-subclass (class subclass)
  (:method ((class class) (subclass class))
    (remove-direct-subclass-internal class subclass)))

;;; ===========================================================================

;;; Accessor definition customization

;; MOP p. 86
(defgeneric reader-method-class (class direct-slot &rest initargs)
  (:method ((class class) direct-slot &rest initargs)
    (declare (ignore direct-slot initargs))
    <standard-reader-method>))

;; MOP p. 103
(defgeneric writer-method-class (class direct-slot &rest initargs)
  (:method ((class class) direct-slot &rest initargs)
    (declare (ignore direct-slot initargs))
    <standard-writer-method>))
