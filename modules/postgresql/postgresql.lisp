;; Foreign functions provided by PostgreSQL

(defpackage "SQL"
  (:case-sensitive t)
  (:nicknames "POSTGRES" "POSTGRESQL")
  (:use))

(eval-when (compile eval)
  (load "../exporting")
  (make-exporting "SQL"
    cl:compile cl:eval cl:load cl:defconstant
    ffi:bitsizeof ffi:boolean ffi:char ffi:character ffi:c-array
    ffi:c-array-max ffi:c-array-ptr ffi:c-function ffi:c-ptr ffi:c-pointer
    ffi:c-string ffi:c-struct ffi:deref ffi:double-float ffi:element ffi:int
    ffi:long ffi:nil ffi:short ffi:sint8 ffi:sint16 ffi:sint32 ffi:sint64
    ffi:single-float ffi:sizeof ffi:slot ffi:uchar ffi:uint ffi:uint8
    ffi:uint16 ffi:uint32 ffi:uint64 ffi:ulong ffi:ushort))

(in-package "SQL")

(ffi:default-foreign-language :stdc)

(c-lines "#include <postgres_ext.h>~%")

(def-c-type Oid uint)

(eval-when (load compile eval)
  (defconstant NAMEDATALEN 32)
  (defconstant OIDNAMELEN 36))

(c-lines "#include <libpq-fe.h>~%")

(def-c-enum ConnStatusType CONNECTION_OK CONNECTION_BAD)

(def-c-enum ExecStatusType
    PGRES_EMPTY_QUERY PGRES_COMMAND_OK PGRES_TUPLES_OK PGRES_COPY_OUT
    PGRES_COPY_IN PGRES_BAD_RESPONSE PGRES_NONFATAL_ERROR PGRES_FATAL_ERROR)

(def-call-out PQresStatus
    (:arguments (status ExecStatusType))
  (:return-type c-string))

;;(def-c-type PGconn (c-struct vector)) ; components unknown
;;(def-c-type PGresult (c-struct vector)) ; components unknown
;;(def-c-struct PGconn) ; components unknown
;;(def-c-struct PGresult) ; components unknown
(def-c-type PGconn c-pointer) ; components unknown
(def-c-type PGresult c-pointer) ; components unknown

#|
 (def-c-struct PGresAttDesc
  (name c-string)
  (adtid Oid)
  (adtsize short))
 (def-c-struct PGresAttValue
  (len int)
  (value c-pointer))
|#

