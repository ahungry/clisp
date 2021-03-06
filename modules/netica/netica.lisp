;;; Netica API interface
;;; <http://norsys.com/netica_c_api.htm>, version 3.25
;;;
;;; Copyright (C) 2003-2008 by Sam Steingold
;;; This is Free Software, distributed under the GNU GPL v2+
;;; See http://www.gnu.org/copyleft/gpl.html

(defpackage "NETICA"
  (:modern t)
  (:use "COMMON-LISP" "FFI")
  (:shadowing-import-from "EXPORTING"
    #:defconstant #:defvar #:defun #:defmacro #:define-symbol-macro
    #:def-c-type #:def-c-enum #:def-c-struct #:def-c-var #:def-call-out))

(in-package "NETICA")

(setf (documentation (find-package "NETICA") 'sys::impnotes) "netica")

(default-foreign-language :stdc)

(c-lines "#include <Netica.h>~%")

;;; types and constants

(define-symbol-macro UNDEF_DBL (undef_dbl_func_ns))
(define-symbol-macro INFINITY_ns (inf_dbl_func_ns))

(eval-when (compile eval load)
  (defconstant MESG_LEN_ns 600))

(def-c-const NAME_MAX_ns)

(def-c-enum checking_ns
  (NO_CHECK 1)
  QUICK_CHECK
  REGULAR_CHECK
  COMPLETE_CHECK
  (QUERY_CHECK -1))

(def-c-enum errseverity_ns
  (NOTHING_ERR 1)
  REPORT_ERR
  NOTICE_ERR
  WARNING_ERR
  ERROR_ERR
  XXX_ERR)

(def-c-enum errcond_ns
  (OUT_OF_MEMORY_CND  #x08)
  (USER_ABORTED_CND   #x20)
  (FROM_WRAPPER_CND   #x40)
  (FROM_DEVELOPER_CND #x80)
  (INCONS_FINDING_CND #x200))

(def-c-enum eventtype_ns
  (CREATE_EVENT #x01)
  (DUPLICATE_EVENT #x02)
  (REMOVE_EVENT #x04))

(def-c-enum nodetype_bn
  (CONTINUOUS_TYPE 1)
  DISCRETE_TYPE
  TEXT_TYPE)

(def-c-enum nodekind_bn
  (NATURE_NODE 1)
  CONSTANT_NODE
  DECISION_NODE
  UTILITY_NODE
  DISCONNECTED_NODE)

(def-c-enum wtf??
  (REAL_VALUE -25)
  (STATE_VALUE -20)
  (GAUSSIAN_VALUE -15)
  (INTERVAL_VALUE -10)
  (STATE_NOT_VALUE -7)
  LIKELIHOOD_VALUE
  (NO_VALUE -3))

;; special values for state_bn
(def-c-enum state_bn-special-values
  (EVERY_STATE -5)
  IMPOSS_STATE
  UNDEF_STATE)

;; for GetNodeFinding_bn
(def-c-enum get-node-finding-values
  (NEGATIVE_FINDING -7)
  LIKELIHOOD_FINDING
  (NO_FINDING -3))

;; special values for caseposn_bn
(def-c-enum caseposn_bn-special-values
  (FIRST_CASE -15)
  NEXT_CASE
  NO_MORE_CASES)

;; for NewSensvToFinding_bn
(def-c-enum new-sensv-to-finding-values
  (ENTROPY_SENSV #x02)
  (REAL_SENSV #x04)
  (VARIANCE_SENSV #x100)
  (VARIANCE_OF_REAL_SENSV #x104))

;;(def-c-struct (environ_ins :external))
(def-c-type environ_ns_ c-pointer) ; environ_ins
;;(def-c-struct (report_ins :external))
(def-c-type report_ns_ c-pointer) ; report_ins
;;(def-c-struct (stream_ins :external))
(def-c-type stream_ns_ c-pointer) ; stream_ins
;;(def-c-struct (net_ibn :external))
(def-c-type net_bn_ c-pointer)  ; net_ibn
;;(def-c-struct (node_ibn :external))
(def-c-type node_bn_ c-pointer) ; node_ibn
;;(def-c-struct (nodelist_ibn :external))
(def-c-type nodelist_bn_ c-pointer) ; nodelist_ibn
;(def-c-struct (caseset_ics :external))
(def-c-type caseset_cs_ c-pointer) ; caseset_ics
;;(def-c-struct (learner_ibn :external))
(def-c-type learner_bn_ c-pointer) ; learner_ibn
;;(def-c-struct (test_ibn :external))
(def-c-type test_bn_ c-pointer) ; test_ibn
;;(def-c-struct (sensv_ibn :external))
(def-c-type sensv_bn_ c-pointer) ; sensv_ibn
;;(def-c-struct (setting_ibn :external))
(def-c-type setting_bn_ c-pointer) ; setting_ibn
;;(def-c-struct (dbmgr_ics :external))
(def-c-type dbmgr_cs_ c-pointer) ; dbmgr_ics

;; use UNDEF_DBL in your software
(ffi:def-call-out GetUndefDbl_ns (:arguments) (:return-type double-float))
;; use INFINITY_ns in your software
(ffi:def-call-out GetInfinityDbl_ns (:arguments) (:return-type double-float))

(def-c-type state_bn int)
(def-c-type prob_bn single-float)
(def-c-type util_bn single-float)
(def-c-type level_bn double-float)

(def-c-type color_ns int) ; most significant byte(s) is 0, and last 3 bytes are red, green, blue
(def-c-type caseposn_bn long)
(def-c-type bool_ns uchar)

(def-c-enum learn_method_bn
  (COUNTING_LEARNING 1)
  (EM_LEARNING 3)
  GRADIENT_DESCENT_LEARNING)

;; for ReadNet_bn
(def-c-enum read-net-values
  (NO_VISUAL_INFO 0)
  (NO_WINDOW #x10)
  (MINIMIZED_WINDOW #x30)
  (REGULAR_WINDOW #x70))

(defconstant BELIEF_UPDATE #x100 "for SetNetAutoUpdate_bn")
(defconstant LAST_ENTRY -10)
(defconstant QUERY_ns -1)

;;; foreign function definitions

(def-call-out NewNeticaEnviron_ns (:return-type environ_ns_)
  (:arguments (license c-string) (env environ_ns_) (locn c-string)))
(def-call-out InitNetica2_bn (:return-type int)
  (:arguments (envp environ_ns_)
              (mesg (c-ptr (c-array-max character #.MESG_LEN_ns)) :out)))
(def-call-out CloseNetica_bn (:return-type int)
  (:arguments (env environ_ns_)
              (mesg (c-ptr (c-array-max character #.MESG_LEN_ns)) :out)))
(def-call-out GetNeticaVersion_bn (:return-type int)
  (:arguments (env environ_ns_)
              (version (c-ptr c-string) :out :none)))

(def-call-out ArgumentChecking_ns (:return-type checking_ns)
  (:arguments (setting checking_ns) (env environ_ns_)))
(def-call-out SetLanguage_ns (:return-type c-string) ; undocumented
  (:arguments (language c-string) (env environ_ns_)))
(def-call-out LimitMemoryUsage_ns (:return-type double-float)
  (:arguments (max_mem double-float) (env environ_ns_)))
(def-call-out ExecuteScript_ns (:return-type c-string) ; undocumented
  (:arguments (env environ_ns_) (language c-string) (script c-string)))

(def-call-out SetEnvironUserData_ns (:return-type nil) ; undocumented
    (:arguments (env environ_ns_) (kind int) (data c-pointer)))
(def-call-out GetEnvironUserData_ns (:return-type c-pointer) ; undocumented
    (:arguments (env environ_ns_) (kind int)))

(def-call-out GetError_ns (:return-type report_ns_)
  (:arguments (env environ_ns_) (severity errseverity_ns)
              (after report_ns_)))
(def-call-out ErrorNumber_ns (:return-type int)
  (:arguments (error report_ns_)))
(def-call-out ErrorMessage_ns (:return-type c-string)
  (:arguments (error report_ns_)))
(def-call-out ErrorSeverity_ns (:return-type errseverity_ns)
  (:arguments (error report_ns_)))
(def-call-out ErrorCategory_ns (:return-type bool_ns)
  (:arguments (cond errcond_ns) (error report_ns_)))
(def-call-out ClearError_ns (:return-type nil)
  (:arguments (error report_ns_)))
(def-call-out ClearErrors_ns (:return-type nil)
  (:arguments (env environ_ns_) (severity errseverity_ns)))
(def-call-out NewError_ns (:return-type report_ns_)
  (:arguments (env environ_ns_) (number int) (severity errseverity_ns)
              (mesg (c-ptr (c-array character #.MESG_LEN_ns)) :out)))

(def-call-out TestFaultRecovery_ns (:return-type bool_ns) ; undocumented
  (:arguments (env environ_ns_) (test_num int)))

(def-call-out GetAppWindowPosition_ns (:return-type nil)
  (:arguments (env environ_ns_)
              (left (c-ptr int) :out) (top (c-ptr int) :out)
              (width (c-ptr int) :out) (height (c-ptr int) :out)
              (status (c-ptr int) :out)))
(def-call-out SetAppWindowPosition_ns (:return-type nil)
  (:arguments (env environ_ns_)
              (left int) (top int) (width int) (height int) (status int)))

(def-call-out UserAllowed_ns (:return-type int) ; undocumented
    (:arguments (setting int) (env environ_ns_)))

(def-call-out PrintToMessagesWindow_ns (:return-type nil) ; undocumented
  (:arguments (env environ_ns_) (mesg c-string)))

(def-call-out NewFileStream_ns (:return-type stream_ns_)
  (:arguments (filename c-string) (env environ_ns_) (access c-pointer)))
(def-call-out NewMemoryStream_ns (:return-type stream_ns_)
  (:arguments (name c-string) (env environ_ns_) (access c-pointer)))
(def-call-out DeleteStream_ns (:return-type nil)
  (:arguments (file stream_ns_)))
(def-call-out SetStreamPassword_ns (:return-type nil)
  (:arguments (strm stream_ns_) (password c-string)))
(def-call-out SetStreamContents_ns (:return-type nil)
  (:arguments (strm stream_ns_) (buffer c-string)
              (length long) (copy bool_ns)))
(def-call-out GetStreamContents_ns (:return-type c-pointer)
  (:arguments (strm stream_ns_) (length (c-ptr long) :out)))

(def-call-out WriteNet_bn (:return-type nil)
  (:arguments (net net_bn_) (file stream_ns_)))
(def-call-out ReadNet_bn (:return-type net_bn_)
  (:arguments (file stream_ns_) (visual int)))
(def-call-out WriteNetFindings_bn (:return-type caseposn_bn)
  (:arguments (nodes nodelist_bn_) (file stream_ns_)
              (ID_num long) (freq double-float)))
(def-call-out ReadNetFindings_bn (:return-type nil)
  (:arguments (case_posn (c-ptr caseposn_bn)) (file stream_ns_)
              (nodes nodelist_bn_) (ID_num (c-ptr long))
              (freq (c-ptr double-float))))

(def-call-out SetCaseFileDelimChar_ns (:return-type int)
  (:arguments (newchar int) (env environ_ns_)))
(def-call-out SetMissingDataChar_ns (:return-type int)
  (:arguments (newchar int) (env environ_ns_)))

(def-call-out NewNet_bn (:return-type net_bn_)
  (:arguments (name c-string) (env environ_ns_)))
(def-call-out CopyNet_bn (:return-type net_bn_)
  (:arguments (net net_bn_) (new_name c-string)
              (new_env environ_ns_) (control c-string)))
(def-call-out DeleteNet_bn (:return-type nil)
  (:arguments (net net_bn_)))
(def-call-out GetNthNet_bn (:return-type net_bn_)
  (:arguments (nth int) (env environ_ns_)))
(def-call-out NewNode_bn (:return-type node_bn_)
  (:arguments (name c-string) (num_states int) (net net_bn_)))
(def-call-out CopyNodes_bn (:return-type nodelist_bn_)
  (:arguments (nodes nodelist_bn_) (new_net net_bn_)))
(def-call-out DeleteNode_bn (:return-type nil)
  (:arguments (node node_bn_)))
(def-call-out AddLink_bn (:return-type int)
  (:arguments (parent node_bn_) (child node_bn_)))
(def-call-out DeleteLink_bn (:return-type nil)
  (:arguments (link_index int) (child node_bn_)))
(def-call-out SwitchNodeParent_bn (:return-type nil)
  (:arguments (link_index int) (node node_bn_)
              (new_parent node_bn_)))

(def-call-out GetRelatedNodes_bn (:return-type nil)
  (:arguments (related_nodes nodelist_bn_) (relation c-string)
              (node node_bn_)))
(def-call-out GetRelatedNodesMult_bn (:return-type nil)
  (:arguments (related_nodes nodelist_bn_) (relation c-string)
              (nodes nodelist_bn_)))
(def-call-out IsNodeRelated_bn (:return-type bool_ns)
  (:arguments (related_node node_bn_) (relation c-string) (node node_bn_)))

(def-call-out SetNetName_bn (:return-type nil)
  (:arguments (net net_bn_) (name c-string)))
(def-call-out SetNetTitle_bn (:return-type nil)
  (:arguments (net net_bn_) (title c-string)))
(def-call-out SetNetComment_bn (:return-type nil)
  (:arguments (net net_bn_) (comment c-string)))
(def-call-out SetNetElimOrder_bn (:return-type nil)
  (:arguments (net net_bn_) (elim_order nodelist_bn_)))
(def-call-out SetNetAutoUpdate_bn (:return-type int)
  (:arguments (net net_bn_) (autoupdate int)))
(def-call-out SetNetUserField_bn (:return-type nil)
  (:arguments (net net_bn_) (name c-string) (data c-pointer)
              (length int) (kind int)))
(def-call-out SetNetUserData_bn (:return-type nil)
  (:arguments (net net_bn_) (kind int) (data c-pointer)))
(def-call-out AddNetListener_bn (:return-type nil)
  (:arguments (net net_bn_)
              (callback (c-function (:arguments (node net_bn_)
                                                (what eventtype_ns)
                                                (obj c-pointer)
                                                (data c-pointer))
                                    (:return-type int)))
              (obj c-pointer) (filter int)))

(def-call-out SetNodeName_bn (:return-type nil)
  (:arguments (node node_bn_) (name c-string)))
(def-call-out SetNodeTitle_bn (:return-type nil)
  (:arguments (node node_bn_) (title c-string)))
(def-call-out SetNodeComment_bn (:return-type nil)
  (:arguments (node node_bn_) (comment c-string)))
(def-call-out SetNodeLevels_bn (:return-type nil)
  (:arguments (node node_bn_) (num_states int)
              (levels (c-array-ptr level_bn))))
(def-call-out SetNodeKind_bn (:return-type nil)
  (:arguments (node node_bn_) (kind nodekind_bn)))
(def-call-out SetNodeStateName_bn (:return-type nil)
  (:arguments (node node_bn_) (state state_bn) (state_name c-string)))
(def-call-out SetNodeStateNames_bn (:return-type nil)
  (:arguments (node node_bn_) (state_names c-string)))
(def-call-out SetNodeStateTitle_bn (:return-type nil)
  (:arguments (node node_bn_) (state state_bn) (state_title c-string)))
(def-call-out SetNodeStateComment_bn (:return-type nil)
  (:arguments (node node_bn_) (state state_bn) (state_comment c-string)))
(def-call-out SetNodeInputName_bn (:return-type nil)
  (:arguments (node node_bn_) (link_index int) (link_name c-string)))
(def-call-out SetNodeEquation_bn (:return-type nil)
  (:arguments (node node_bn_) (eqn c-string)))
(def-call-out SetNodeFuncState_bn (:return-type nil)
  (:arguments (node node_bn_) (parent_states (c-array-ptr state_bn))
              (st state_bn)))
(def-call-out SetNodeFuncReal_bn (:return-type nil)
  (:arguments (node node_bn_) (parent_states (c-array-ptr state_bn))
              (val double-float)))
(def-call-out SetNodeProbs_bn (:return-type nil)
  (:arguments (node node_bn_)
              (parent_states (c-array-ptr state_bn))
              (probs (c-array-ptr prob_bn))))
(def-call-out SetNodeExperience_bn (:return-type nil)
  (:arguments (node node_bn_) (parent_states (c-array-ptr state_bn))
              (experience double-float)))
(def-call-out DeleteNodeTables_bn (:return-type nil)
  (:arguments (node node_bn_)))
(def-call-out SetNodeUserField_bn (:return-type nil)
  (:arguments (node node_bn_) (name c-string) (data c-pointer)
              (length int) (kind int)))
(def-call-out SetNodeUserData_bn (:return-type nil)
  (:arguments (node node_bn_) (kind int) (data c-pointer)))
(def-call-out AddNodeListener_bn (:return-type nil)
  (:arguments (node node_bn_)
              (callback (c-function (:arguments (node node_bn_)
                                                (what eventtype_ns)
                                                (obj c-pointer)
                                                (data c-pointer))
                                    (:return-type int)))
              (obj c-pointer) (filter int)))
(def-call-out SetNodeVisPosition_bn (:return-type nil)
  (:arguments (node node_bn_) (vis c-pointer)
              (x double-float) (y double-float)))
(def-call-out SetNodeVisStyle_bn (:return-type nil)
  (:arguments (node node_bn_) (vis c-pointer) (style c-string)))

(def-call-out GetNetName_bn (:return-type c-string)
  (:arguments (net net_bn_)))
(def-call-out GetNetTitle_bn (:return-type c-string)
  (:arguments (net net_bn_)))
(def-call-out GetNetComment_bn (:return-type c-string)
  (:arguments (net net_bn_)))
(def-call-out GetNetNodes_bn (:return-type nodelist_bn_)
  (:arguments (net net_bn_)))
(def-call-out GetNodeNamed_bn (:return-type node_bn_)
  (:arguments (name c-string) (net net_bn_)))
(def-call-out GetNetFileName_bn (:return-type c-string)
  (:arguments (net net_bn_)))
(def-call-out GetNetElimOrder_bn (:return-type nodelist_bn_)
  (:arguments (net net_bn_)))
(def-call-out GetNetAutoUpdate_bn (:return-type int)
  (:arguments (net net_bn_)))
(def-call-out GetNetUserField_bn (:return-type c-string)
  (:arguments (net net_bn_) (name c-string) (length (c-ptr int) :out)
              (kind int)))
(def-call-out GetNetNthUserField_bn (:return-type nil)
  (:arguments (net net_bn_) (index int)
              (name (c-ptr c-string) :out) (value (c-ptr c-string) :out)
              (length (c-ptr int) :out) (kind int)))
(def-call-out GetNetUserData_bn (:return-type c-pointer)
  (:arguments (net net_bn_) (kind int)))

(def-call-out GetNodeNet_bn (:return-type net_bn_)
  (:arguments (node node_bn_)))
(def-call-out GetNodeName_bn (:return-type c-string)
  (:arguments (node node_bn_)))
(def-call-out GetNodeTitle_bn (:return-type c-string)
  (:arguments (node node_bn_)))
(def-call-out GetNodeComment_bn (:return-type c-string)
  (:arguments (node node_bn_)))
(def-call-out GetNodeType_bn (:return-type nodetype_bn)
  (:arguments (node node_bn_)))
(def-call-out GetNodeKind_bn (:return-type nodekind_bn)
  (:arguments (node node_bn_)))
(def-call-out GetNodeNumberStates_bn (:return-type int)
  (:arguments (node node_bn_)))
(def-call-out GetNodeLevels_bn (:return-type c-pointer) ; level_bn[]
  (:arguments (node node_bn_)))
(def-call-out GetNodeStateName_bn (:return-type c-string)
  (:arguments (node node_bn_) (state state_bn)))
(def-call-out GetNodeStateTitle_bn (:return-type c-string)
  (:arguments (node node_bn_) (state state_bn)))
(def-call-out GetNodeStateComment_bn (:return-type c-string)
  (:arguments (node node_bn_) (state state_bn)))
(def-call-out GetStateNamed_bn (:return-type state_bn)
  (:arguments (name c-string) (node node_bn_)))
(def-call-out GetNodeParents_bn (:return-type nodelist_bn_)
  (:arguments (node node_bn_)))
(def-call-out GetNodeChildren_bn (:return-type nodelist_bn_)
  (:arguments (node node_bn_)))
(def-call-out GetNodeInputName_bn (:return-type c-string)
  (:arguments (node node_bn_) (link_index int)))
(def-call-out GetInputNamed_bn (:return-type int)
  (:arguments (name c-string) (node node_bn_)))
(def-call-out GetNodeEquation_bn (:return-type c-string)
  (:arguments (node node_bn_)))
(def-call-out GetNodeFuncState_bn (:return-type state_bn)
  (:arguments (node node_bn_) (parent_states (c-array-ptr state_bn))))
(def-call-out GetNodeFuncReal_bn (:return-type double-float)
  (:arguments (node node_bn_) (parent_states (c-array-ptr state_bn))))
(def-call-out GetNodeProbs_bn (:return-type c-pointer) ; prob_bn[]
  (:arguments (node node_bn_) (parent_states (c-array-ptr state_bn))))
(def-call-out GetNodeExperience_bn (:return-type double-float)
  (:arguments (node node_bn_) (parent_states (c-array-ptr state_bn))))
(def-call-out HasNodeTable_bn (:return-type bool_ns)
  (:arguments (node node_bn_) (complete (c-ptr bool_ns) :out)))
(def-call-out IsNodeDeterministic_bn (:return-type bool_ns)
  (:arguments (node node_bn_)))
(def-call-out GetNodeUserField_bn (:return-type c-string)
  (:arguments (node node_bn_) (name c-string) (length (c-ptr int) :out)
              (kind int)))
(def-call-out GetNodeNthUserField_bn (:return-type nil)
  (:arguments (node node_bn_) (index int)
              (name (c-ptr c-string) :out) (value (c-ptr c-string) :out)
              (length (c-ptr int) :out) (kind int)))
(def-call-out GetNodeUserData_bn (:return-type c-pointer)
  (:arguments (node node_bn_) (kind int)))
(def-call-out GetNodeVisPosition_bn (:return-type nil)
  (:arguments (node node_bn_) (vis c-pointer)
              (x (c-ptr double-float) :out) (y (c-ptr double-float) :out)))
(def-call-out GetNodeVisStyle_bn (:return-type c-string)
  (:arguments (node node_bn_) (vis c-pointer)))

(def-call-out NewNodeList2_bn (:return-type nodelist_bn_)
  (:arguments (length int) (net net_bn_)))
(def-call-out DeleteNodeList_bn (:return-type nil)
  (:arguments (nodes nodelist_bn_)))
(def-call-out ClearNodeList_bn (:return-type nil)
  (:arguments (nodes nodelist_bn_)))
(def-call-out AddNodeToList_bn (:return-type nil)
  (:arguments (node node_bn_) (nodes nodelist_bn_) (index int)))
(def-call-out RemoveNthNode_bn (:return-type node_bn_)
  (:arguments (nodes nodelist_bn_) (index int)))
(def-call-out LengthNodeList_bn (:return-type int)
  (:arguments (nodes nodelist_bn_)))
(def-call-out NthNode_bn (:return-type node_bn_)
  (:arguments (nodes nodelist_bn_) (index int)))
(def-call-out SetNthNode_bn (:return-type nil)
  (:arguments (nodes nodelist_bn_) (index int) (node node_bn_)))
(def-call-out IndexOfNodeInList_bn (:return-type int)
  (:arguments (node node_bn_) (nodes nodelist_bn_)
              (start_index int)))
(def-call-out DupNodeList_bn (:return-type nodelist_bn_)
  (:arguments (nodes nodelist_bn_)))

(def-call-out MapStateList_bn (:return-type nil)
  (:arguments (src_states (c-array-ptr state_bn)) (src_nodes nodelist_bn_)
              (dest_states (c-array-ptr state_bn)) (dest_nodes nodelist_bn_)))

(def-call-out ReviseCPTsByFindings_bn (:return-type nil)
  (:arguments (nodes nodelist_bn_) (updating int) (degree double-float)))
(def-call-out ReviseCPTsByCaseFile_bn (:return-type nil)
  (:arguments (file stream_ns_) (nodes nodelist_bn_)
              (updating int) (degree double-float)))
(def-call-out FadeCPTable_bn (:return-type nil)
  (:arguments (node node_bn_) (degree double-float)))

(def-call-out AddNodeStates_bn (:return-type nil)
  (:arguments (node node_bn_) (first_state state_bn) (state_names c-string)
              (num_states int) (cpt_fill double-float)))
(def-call-out RemoveNodeState_bn (:return-type nil)
  (:arguments (node node_bn_) (state state_bn)))
(def-call-out ReorderNodeStates_bn (:return-type nil)
  (:arguments (node node_bn_) (new_order (c-array-ptr state_bn))))
(def-call-out EquationToTable_bn (:return-type nil)
  (:arguments (node node_bn_) (num_samples int)
              (samp_unc bool_ns) (add_exist bool_ns)))
(def-call-out ReverseLink_bn (:return-type nil)
  (:arguments (parent node_bn_) (child node_bn_)))
(def-call-out AbsorbNodes_bn (:return-type nil)
  (:arguments (nodes nodelist_bn_)))

(def-call-out EnterFinding_bn (:return-type nil)
  (:arguments (node node_bn_) (state state_bn)))
(def-call-out EnterFindingNot_bn (:return-type nil)
  (:arguments (node node_bn_) (state state_bn)))
(def-call-out EnterNodeValue_bn (:return-type nil)
  (:arguments (node node_bn_) (value double-float)))
(def-call-out EnterNodeLikelihood_bn (:return-type nil)
  (:arguments (node node_bn_) (likelihood (c-array-ptr prob_bn))))
(def-call-out EnterIntervalFinding_bn (:return-type nil)
  (:arguments (node node_bn_) (low double-float) (high double-float)))
(def-call-out EnterGaussianFinding_bn (:return-type nil)
  (:arguments (node node_bn_) (mean double-float) (std_dev double-float)))
(def-call-out GetNodeFinding_bn (:return-type state_bn)
  (:arguments (node node_bn_)))
(def-call-out GetNodeValueEntered_bn (:return-type double-float)
  (:arguments (node node_bn_)))
(def-call-out GetNodeLikelihood_bn (:return-type c-pointer) ; prob_bn[]
  (:arguments (node node_bn_)))
(def-call-out RetractNodeFindings_bn (:return-type nil)
  (:arguments (node node_bn_)))
(def-call-out RetractNetFindings_bn (:return-type nil)
  (:arguments (net net_bn_)))

(def-call-out CalcNodeState_bn (:return-type state_bn)
  (:arguments (node node_bn_)))
(def-call-out CalcNodeValue_bn (:return-type double-float)
  (:arguments (node node_bn_)))

(def-call-out CompileNet_bn (:return-type nil)
  (:arguments (net net_bn_)))
(def-call-out UncompileNet_bn (:return-type nil)
  (:arguments (net net_bn_)))
(def-call-out SizeCompiledNet_bn (:return-type double-float)
  (:arguments (net net_bn_) (method int)))
(def-call-out ReportJunctionTree_bn (:return-type c-string)
  (:arguments (net net_bn_)))
(def-call-out IsBeliefUpdated_bn (:return-type bool_ns)
  (:arguments (node node_bn_)))
(def-call-out GetNodeBeliefs_bn (:return-type c-pointer) ; prob_bn[]
  (:arguments (node node_bn_)))
(def-call-out GetNodeExpectedValue_bn (:return-type double-float)
  (:arguments (node node_bn_) (stddev (c-ptr double-float) :out)
              (x3 (c-ptr double-float) :out) (x4 (c-ptr double-float) :out)))
(def-call-out GetNodeExpectedUtils_bn (:return-type c-pointer) ; util_bn[]
  (:arguments (node node_bn_)))
(def-call-out FindingsProbability_bn (:return-type double-float)
  (:arguments (net net_bn_)))
(def-call-out GetNetExpectedUtility_bn (:return-type util_bn)
  (:arguments (net net_bn_)))
(def-call-out JointProbability_bn (:return-type double-float)
  (:arguments (nodes nodelist_bn_) (states (c-array-ptr state_bn))))
(def-call-out MostProbableConfig_bn (:return-type nil)
  (:arguments (nodes nodelist_bn_) (config (c-array-ptr state_bn)) (nth int)))

(def-call-out GenerateRandomCase_bn (:return-type int)
  (:arguments (nodes nodelist_bn_) (method int) (num double-float)
              (gen c-pointer)))

(def-call-out AddNodeToNodeset_bn (:return-type nil)
  (:arguments (node node_bn_) (nodeset c-string)))
(def-call-out RemoveNodeFromNodeset_bn (:return-type nil)
  (:arguments (node node_bn_) (nodeset c-string)))
(def-call-out IsNodeInNodeset_bn (:return-type bool_ns)
  (:arguments (node node_bn_) (nodeset c-string)))
(def-call-out GetAllNodesets_bn (:return-type c-string)
  (:arguments (net net_bn_) (include_system bool_ns) (vis c-pointer)))
(def-call-out SetNodesetColor_bn (:return-type color_ns)
  (:arguments (nodeset c-string) (color color_ns)
              (net net_bn_) (vis c-pointer)))
(def-call-out ReorderNodesets_bn (:return-type nil)
  (:arguments (net net_bn_) (nodeset_order c-string) (vis c-pointer)))

(def-call-out NewSensvToFinding_bn (:return-type sensv_bn_)
  (:arguments (Qnode node_bn_) (Fnodes nodelist_bn_) (what_find int)))
(def-call-out DeleteSensvToFinding_bn (:return-type nil)
  (:arguments (s sensv_bn_)))
(def-call-out MutualInfo_bn (:return-type double-float)
  (:arguments (s sensv_bn_) (Fnode node_bn_)))
(def-call-out VarianceOfReal_bn (:return-type double-float)
  (:arguments (s sensv_bn_) (Fnode node_bn_)))

(def-call-out NewCaseset_cs (:return-type caseset_cs_)
  (:arguments (name c-string) (env environ_ns_)))
(def-call-out DeleteCaseset_cs (:return-type nil)
  (:arguments (cases caseset_cs_)))
(def-call-out AddFileToCaseset_cs (:return-type nil)
  (:arguments (cases caseset_cs_) (file stream_ns_)
              (degree double-float) (control c-string)))
(def-call-out WriteCaseset_cs (:return-type nil)
  (:arguments (cases caseset_cs_) (file stream_ns_) (control c-string)))

(def-call-out NewDBManager_cs (:return-type dbmgr_cs_)
  (:arguments (connect_str c-string) (control c-string) (env environ_ns_)))
(def-call-out DeleteDBManager_cs (:return-type nil)
  (:arguments (dbmgr dbmgr_cs_)))
(def-call-out ExecuteDBSql_cs (:return-type nil)
  (:arguments (dbmgr dbmgr_cs_) (sql_cmnd c-string) (control c-string)))
(def-call-out InsertFindingsIntoDB_bn (:return-type nil)
  (:arguments (dbmgr dbmgr_cs_) (nodes nodelist_bn_)
              (column_names c-string) (tables c-string) (control c-string)))
(def-call-out AddDBCasesToCaseset_cs (:return-type nil)
  (:arguments (cases caseset_cs_) (dbmgr dbmgr_cs_) (degree double-float)
              (nodes nodelist_bn_) (column_names c-string) (tables c-string)
              (condition c-string) (control c-string)))
(def-call-out AddNodesFromDB_bn (:return-type nil)
  (:arguments (dbmgr dbmgr_cs_) (net net_bn_)
              (column_names c-string) (tables c-string)
              (condition c-string) (control c-string)))

(def-call-out NewLearner_bn (:return-type learner_bn_)
  (:arguments (method learn_method_bn) (info c-string) (env environ_ns_)))
(def-call-out DeleteLearner_bn (:return-type nil)
  (:arguments (algo learner_bn_)))
(def-call-out SetLearnerMaxIters_bn (:return-type int)
  (:arguments (algo learner_bn_) (max_iters int)))
(def-call-out SetLearnerMaxTol_bn (:return-type double-float)
  (:arguments (algo learner_bn_) (log_likeli_tol double-float)))
(def-call-out LearnCPTs_bn (:return-type nil)
  (:arguments (algo learner_bn_) (nodes nodelist_bn_) (cases caseset_cs_)
              (degree double-float)))

(def-call-out NewNetTester_bn (:return-type test_bn_)
  (:arguments (test_nodes nodelist_bn_)
              (unobsv_nodes nodelist_bn_) (tests int)))
(def-call-out DeleteNetTester_bn (:return-type nil)
  (:arguments (test test_bn_)))
(def-call-out TestWithCaseset_bn (:return-type nil)
  (:arguments (test test_bn_) (file stream_ns_)))
(def-call-out GetTestConfusion_bn (:return-type double-float)
  (:arguments (test test_bn_) (node node_bn_)
              (predicted state_bn) (actual state_bn)))
(def-call-out GetTestErrorRate_bn (:return-type double-float)
  (:arguments (test test_bn_) (node node_bn_)))
(def-call-out GetTestLogLoss_bn (:return-type double-float)
  (:arguments (test test_bn_) (node node_bn_)))
(def-call-out GetTestQuadraticLoss_bn (:return-type double-float)
  (:arguments (test test_bn_) (node node_bn_)))

(def-call-out UndoNetLastOper_bn (:return-type int)
  (:arguments (net net_bn_) (to_when double-float)))
(def-call-out RedoNetOper_bn (:return-type int)
  (:arguments (net net_bn_) (to_when double-float)))


(def-call-out NewSetting_bn (:return-type setting_bn_)
  (:arguments (nodes nodelist_bn_) (load bool_ns)))
(def-call-out DeleteSetting_bn (:return-type nil)
  (:arguments (cas setting_bn_)))
(def-call-out SetSettingState_bn (:return-type nil)
  (:arguments (cas setting_bn_) (node node_bn_) (state state_bn)))
(def-call-out GetSettingState_bn (:return-type state_bn)
  (:arguments (cas setting_bn_) (bnd node_bn_)))
(def-call-out ZeroSetting_bn (:return-type nil)
  (:arguments (cas setting_bn_)))
(def-call-out NextSetting_bn (:return-type bool_ns)
  (:arguments (cas setting_bn_)))
(def-call-out MostProbableSetting_bn (:return-type nil)
  (:arguments (cas setting_bn_) (nth int)))

(def-call-out NthProb_bn (:return-type double-float)
  (:arguments (probs (c-array-ptr prob_bn)) (state state_bn)))
(def-call-out NthLevel_bn (:return-type double-float)
  (:arguments (levels (c-array-ptr level_bn)) (state state_bn)))
(def-call-out GetChars_ns (:return-type int)
  (:arguments (str c-string) (index int) (dest c-string) (num int)))
(def-call-out NthChar_ns (:return-type int)
  (:arguments (str c-string) (index int)))
(def-call-out SetNthState_bn (:return-type nil)
  (:arguments (states (c-array-ptr state_bn)) (index int) (state state_bn)))

(def-call-out OptimizeDecisions_bn (:return-type nil)
  (:arguments (nodes nodelist_bn_)))

(pushnew :netica *features*)
(provide "netica")
(pushnew "NETICA" custom:*system-package-list* :test #'string=)