(def-c-struct PGnotify
  (result (c-array character #.NAMEDATALEN))
  (be_pid int))

(def-c-type PQnoticeProcessor
    (c-function (:arguments (p1 c-pointer) (message c-string))
                (:return-type c-pointer)))

(def-c-type pqbool char)

(def-c-struct PQprintOpt
  (header pqbool)
  (align pqbool)
  (standard pqbool)
  (html3 pqbool)
  (expanded pqbool)
  (pager pqbool)
  (fieldSep c-string)
  (tableOpt c-string)
  (caption c-string)
  (fieldName (c-array-ptr c-string)))

(def-c-struct PQconninfoOption
  (keyword c-string)
  (envvar c-string)
  (compiled c-string)
  (val c-string)
  (label c-string)
  (dispchar c-string)
  (dispsize int))

(def-c-struct PQArgBlock
  (len int)
  (isint int))
  ;(u (c-union (ptr (c-ptr int))
  ;            (integer int))))

(def-call-out PQconnectdb
    (:arguments (conninfo c-string)) (:return-type PGconn))
(def-call-out PQsetdbLogin
    (:arguments (pghost c-string) (pgport c-string) (pgoptions c-string)
                (pgtty c-string) (dbname c-string) (login c-string)
                (pwd c-string))
  (:return-type PGconn))
(defmacro PQsetdb (a0 a1 a2 a3 a4) `(PQsetdbLogin ,a0 ,a1 ,a2 ,a3 ,a4 nil nil))
(def-call-out PQconndefaults
    (:arguments) (:return-type (c-ptr PQconninfoOption)))
(def-call-out PQfinish
    (:arguments (conn PGconn)) (:return-type nil))
(def-call-out PQreset
    (:arguments (conn PGconn)) (:return-type nil))
(def-call-out PQrequestCancel
    (:arguments (conn PGconn)) (:return-type int))
(def-call-out PQdb
    (:arguments (conn PGconn)) (:return-type c-string))
(def-call-out PQuser
    (:arguments (conn PGconn)) (:return-type c-string))
(def-call-out PQpass
    (:arguments (conn PGconn)) (:return-type c-string))
(def-call-out PQhost
    (:arguments (conn PGconn)) (:return-type c-string))
(def-call-out PQport
    (:arguments (conn PGconn)) (:return-type c-string))
(def-call-out PQtty
    (:arguments (conn PGconn)) (:return-type c-string))
(def-call-out PQoptions
    (:arguments (conn PGconn)) (:return-type c-string))
(def-call-out PQstatus
    (:arguments (conn PGconn)) (:return-type ConnStatusType))
(def-call-out PQerrorMessage
    (:arguments (conn PGconn)) (:return-type c-string))
(def-call-out PQsocket
    (:arguments (conn PGconn)) (:return-type int))
(def-call-out PQbackendPID
    (:arguments (conn PGconn)) (:return-type int))
(def-call-out PQtrace
    (:arguments (conn PGconn) (debug_port c-pointer)) ; ?? FILE*
  (:return-type nil))
(def-call-out PQuntrace
    (:arguments (conn PGconn)) (:return-type nil))
(def-call-out PQsetNoticeProcessor ; not in Pg.pm
    (:arguments (conn PGconn) (proc PQnoticeProcessor)
                (arg c-pointer))
  (:return-type nil))
(def-call-out PQexec
    (:arguments (conn PGconn) (query c-string))
  (:return-type PGresult))
(def-call-out PQnotifies
    (:arguments (conn PGconn))
  (:return-type c-pointer :malloc-free)) ; ?? (c-ptr PGnotify)
(def-call-out PQsendQuery
    (:arguments (conn PGconn) (query c-string))
  (:return-type int))
(def-call-out PQgetResult
    (:arguments (conn PGconn))
  (:return-type PGresult))
(def-call-out PQisBusy
    (:arguments (conn PGconn)) (:return-type int))
(def-call-out PQconsumeInput
    (:arguments (conn PGconn)) (:return-type int))
(def-call-out PQgetline
    (:arguments (conn PGconn) (string c-string) (length int))
  (:return-type int))
(def-call-out PQputline
    (:arguments (conn PGconn) (string c-string))
  (:return-type int))
(def-call-out PQgetlineAsync
    (:arguments (conn PGconn) (buffer c-string) (bufsize int))
  (:return-type int))
(def-call-out PQputnbytes
    (:arguments (conn PGconn) (buffer c-string) (nbytes int))
  (:return-type int))
(def-call-out PQendcopy
    (:arguments (conn PGconn)) (:return-type int))
(def-call-out PQfn            ; [security hole] not in Pg.pm
    (:arguments (conn PGconn) (fnid int) (result_buf (c-ptr int))
                (result_len (c-ptr int)) (result_is_int int)
                (args (c-array-ptr PQArgBlock)) (nargs int))
  (:return-type PGresult))
(def-call-out PQmakeEmptyPGresult
    (:arguments (conn PGconn) (status ExecStatusType))
  (:return-type PGresult))
(def-call-out PQresultStatus
    (:arguments (res PGresult)) (:return-type ExecStatusType))
(def-call-out PQresultErrorMessage ; not in Pg.pm
    (:arguments (res PGresult)) (:return-type c-string))
(def-call-out PQntuples
    (:arguments (res PGresult)) (:return-type int))
(def-call-out PQnfields
    (:arguments (res PGresult)) (:return-type int))
(def-call-out PQbinaryTuples
    (:arguments (res PGresult)) (:return-type int))
(def-call-out PQfname
    (:arguments (res PGresult) (field_num int))
  (:return-type c-string))
(def-call-out PQfnumber
    (:arguments (res PGresult) (field_name c-string))
  (:return-type int))
(def-call-out PQftype
    (:arguments (res PGresult) (field_num int)) (:return-type int))
(def-call-out PQfsize
    (:arguments (res PGresult) (field_num int)) (:return-type int))
(def-call-out PQfmod
    (:arguments (res PGresult) (field_num int)) (:return-type int))
(def-call-out PQcmdStatus
    (:arguments (res PGresult)) (:return-type c-string))
(def-call-out PQoidStatus
    (:arguments (res PGresult)) (:return-type c-string))
(def-call-out PQcmdTuples
    (:arguments (res PGresult)) (:return-type c-string))
(def-call-out PQgetvalue
    (:arguments (res PGresult) (tup_num int) (field_num int))
  (:return-type c-string))
(def-call-out PQgetlength
    (:arguments (res PGresult) (tup_num int) (field_num int))
  (:return-type int))
(def-call-out PQgetisnull
    (:arguments (res PGresult) (tup_num int) (field_num int))
  (:return-type int))
(def-call-out PQclear
    (:arguments (res PGresult)) (:return-type nil))
(def-call-out PQprint
    (:arguments (fout c-pointer) ; ?? FILE*
                (res PGresult)
                (ps (c-ptr PQprintOpt)))
  (:return-type nil))
(def-call-out PQdisplayTuples
    (:arguments (res PGresult) (fp c-pointer) ; ?? FILE*
                (fillAlign int)
                (fieldSep c-string) (printHeader int) (quiet int))
  (:return-type nil))
(def-call-out PQprintTuples
    (:arguments (res PGresult) (fout c-pointer) ; ?? FILE*
                (printAttName int) (terseOutput int) (width int))
  (:return-type nil))
(def-call-out PQmblen         ; not in Pg.pm
    (:arguments (s (c-ptr uchar))) (:return-type int))
(def-call-out lo_open
    (:arguments (conn PGconn) (lobjId Oid) (mode int))
  (:return-type int))
(def-call-out lo_close
    (:arguments (conn PGconn) (fd int)) (:return-type int))
(def-call-out lo_read
    (:arguments (conn PGconn) (fd int) (buf c-string) (len int))
  (:return-type int))
(def-call-out lo_write
    (:arguments (conn PGconn) (fd int) (buf c-string) (len int))
  (:return-type int))
(def-call-out lo_lseek
    (:arguments (conn PGconn) (fd int) (offset int) (whence int))
  (:return-type int))
(def-call-out lo_creat
    (:arguments (conn PGconn) (mode int)) (:return-type Oid))
(def-call-out lo_tell
    (:arguments (conn PGconn) (fd int)) (:return-type int))
(def-call-out lo_unlink
    (:arguments (conn PGconn) (lobjId Oid)) (:return-type int))
(def-call-out lo_import
    (:arguments (conn PGconn) (filename c-string))
  (:return-type Oid))
(def-call-out lo_export
    (:arguments (conn PGconn) (lobjId Oid) (filename c-string))
  (:return-type int))

;; not found:
;; PGRES_INV_SMGRMASK
;; PGRES_INV_ARCHIVE
;; PGRES_INV_WRITE
;; PGRES_INV_READ
;; PGRES_InvalidOid


(cl:in-package "CL-USER")
(provide "postgresql")
